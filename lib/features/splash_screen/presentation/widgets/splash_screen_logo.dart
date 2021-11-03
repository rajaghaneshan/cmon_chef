import 'package:cmon_chef/core/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreenLogo extends StatelessWidget {
  const SplashScreenLogo({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: size.height * 0.05,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(text: 'C'),
              TextSpan(
                text: '\'',
                style: TextStyle(
                  color: AppColors.accent,
                ),
              ),
              TextSpan(
                text: 'mon',
              ),
            ],
            style: TextStyle(
              color: Colors.white,
              fontSize: 80,
              fontFamily: 'ClementePDa',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          'Chef',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 80,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
