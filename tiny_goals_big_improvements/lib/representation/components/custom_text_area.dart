import 'package:flutter/material.dart';

class CustomTextArea extends TextFormField {
  CustomTextArea({
    required String labelText,
    bool? autofocus,
    FormFieldValidator<String>? validator,
    String? initialValue,
    ValueChanged<String>? onChange,
  }) : super(
          autofocus: autofocus ?? false,
          decoration: InputDecoration(
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          validator: validator,
          initialValue: initialValue,
          onChanged: onChange,
          maxLines: 8,
          keyboardType: TextInputType.multiline,
        );
}
