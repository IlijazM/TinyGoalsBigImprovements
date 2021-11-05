import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiny_goals_big_improvements/representation/views/category/category_controller.dart';
import 'package:tiny_goals_big_improvements/representation/views/category/list/category_item_view.dart';

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
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  // TODO: translate
                  'Categories',
                  style: TextStyle(fontWeight: FontWeight.bold),
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
