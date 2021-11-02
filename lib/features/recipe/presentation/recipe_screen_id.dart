import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmon_chef/core/app_colors.dart';
import 'package:cmon_chef/core/app_constants.dart';
import 'package:cmon_chef/core/controller.dart';
import 'package:cmon_chef/core/error/failures.dart';
import 'package:cmon_chef/core/widgets/back_button.dart';
import 'package:cmon_chef/core/widgets/loading_indicator.dart';
import 'package:cmon_chef/features/recipe/data/models/offline_recipe.dart';
import 'package:cmon_chef/features/recipe/data/models/recipe_response.dart';
import 'package:cmon_chef/features/recipe/data/repositories/recipe_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart' as either;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class RecipeScreenId extends StatefulWidget {
  final int id;
  const RecipeScreenId({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _RecipeScreenIdState createState() => _RecipeScreenIdState();
}

class _RecipeScreenIdState extends State<RecipeScreenId> {
  late Box box;
  CollectionReference wishlist = FirebaseFirestore.instance
      .collection('users')
      .doc(homeController.currentUser.value!.id)
      .collection('wishlist');
  bool isWishlisted = false;
  bool isOffline = false;
  @override
  void initState() {
    print('recipe ${widget.id}');
    box = Hive.box(recipeBox);
    checkRecipeInFirestore();
    checkRecipeInOffline();
    super.initState();
  }

  checkRecipeInOffline() {
    box.values.where((element) {
      if (element['id'] == widget.id) {
        setState(() {
          isOffline = true;
        });
      }
      return true;
    });
  }

  checkRecipeInFirestore() async {
    var doc = await wishlist.doc(widget.id.toString()).get();
    if (doc.exists) {
      setState(() {
        isWishlisted = true;
      });
    }
  }

  addRecipeOffline(RecipeResponse recipe) {
    box.add(
      Offlinerecipe(
        id: recipe.id,
        title: recipe.title,
        readyInMinutes: recipe.readyInMinutes,
        servings: recipe.servings,
        sourceUrl: recipe.sourceUrl,
        image: recipe.image,
        imageType: recipe.imageType,
        summary: recipe.summary,
        cuisines: recipe.cuisines,
        dishTypes: recipe.dishTypes,
        diets: recipe.diets,
        occasions: recipe.occasions,
        instructions: recipe.instructions,
        analyzedInstructions: recipe.analyzedInstructions,
        originalId: recipe.originalId,
      ),
    );
    setState(() {
      isOffline = true;
    });
  }

  addRecipeToWishlist(RecipeResponse recipe) async {
    wishlist.doc(widget.id.toString()).set(
      {
        'id': recipe.id,
        'title': recipe.title,
        'photoUrl': recipe.image,
        'timestamp': DateTime.now(),
      },
    ).then(
      (value) => print('added to firestore'),
    );
    checkRecipeInFirestore();
  }

  removeFromWishlist() {
    wishlist.doc(widget.id.toString()).delete();
    setState(() {
      isWishlisted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder<either.Either<Failure, RecipeResponse>>(
                future: RecipeRepoImpl().getRecipe(widget.id),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return LoadingIndicator();
                  }
                  return snapshot.data!.fold((l) {
                    return Center(
                      child: Text('Error loading API'),
                    );
                  }, (r) {
                    return SingleChildScrollView(
                      // controller: controller,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              image: DecorationImage(
                                image: NetworkImage(r.image),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.02,
                              vertical: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  r.title,
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.watch_later_outlined),
                                        Text(' ${r.readyInMinutes} mins'),
                                      ],
                                    ),
                                    Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        print('tapped $isWishlisted');
                                        isWishlisted
                                            ? removeFromWishlist()
                                            : addRecipeToWishlist(r);
                                      },
                                      icon: isWishlisted
                                          ? Icon(
                                              Icons.favorite,
                                              color: AppColors.primary,
                                            )
                                          : Icon(
                                              Icons.favorite_border_outlined,
                                            ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        addRecipeOffline(r);
                                      },
                                      icon: isOffline
                                          ? Icon(
                                              Icons.download_done_rounded,
                                              color: Colors.green,
                                            )
                                          : Icon(
                                              Icons.download_outlined,
                                            ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
                }),
            CustomBackButton(),
          ],
        ),
      ),
    );
  }
}
