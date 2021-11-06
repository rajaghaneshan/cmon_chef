import 'package:cmon_chef/core/app_colors.dart';
import 'package:flutter/material.dart';

RichText appBarTitleText() {
  return RichText(
    text: const TextSpan(
      children: [
        TextSpan(text: 'C'),
        TextSpan(
          text: '\'',
          style: TextStyle(
            color: AppColors.accent,
          ),
        ),
        TextSpan(
          text: 'mon Chef',
        ),
      ],
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'ClementePDa',
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
