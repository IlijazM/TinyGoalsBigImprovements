import 'package:flutter/material.dart';

class CustomTextField extends TextFormField {
  CustomTextField({required String labelText, bool? autofocus})
      : super(
          autofocus: autofocus ?? false,
          decoration: InputDecoration(labelText: labelText),
        );
}
