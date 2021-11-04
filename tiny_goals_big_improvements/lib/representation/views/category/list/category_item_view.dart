import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiny_goals_big_improvements/domain/category.dart';
import 'package:tiny_goals_big_improvements/representation/views/category/category_controller.dart';

class CategoryItemView extends StatelessWidget {
  final Category category;

  final Function editCallback;

  final Function deleteCallback;

  CategoryItemView({
    Key? key,
    required this.category,
    required this.editCallback,
    required this.deleteCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Text(
            category.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(category.description ?? ''),
          const Spacer(),
          IconButton(
            onPressed: () => editCallback(),
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () => deleteCallback(),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
