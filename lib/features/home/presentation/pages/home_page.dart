import 'package:cmon_chef/core/app_colors.dart';
import 'package:cmon_chef/core/controller.dart';
import 'package:cmon_chef/core/error/failures.dart';
import 'package:cmon_chef/core/widgets/appbar_title.dart';
import 'package:cmon_chef/core/widgets/error_screen.dart';
import 'package:cmon_chef/core/widgets/loading_indicator.dart';
import 'package:cmon_chef/features/home/data/models/random_recipes_response.dart';
import 'package:cmon_chef/features/home/data/repositories/randomrecipes_repo_impl.dart';
import 'package:cmon_chef/features/home/presentation/widgets/recipe_card.dart';
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
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
                  future: RandomRecipeRepoImpl().getRandomRecipes('indian', 5),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const LoadingIndicator();
                    }
                    return snapshot.data!.fold(
                      (l) {
                        return const ErrorScreen();
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
                                context,
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
                  future: RandomRecipeRepoImpl().getRandomRecipes('snack', 5),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const LoadingIndicator();
                    }
                    return snapshot.data!.fold(
                      (l) {
                        return const Center(child: Text('API error'));
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
                                context,
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
                future: RandomRecipeRepoImpl().getRandomRecipes('', 5),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const LoadingIndicator();
                  }
                  return snapshot.data!.fold(
                    (l) {
                      return const Center(child: Text('API error'));
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
                              context,
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

  @override
  bool get wantKeepAlive => true;
}
