import 'package:cmon_chef/core/app_constants.dart';
import 'package:flutter/material.dart';

import '../app_colors.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(cookingError),
        const Text(
          'Oops! Something went Wrong',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 30,
            height: 1.5,
            color: AppColors.primary,
          ),
        )
      ],
    );
  }
}
