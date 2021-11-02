import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmon_chef/core/app_colors.dart';
import 'package:cmon_chef/core/controller.dart';
import 'package:cmon_chef/core/widgets/back_button.dart';
import 'package:cmon_chef/features/home/data/models/random_recipes_response.dart';
import 'package:flutter/material.dart';

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
  CollectionReference wishlist = FirebaseFirestore.instance
      .collection('users')
      .doc(homeController.currentUser.value!.id)
      .collection('wishlist');
  bool isWishlisted = false;
  @override
  void initState() {
    print('recipe ${widget.recipe.id}');
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

  addRecipeToWishlist() async {
    wishlist.doc(widget.recipe.id.toString()).set(
      {
        'id': widget.recipe.id,
        'title': widget.recipe.title,
        'photoUrl': widget.recipe.image,
        'timestamp': DateTime.now(),
      },
    ).then(
      (value) => print('added to firestore'),
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
                                Icon(Icons.watch_later_outlined),
                                Text(' ${widget.recipe.readyInMinutes} mins'),
                              ],
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                print('tapped $isWishlisted');
                                isWishlisted
                                    ? removeFromWishlist()
                                    : addRecipeToWishlist();
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
                              onPressed: () {},
                              icon: Icon(
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
            ),
            CustomBackButton(),
          ],
        ),
      ),
    );
  }
}

