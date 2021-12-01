import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiny_goals_big_improvements/core/internationalization_util.dart';
import 'package:tiny_goals_big_improvements/representation/views/category/category_controller.dart';
import 'package:tiny_goals_big_improvements/representation/views/category/list/category_item_view.dart';
import 'package:tiny_goals_big_improvements/representation/views/layout/app_bar.dart';
import 'package:tiny_goals_big_improvements/representation/views/layout/drawer.dart';

class CategoryView extends StatefulWidget {
  final CategoryController categoryController;

  CategoryView({Key? key})
      : categoryController = CategoryController(),
        super(key: key);

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  void initState() {
    super.initState();
    widget.categoryController.query();
    widget.categoryController.subscribeToCategories(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: getGlobalAppBar(
          context: context,
          title: l10n(context).core_app_name,
        ),
        drawer: getGlobalDrawer(context),
        body: _build(context),
      );

  Widget _build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  l10n(context).entity_category,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () =>
                      widget.categoryController.requestCreate(context),
                  icon: const Icon(Icons.add_circle),
                ),
              ],
            ),
            _buildListView(),
          ],
        ),
      );

  Widget _buildListView() {
    if (widget.categoryController.categories == null) {
      return const CircularProgressIndicator();
    }

    return ListView(
      shrinkWrap: true,
      children: widget.categoryController.categories!
          .map((category) => CategoryItemView(
                category: category,
                selectCallback: () {
                  widget.categoryController.requestSelect(context, category);
                },
                editCallback: () {
                  widget.categoryController.requestEdit(context, category);
                },
                deleteCallback: () {
                  widget.categoryController.requestDelete(context, category);
                },
              ))
          .toList(),
    );
  }
}
