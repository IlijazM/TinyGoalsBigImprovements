import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiny_goals_big_improvements/core/internationalization_util.dart';
import 'package:tiny_goals_big_improvements/domain/category.dart';
import 'package:tiny_goals_big_improvements/representation/views/category/update/category_update_dialog.dart';
import 'package:tiny_goals_big_improvements/representation/views/goal/list/goal_view.dart';
import 'package:tiny_goals_big_improvements/service/category_service.dart';

/// The category controller.
///
/// Responsible for everything regarding communicating with the services and requesting ui actions
/// like opening delete modals etc.
class CategoryController {
  List<Category>? categories;

  /// The list of all subscribers.
  List<Function> _categoriesSubscribers = [];

  final CategoryService _categoryService;

  CategoryController() : _categoryService = CategoryService();

  /// Queries all categories and notifies all subscribers.
  query() async {
    categories = null;
    categories = await _categoryService.getAllCategories();
    _notifyCategoriesSubscribers();
  }

  save(final Category category) {
    _categoryService.createNewCategory(category);

    // Reload
    query();
  }

  delete(Category category) {
    // The id is ensure here because we only get list items for attached models.
    _categoryService.deleteCategory(category.id!);

    // Reload
    query();
  }

  requestSelect(BuildContext context, Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GoalView(selectedCategory: category),
        fullscreenDialog: true,
      ),
    );
  }

  /// Request editing a category. If the category is null that means that they will create a new
  /// one.
  requestEdit(BuildContext context, Category? category) {
    showDialog(
      context: context,
      builder: (context) => CategoryUpdateDialog(
        categoryController: this,
        category: category,
      ),
    );
  }

  requestCreate(final BuildContext context) {
    requestEdit(context, null);
  }

  requestDelete(BuildContext context, Category category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l10n(context)
              .entity_delete
              .replaceAll('{}', l10n(context).entity_category)),
          content: Text(l10n(context)
              .entity_delete_confirmation
              .replaceFirst('{}', l10n(context).entity_category)),
          actions: [
            ElevatedButton(
              child: Text(l10n(context).core_yes),
              onPressed: () {
                delete(category);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(l10n(context).core_no),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  subscribeToCategories(Function callback) =>
      _categoriesSubscribers.add(callback);

  _notifyCategoriesSubscribers() =>
      _categoriesSubscribers.forEach((element) => element());
}
