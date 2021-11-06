import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmon_chef/core/app_colors.dart';
import 'package:cmon_chef/core/app_constants.dart';
import 'package:cmon_chef/core/app_theme.dart';
import 'package:cmon_chef/core/controller.dart';
import 'package:cmon_chef/core/format_string.dart';
import 'package:cmon_chef/core/widgets/back_button.dart';
import 'package:cmon_chef/features/home/data/models/random_recipes_response.dart';
import 'package:cmon_chef/features/recipe/data/models/offline_recipe.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RecipeScreen extends StatefulWidget {
  final Recipe recipe;
  const RecipeScreen({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  late Box<Offlinerecipe> box;
  CollectionReference wishlist = FirebaseFirestore.instance
      .collection('users')
      .doc(homeController.currentUser.value!.id)
      .collection('wishlist');
  bool isWishlisted = false;
  bool isOffline = false;

  @override
  void initState() {
    box = Hive.box<Offlinerecipe>(recipeBox);
    // print('recipe ${widget.recipe.id}');
    checkRecipeInFirestore();
    super.initState();
  }

  checkRecipeInFirestore() async {
    var doc = await wishlist.doc(widget.recipe.id.toString()).get();
    if (doc.exists) {
      setState(() {
        isWishlisted = true;
      });
    }
  }

  checkRecipeInHive() {
    box.values
        .where((element) => element.id == widget.recipe.id)
        .forEach((element) {
      setState(() {
        isOffline = true;
      });
    });
  }

  removeRecipeFromHive() {
    box.values
        .where((element) => element.id == widget.recipe.id)
        .forEach((element) {
      box.delete(element);
      setState(() {
        isOffline = false;
      });
    });
  }

  addRecipeToHive(Recipe recipe) {
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

  addToWishlist() async {
    wishlist.doc(widget.recipe.id.toString()).set(
      {
        'id': widget.recipe.id,
        'title': widget.recipe.title,
        'photoUrl': widget.recipe.image,
        'timestamp': DateTime.now(),
      },
    );
    checkRecipeInFirestore();
  }

  removeFromWishlist() {
    wishlist.doc(widget.recipe.id.toString()).delete();
    setState(() {
      isWishlisted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var instructionsList =
        FormatString.formatInstructions(widget.recipe.instructions);
    var occasions = FormatString.formatOccasions(widget.recipe.occasions);
    var dishTypes = FormatString.formatOccasions(widget.recipe.dishTypes);
    var diets = FormatString.formatOccasions(widget.recipe.diets);
    var ingredients =
        FormatString.getIngredients(widget.recipe.analyzedInstructions);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            SingleChildScrollView(
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
                        image: NetworkImage(widget.recipe.image),
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
                          widget.recipe.title,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.watch_later_outlined),
                                Text(' ${widget.recipe.readyInMinutes} mins'),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                // print('tapped $isWishlisted');
                                isWishlisted
                                    ? removeFromWishlist()
                                    : addToWishlist();
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
                                addRecipeToHive(widget.recipe);
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
                                      borderRadius: BorderRadius.circular(5.0),
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
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTheme.subHeadingText(size, 'Instructions'),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
            ),
            const CustomBackButton(),
          ],
        ),
      ),
    );
  }
}
