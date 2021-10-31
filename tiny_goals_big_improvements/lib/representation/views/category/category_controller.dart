import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiny_goals_big_improvements/domain/category.dart';
import 'package:tiny_goals_big_improvements/representation/views/category/update_dialog/category_update_dialog.dart';
import 'package:tiny_goals_big_improvements/service/category_service.dart';

class CategoryController {
  List<Category>? categories;

  List<Function> _categoriesSubscribers = [];

  final CategoryService _categoryService;

  CategoryController() : _categoryService = CategoryService();

  loadAllCategories() async {
    categories = null;
    categories = await _categoryService.getAllCategories();
    _notifyCategoriesSubscribers();
  }

  newElement(final BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CategoryUpdateDialog(
        categoryController: this,
      ),
    );
  }

  saveElement(final Category category) {
    _categoryService.createNewCategory(category);

    // Reload
    loadAllCategories();
  }

  editElement(BuildContext context, Category category) {
    showDialog(
      context: context,
      builder: (context) => CategoryUpdateDialog(
        categoryController: this,
        category: category,
      ),
    );
  }

  deleteElement(Category category) {
    // The id is ensure here because we only get list items for attached models.
    _categoryService.deleteCategory(category.id!);

    // Reload
    loadAllCategories();
  }

  subscribeToCategories(Function callback) =>
      _categoriesSubscribers.add(callback);

  _notifyCategoriesSubscribers() =>
      _categoriesSubscribers.forEach((element) => element());
}
