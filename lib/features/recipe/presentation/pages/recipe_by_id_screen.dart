import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmon_chef/core/app_colors.dart';
import 'package:cmon_chef/core/app_constants.dart';
import 'package:cmon_chef/core/app_theme.dart';
import 'package:cmon_chef/core/controller.dart';
import 'package:cmon_chef/core/error/failures.dart';
import 'package:cmon_chef/core/format_string.dart';
import 'package:cmon_chef/core/widgets/back_button.dart';
import 'package:cmon_chef/core/widgets/error_screen.dart';
import 'package:cmon_chef/core/widgets/loading_indicator.dart';
import 'package:cmon_chef/features/recipe/data/models/offline_recipe.dart';
import 'package:cmon_chef/features/recipe/data/models/recipe_response.dart';
import 'package:cmon_chef/features/recipe/data/repositories/recipe_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart' as either;
import 'package:hive_flutter/hive_flutter.dart';

class RecipeByIdScreen extends StatefulWidget {
  final int id;
  const RecipeByIdScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _RecipeByIdScreenState createState() => _RecipeByIdScreenState();
}

class _RecipeByIdScreenState extends State<RecipeByIdScreen> {
  late Box<Offlinerecipe> box;
  CollectionReference wishlist = FirebaseFirestore.instance
      .collection('users')
      .doc(homeController.currentUser.value!.id)
      .collection('wishlist');
  bool isWishlisted = false;
  bool isOffline = false;

  @override
  void initState() {
    // print('recipe ${widget.id}');
    box = Hive.box<Offlinerecipe>(recipeBox);
    checkRecipeInFirestore();
    checkRecipeInHive();
    super.initState();
  }

  checkRecipeInHive() {
    box.values.where((element) => element.id == widget.id).forEach((element) {
      setState(() {
        isOffline = true;
      });
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
                  return const LoadingIndicator();
                }
                return snapshot.data!.fold(
                  (l) {
                    return const ErrorScreen();
                  },
                  (r) {
                    var instructionsList =
                        FormatString.formatInstructions(r.instructions);
                    var occasions = FormatString.formatOccasions(r.occasions);
                    var dishTypes = FormatString.formatOccasions(r.dishTypes);
                    var diets = FormatString.formatOccasions(r.diets);
                    var ingredients =
                        FormatString.getIngredients(r.analyzedInstructions);

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
                                        const Icon(Icons.watch_later_outlined),
                                        Text(' ${r.readyInMinutes} mins'),
                                      ],
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        // print('tapped $isWishlisted');
                                        isWishlisted
                                            ? removeFromWishlist()
                                            : addRecipeToWishlist(r);
                                      },
                                      icon: isWishlisted
                                          ? const Icon(
                                              Icons.favorite,
                                              color: AppColors.primary,
                                            )
                                          : const Icon(
                                              Icons.favorite_border_outlined,
                                            ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        addRecipeOffline(r);
                                      },
                                      icon: isOffline
                                          ? const Icon(
                                              Icons.download_done_rounded,
                                              color: Colors.green,
                                            )
                                          : const Icon(
                                              Icons.download_outlined,
                                            ),
                                    ),
                                  ],
                                ),
                                AppTheme.subHeadingText(size, 'Ingredients'),
                                Wrap(
                                  children: ingredients
                                      .map(
                                        (e) => Container(
                                          margin: const EdgeInsets.all(4.0),
                                          padding: const EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                width: 2,
                                                color: AppColors.primary,
                                              )),
                                          child: Text(' $e '),
                                        ),
                                      )
                                      .toList(),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppTheme.subHeadingText(
                                          size, 'Instructions'),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: instructionsList
                                            .map((e) => Text('* $e\n'))
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                AppTheme.subHeadingText(size, 'Occasions'),
                                Text(occasions),
                                AppTheme.subHeadingText(size, 'Dish Types'),
                                Text(dishTypes),
                                AppTheme.subHeadingText(size, 'Diets'),
                                Text(diets),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            const CustomBackButton(),
          ],
        ),
      ),
    );
  }
}
