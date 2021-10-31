import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiny_goals_big_improvements/representation/views/category/category_controller.dart';
import 'package:tiny_goals_big_improvements/representation/views/category/category_item/category_item_view.dart';

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
    widget.categoryController.loadAllCategories();
    widget.categoryController.subscribeToCategories(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              onPressed: () => widget.categoryController.newElement(context),
              icon: const Icon(Icons.add_circle),
            ),
          ],
        ),
        _getListView(),
      ],
    );
  }

  Widget _getListView() {
    if (widget.categoryController.categories == null) {
      return const CircularProgressIndicator();
    }

    return ListView(
      shrinkWrap: true,
      children: widget.categoryController.categories!
          .map((e) => CategoryItemView(
                category: e,
                categoryController: widget.categoryController,
              ))
          .toList(),
    );
  }
}
