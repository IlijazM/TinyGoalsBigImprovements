import 'package:flutter/material.dart';

class CustomTextField extends TextFormField {
  CustomTextField({
    required String labelText,
    bool? autofocus,
    FormFieldValidator<String>? validator,
    String? initialValue,
    ValueChanged<String>? onChange,
    TextInputType? keyboardType,
  }) : super(
          autofocus: autofocus ?? false,
          decoration: InputDecoration(labelText: labelText),
          validator: validator,
          initialValue: initialValue,
          onChanged: onChange,
          keyboardType: keyboardType,
          expands: false,
        );
}
