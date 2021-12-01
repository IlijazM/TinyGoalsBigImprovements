import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:tiny_goals_big_improvements/core/internationalization_util.dart';
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
  bool _update;
  bool _nameNotSet;

  final _formKey = GlobalKey<FormState>();

  _CategoryUpdateDialogState(Category? _category)
      : _update = _category != null,
        _nameNotSet = _category == null,
        category = _category ??
            Category(
              // We need the build context for internationalization so we set the name later.
              name: '',
              color: Colors.blue.value,
              icon: '0xe163',
            );

  @override
  Widget build(BuildContext context) {
    // Set the default name.
    // We need the build context for internationalization.
    if (_nameNotSet) {
      category.name = l10n(context)
          .entity_new
          .replaceFirst('{}', l10n(context).entity_category);
      _nameNotSet = false;
    }

    return CustomDialog(
      title: _update
          ? l10n(context)
              .entity_update
              .replaceFirst('{}', l10n(context).entity_category)
          : l10n(context)
              .entity_create
              .replaceFirst('{}', l10n(context).entity_category),
      children: [
        _buildForm(),
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
              // _buildDescriptionTextField(),
              _buildColorPicker(),
              _buildIconPicker(),
              _buildFormControllButtons(),
            ],
          ),
        ),
      );

  Widget _buildNameTextField() => CustomTextField(
        labelText: l10n(context).entity_category_name,
        validator: _nameValidator,
        initialValue: category.name,
        onChange: (value) => category.name = value,
      );

  Widget _buildDescriptionTextField() => CustomTextArea(
        labelText: l10n(context).entity_category_description,
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
            value: '0xe163',
            child: Row(
              children: [
                const Icon(Icons.circle),
                Text('   ${l10n(context).core_default}')
              ],
            ),
          ),
          ...categoryIcons
              .map(
                (icon) => DropdownMenuItem(
                  value: icon.iconData.codePoint.toString(),
                  child: Row(
                    children: [
                      Icon(icon.iconData),
                      Text('   ' + icon.name(context))
                    ],
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
            label: l10n(context).action_save,
            onPressed: _submitFunction,
          ),
          CustomTextButton(
            label: l10n(context).action_cancel,
            onPressed: _cancelFunction,
          ),
        ],
      );

  void _submitFunction() {
    if (_formKey.currentState!.validate()) {
      widget.categoryController.save(category);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n(context)
                .entity_saved_successfully
                .replaceFirst("{}", l10n(context).entity_category),
          ),
        ),
      );
      Navigator.pop(context, true);
    }
  }

  void _cancelFunction() {
    Navigator.pop(context, true);
  }

  String? _nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return l10n(context).validation_blank;
    }
    return null;
  }

  String? _descriptionValidator(String? value) {
    return null;
  }
}
