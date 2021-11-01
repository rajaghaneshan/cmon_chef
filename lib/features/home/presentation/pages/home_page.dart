import 'package:cmon_chef/core/app_colors.dart';
import 'package:cmon_chef/core/widgets/loading_indicator.dart';
import 'package:cmon_chef/features/home/data/data_source/random_recipes_datasrc.dart';
import 'package:cmon_chef/features/home/data/models/random_recipes_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
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
            children: [
              // FutureBuilder<RandomRecipesResponse>(
              //     future: RandomRecipesDataSourceImpl()
              //         .getRandomRecipes(10, 'indian'),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData && snapshot.data!.recipes.length > 0) {
              //         return
              ListView.builder(
                shrinkWrap: true,
                controller: _scrollController,
                itemCount:
                    // snapshot.data!.recipes.length
                    10,
                itemBuilder: (BuildContext context, index) {
                  return Container();
                  // RecipeOverviewCard(
                  //   response: snapshot.data!.recipes[index],
                  // );
                  // });
                  // }
                  // return LoadingIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  RichText appBarTitleText() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: 'C'),
          TextSpan(
            text: '\'',
            style: TextStyle(
              color: AppColors.accent,
            ),
          ),
          TextSpan(
            text: 'mon Chef',
          ),
        ],
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'ClementePDa',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class RecipeOverviewCard extends StatelessWidget {
  final Recipe response;
  const RecipeOverviewCard({
    Key? key,
    required this.response,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary,
              offset: Offset(0, 20),
              blurRadius: 30,
            ),
          ]),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(
                    response.image ??
                        'https://spoonacular.com/recipeImages/640634-556x370.jpg',
                  ),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.02,
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${response.title}',
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                Text(
                  '${response.summary}',
                  maxLines: 3,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
