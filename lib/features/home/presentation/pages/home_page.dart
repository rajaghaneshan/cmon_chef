import 'package:cmon_chef/core/app_colors.dart';
import 'package:cmon_chef/core/controller.dart';
import 'package:cmon_chef/core/error/failures.dart';
import 'package:cmon_chef/core/widgets/appbar_title.dart';
import 'package:cmon_chef/core/widgets/loading_indicator.dart';
import 'package:cmon_chef/features/home/data/data_source/random_recipes_datasrc.dart';
import 'package:cmon_chef/features/home/data/models/random_recipes_response.dart';
import 'package:cmon_chef/features/home/data/repositories/randomrecipes_repo_impl.dart';
import 'package:cmon_chef/features/recipe/presentation/recipe_screen.dart';
import 'package:dartz/dartz.dart' as either;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: appBarTitleText(),
      ),
      body: SingleChildScrollView(
        // controller: _scrollController,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: size.width * 0.02, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Hi ${homeController.currentUser.value!.displayName}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Here are some Indian recipes for you',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              FutureBuilder<either.Either<Failure, RandomRecipesResponse>>(
                  future: RandomRecipeRepoImpl().getRandomRecipes('indian'),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return LoadingIndicator();
                    }
                    return snapshot.data!.fold(
                      (l) {
                        return Text('API error');
                      },
                      (r) {
                        return SizedBox(
                          height: 150,
                          child: ListView.builder(
                            shrinkWrap: true,
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: r.recipes.length,
                            itemBuilder: (BuildContext context, index) {
                              return recipeCard(
                                r.recipes[index],
                              );
                            },
                          ),
                        );
                      },
                    );
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Quick Snacks worth giving a try!',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              FutureBuilder<either.Either<Failure, RandomRecipesResponse>>(
                  future: RandomRecipeRepoImpl().getRandomRecipes('snack'),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return LoadingIndicator();
                    }
                    return snapshot.data!.fold(
                      (l) {
                        return Text('API error');
                      },
                      (r) {
                        return SizedBox(
                          height: 150,
                          child: ListView.builder(
                            shrinkWrap: true,
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: r.recipes.length,
                            itemBuilder: (BuildContext context, index) {
                              return recipeCard(
                                r.recipes[index],
                              );
                            },
                          ),
                        );
                      },
                    );
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Other cuisines you might love!',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              FutureBuilder<either.Either<Failure, RandomRecipesResponse>>(
                future: RandomRecipeRepoImpl().getRandomRecipes(''),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return LoadingIndicator();
                  }
                  return snapshot.data!.fold(
                    (l) {
                      return Text('API error');
                    },
                    (r) {
                      return SizedBox(
                        height: 150,
                        child: ListView.builder(
                          shrinkWrap: true,
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: r.recipes.length,
                          itemBuilder: (BuildContext context, index) {
                            return recipeCard(
                              r.recipes[index],
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget recipeCard(Recipe response) {
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
            image: NetworkImage(response.image),
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

  @override
  bool get wantKeepAlive => true;
}
