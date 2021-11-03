import 'package:cmon_chef/core/app_colors.dart';
import 'package:cmon_chef/features/recipe/presentation/recipe_screen_id.dart';
import 'package:cmon_chef/features/search/data/data_sources/autocompl_search_ds_impl.dart';
import 'package:cmon_chef/features/search/data/models/autocomplete_search_response.dart';
import 'package:cmon_chef/features/search/data/repositories/autocompl_search_repo_impl.dart';
import 'package:cmon_chef/features/search/presentation/recipes_by_category_screen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';
  List<AutocompleteSearchResponse> searchResults = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search..',
            border: InputBorder.none,
          ),
          cursorColor: AppColors.primary,
          onChanged: (query) async {
            List<AutocompleteSearchResponse> result =
                await AutocompleteSearchDataSourceImpl().getSearchList(query);
            setState(() {
              searchResults = result;
            });
            print(result);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              searchQuery = '';
              _searchController.clear();
              setState(() {
                searchResults.clear();
              });
            },
            icon: Icon(
              Icons.clear,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: size.width * 0.05,
        ),
        child: SingleChildScrollView(
          child: searchResults.isEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Search by Cuisines',
                        style: textStyle,
                      ),
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      children: [
                        searchSuggestions('Indian'),
                        searchSuggestions('Chinese'),
                        searchSuggestions('Mediterranean'),
                        searchSuggestions('English'),
                        searchSuggestions('French'),
                        searchSuggestions('European'),
                        searchSuggestions('Mexican'),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Search by Meal Type',
                        style: textStyle,
                      ),
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      children: [
                        searchSuggestions('Drink'),
                        searchSuggestions('Soup'),
                        searchSuggestions('Side dish'),
                        searchSuggestions('Appetizer'),
                        searchSuggestions('Snack'),
                        searchSuggestions('Bread'),
                        searchSuggestions('Dessert'),
                        searchSuggestions('Breakfast'),
                      ],
                    ),
                  ],
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RecipeScreenId(id: searchResults[index].id),
                          ),
                        );
                      },
                      title: Text(searchResults[index].title),
                    );
                  }),
        ),
      ),
    );
  }

  Widget searchSuggestions(String text) {
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
          padding: EdgeInsets.symmetric(
            vertical: 6.0,
            horizontal: 10.0,
          ),
          margin: EdgeInsets.all(6.0),
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
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
