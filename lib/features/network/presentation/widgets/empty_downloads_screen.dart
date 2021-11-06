import 'package:cmon_chef/core/app_colors.dart';
import 'package:cmon_chef/core/app_constants.dart';
import 'package:flutter/material.dart';

class EmptyDownloadsScreen extends StatelessWidget {
  const EmptyDownloadsScreen({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(size.width * 0.1),
          child: Image.asset(emptyDownloads),
        ),
        const Text(
          'No recipe avaialable offline!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
        ),
        const Text(
          '\nDownload your favourite recipes once you\'re online!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: AppColors.black,
          ),
        ),
      ],
    ));
  }
}
