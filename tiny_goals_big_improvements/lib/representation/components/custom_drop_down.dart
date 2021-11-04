import 'package:flutter/material.dart';

class CustomDropDown extends DropdownButton {
  CustomDropDown({
    required List<DropdownMenuItem> items,
    required onChanged,
    String? value,
  }) : super(
          isExpanded: true,
          value: value,
          onChanged: onChanged,
          items: items,
        );
}
