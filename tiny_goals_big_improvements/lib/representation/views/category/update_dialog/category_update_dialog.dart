import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:tiny_goals_big_improvements/domain/category.dart';
import 'package:tiny_goals_big_improvements/representation/views/category/category_controller.dart';

class CategoryUpdateDialog extends StatefulWidget {
  final CategoryController categoryController;

  final Category? category;

  CategoryUpdateDialog({
    Key? key,
    required this.categoryController,
    this.category,
  }) : super(key: key);

  @override
  _CategoryUpdateDialogState createState() =>
      _CategoryUpdateDialogState(category);
}

class _CategoryUpdateDialogState extends State<CategoryUpdateDialog> {
  Category category;

  _CategoryUpdateDialogState(Category? _category)
      : category = _category ??
            Category(
              name: 'New Category',
              color: Colors.blue.value,
              icon: '0xecdb',
            );

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Update Category'),
      children: [
        TextFormField(
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Category name'),
          onChanged: (text) => category.name = text,
          initialValue: category.name,
        ),
        TextFormField(
          maxLines: 8,
          decoration: const InputDecoration(labelText: 'Category description'),
          onChanged: (text) => category.description = text,
          initialValue: category.description,
        ),
        MaterialColorPicker(
          onColorChange: (Color color) {
            category.color = color.value;
          },
          selectedColor: Color(category.color),
        ),
        Row(
          children: [
            Icon(
              IconData(int.parse(category.icon), fontFamily: 'MaterialIcons'),
            ),
            ElevatedButton(onPressed: () {}, child: Text('Choose icon'))
          ],
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                widget.categoryController.saveElement(category);
                Navigator.pop(context, true);
              },
              child: const Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Cancel'),
            ),
          ],
        )
      ],
    );
    /*
    return Form(
      child: Column(
        children: [
          Title(
            color: Colors.black,
            // TODO: translate
            child: const Text('Update Category'),
          ),
        ],
      ),
    ); */
  }
}
