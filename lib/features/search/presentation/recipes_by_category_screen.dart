import 'package:cmon_chef/core/app_colors.dart';
import 'package:cmon_chef/core/app_constants.dart';
import 'package:cmon_chef/core/error/failures.dart';
import 'package:cmon_chef/core/widgets/loading_indicator.dart';
import 'package:cmon_chef/features/home/data/models/random_recipes_response.dart';
import 'package:cmon_chef/features/home/data/repositories/randomrecipes_repo_impl.dart';
import 'package:cmon_chef/features/recipe/presentation/recipe_screen.dart';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart' as either;

class RecipesByCategoryScreen extends StatefulWidget {
  final String tags;
  const RecipesByCategoryScreen({
    Key? key,
    required this.tags,
  }) : super(key: key);

  @override
  _RecipesByCategoryScreenState createState() =>
      _RecipesByCategoryScreenState();
}

class _RecipesByCategoryScreenState extends State<RecipesByCategoryScreen> {
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          widget.tags,
          style: TextStyle(color: AppColors.primary),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            FutureBuilder<either.Either<Failure, RandomRecipesResponse>>(
              future: RandomRecipeRepoImpl()
                  .getRandomRecipes(widget.tags.toLowerCase(), 20),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return LoadingIndicator();
                }
                return snapshot.data!.fold(
                  (l) {
                    return Text('API error');
                  },
                  (r) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: size.width * 0.03,
                        mainAxisSpacing: size.width * 0.03,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: r.recipes.length,
                      controller: _scrollController,
                      // physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var data = r.recipes[index];
                        return wishlistCard(data);
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget wishlistCard(Recipe data) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeScreen(
              recipe: data,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 0.5, color: AppColors.accent),
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 2),
              color: AppColors.accent,
              blurRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 130,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    data.image ?? placeholder_image,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                data.title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
