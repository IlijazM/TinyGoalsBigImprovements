import 'package:flutter/material.dart';

class CustomElevatedButton extends Container {
  CustomElevatedButton({
    required String label,
    required onPressed,
  }) : super(
          margin: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 4.0,
          ),
          child: ElevatedButton(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 6.0,
              ),
              child: Text(label),
            ),
            onPressed: onPressed,
          ),
        );
}

class CustomTextButton extends Container {
  CustomTextButton({
    required String label,
    required onPressed,
  }) : super(
          margin: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 4.0,
          ),
          child: TextButton(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 6.0,
              ),
              child: Text(label),
            ),
            onPressed: onPressed,
          ),
        );
}
