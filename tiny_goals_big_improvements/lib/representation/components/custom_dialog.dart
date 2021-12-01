import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog extends SimpleDialog {
  CustomDialog({required String title, required List<Widget> children})
      : super(
          title: Text(title),
          contentPadding: const EdgeInsets.all(25.0),
          children: children,
        );
}
