import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:tiny_goals_big_improvements/domain/category.dart';
import 'package:tiny_goals_big_improvements/representation/components/custom_dialog.dart';
import 'package:tiny_goals_big_improvements/representation/components/custom_text_field.dart';
import 'package:tiny_goals_big_improvements/representation/views/category/category_controller.dart';
import 'package:tiny_goals_big_improvements/representation/views/category/category_icons.dart';

class CategoryUpdateDialog extends StatefulWidget {
  final CategoryController categoryController;

  /// If a category is passed that means that you try to update an category.
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
    return CustomDialog(
      title: 'Update Category',
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
          circleSize: 42.0,
          elevation: 1,
          spacing: 6,
          onColorChange: (Color color) {
            category.color = color.value;
          },
          selectedColor: Color(category.color),
        ),
        /*DropdownButton(
          value: categoryIcons[0],
          icon: const Icon(Icons.arrow_downward),
          items: categoryIcons
              .map(
                (e) => DropdownMenuItem(child: e),
              )
              .toList(),
        ),*/
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                widget.categoryController.save(category);
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
  }
}
