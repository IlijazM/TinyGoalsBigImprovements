import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:tiny_goals_big_improvements/domain/category.dart';
import 'package:tiny_goals_big_improvements/representation/components/custom_button.dart';
import 'package:tiny_goals_big_improvements/representation/components/custom_dialog.dart';
import 'package:tiny_goals_big_improvements/representation/components/custom_drop_down.dart';
import 'package:tiny_goals_big_improvements/representation/components/custom_text_area.dart';
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

  final _formKey = GlobalKey<FormState>();

  _CategoryUpdateDialogState(Category? _category)
      : category = _category ??
            Category(
              name: 'New Category',
              color: Colors.blue.value,
              icon: '',
            );

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Update Category',
      children: [
        _buildForm(),
        /*
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
        ),*/
      ],
    );
  }

  Widget _buildForm() => SizedBox(
        // must get included else rendering exception get thrown.
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: Column(
            // must get included else rendering exception get thrown.
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildNameTextField(),
              _buildDescriptionTextField(),
              _buildColorPicker(),
              _buildIconPicker(),
              _buildFormControllButtons(),
            ],
          ),
        ),
      );

  Widget _buildNameTextField() => CustomTextField(
        labelText: 'Name',
        validator: _nameValidator,
        initialValue: category.name,
        onChange: (value) => category.name = value,
      );

  Widget _buildDescriptionTextField() => CustomTextArea(
        labelText: 'Description',
        validator: _descriptionValidator,
        initialValue: category.description,
        onChange: (value) => category.description = value,
      );

  Widget _buildColorPicker() => MaterialColorPicker(
        circleSize: 42.0,
        elevation: 1,
        spacing: 6,
        onColorChange: (Color color) => category.color = color.value,
        selectedColor: Color(category.color),
      );

  Widget _buildIconPicker() => CustomDropDown(
        value: category.icon,
        onChanged: (value) => setState(() => category.icon = value),
        items: [
          DropdownMenuItem(
            value: '',
            child: Row(
              children: const [Icon(Icons.circle), Text('   Default')],
            ),
          ),
          ...categoryIcons
              .map(
                (icon) => DropdownMenuItem(
                  value: icon.iconData.codePoint.toString(),
                  child: Row(
                    children: [Icon(icon.iconData), Text('   ' + icon.name)],
                  ),
                ),
              )
              .toList(),
        ],
      );

  Widget _buildFormControllButtons() => Row(
        children: [
          const Spacer(),
          CustomElevatedButton(
            label: "Save",
            onPressed: _submitFunction,
          ),
          CustomTextButton(
            label: "Cancel",
            onPressed: _cancelFunction,
          ),
        ],
      );

  void _submitFunction() {
    if (_formKey.currentState!.validate()) {
      widget.categoryController.save(category);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved Category successfully.')),
      );
      Navigator.pop(context, true);
    }
  }

  void _cancelFunction() {
    Navigator.pop(context, true);
  }

  String? _nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      // TODO: translate
      return 'Please enter some text';
    }
    return null;
  }

  String? _descriptionValidator(String? value) {
    return null;
  }
}
