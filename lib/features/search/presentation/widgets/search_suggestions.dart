import 'package:cmon_chef/core/app_colors.dart';
import 'package:cmon_chef/features/search/presentation/pages/recipes_by_category_screen.dart';
import 'package:flutter/material.dart';

Widget searchSuggestions(BuildContext context, String text) {
    return FittedBox(
      child: InkWell(
        splashColor: AppColors.primary,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipesByCategoryScreen(tags: text),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 6.0,
            horizontal: 10.0,
          ),
          margin: const EdgeInsets.all(6.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(
              color: AppColors.primary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }