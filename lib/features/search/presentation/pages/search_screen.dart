import 'package:cmon_chef/core/app_colors.dart';
import 'package:cmon_chef/features/recipe/presentation/pages/recipe_by_id_screen.dart';
import 'package:cmon_chef/features/search/data/data_sources/autocompl_search_ds_impl.dart';
import 'package:cmon_chef/features/search/data/models/autocomplete_search_response.dart';
import 'package:cmon_chef/features/search/presentation/widgets/search_suggestions.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';
  List<AutocompleteSearchResponse> searchResults = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var size = MediaQuery.of(context).size;
    var textStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
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
            // print(result);
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
            icon:const  Icon(
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
                      padding:const  EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Search by Cuisines',
                        style: textStyle,
                      ),
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      children: [
                        searchSuggestions(context, 'Indian'),
                        searchSuggestions(context, 'Chinese'),
                        searchSuggestions(context, 'Mediterranean'),
                        searchSuggestions(context, 'English'),
                        searchSuggestions(context, 'French'),
                        searchSuggestions(context, 'European'),
                        searchSuggestions(context, 'Spanish'),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Search by Meal Type',
                        style: textStyle,
                      ),
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      children: [
                        searchSuggestions(context, 'Drink'),
                        searchSuggestions(context, 'Soup'),
                        searchSuggestions(context, 'Side dish'),
                        searchSuggestions(context, 'Appetizer'),
                        searchSuggestions(context, 'Snack'),
                        searchSuggestions(context, 'Bread'),
                        searchSuggestions(context, 'Dessert'),
                        searchSuggestions(context, 'Breakfast'),
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
                                RecipeByIdScreen(id: searchResults[index].id),
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

  @override
  bool get wantKeepAlive => true;
}
