import 'package:flutter/material.dart';

class AppTheme {
  static Widget subHeadingText(Size size, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.width * 0.02),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
