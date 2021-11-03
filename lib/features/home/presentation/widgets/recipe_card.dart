import 'package:cmon_chef/core/app_constants.dart';
import 'package:cmon_chef/features/home/data/models/random_recipes_response.dart';
import 'package:cmon_chef/features/recipe/presentation/pages/recipe_screen.dart';
import 'package:flutter/material.dart';

Widget recipeCard(BuildContext context, Recipe response) {
    return InkWell(
      onTap: () {
        print(response.id);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeScreen(
              recipe: response,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(6.0),
        // height: 200,
        width: 100,
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 1),
              blurRadius: 5,
              color: Colors.grey,
            ),
          ],
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: NetworkImage(response.image ?? placeholderImage),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                response.title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '${response.readyInMinutes} mins',
              ),
            ],
          ),
        ),
      ),
    );
  }