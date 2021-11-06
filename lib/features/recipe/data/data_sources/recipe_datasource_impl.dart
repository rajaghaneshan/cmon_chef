import 'package:cmon_chef/core/app_constants.dart';
import 'package:cmon_chef/core/app_urls.dart';
import 'package:cmon_chef/core/error/exceptions.dart';
import 'package:cmon_chef/features/recipe/data/data_sources/recipe_datasource.dart';
import 'package:cmon_chef/features/recipe/data/models/recipe_response.dart';
import 'package:http/http.dart' as http;

class RecipeDataSoruceImpl implements RecipeDataSource {
  @override
  Future<RecipeResponse> getRecipeInfo(int id) async {
    var client = http.Client();
    String url =
        '$BASE_URL/recipes/$id/information?includeNutrition=false&apiKey=$API_KEY';

    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        // print(jsonString);
        RecipeResponse randomRecipesResponse =
            recipeResponseFromJson(jsonString);
        return randomRecipesResponse;
      } else {
        // print(response.statusCode.toString());
        throw ServerException();
      }
    } catch (e) {
      // print(e.toString());
      throw ServerException();
    }
  }
}
