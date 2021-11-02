import 'package:cmon_chef/core/app_constants.dart';
import 'package:cmon_chef/core/app_urls.dart';
import 'package:cmon_chef/features/home/data/models/random_recipes_response.dart';
import 'package:http/http.dart' as http;

abstract class RandomRecipesDataSource {
  Future<RandomRecipesResponse> getRandomRecipes(int length, String tags);
}
// '$BASE_URL/recipes/random?limitLicense=true&tags=indian&number=1&apiKey=$apiKey'

class RandomRecipesDataSourceImpl implements RandomRecipesDataSource {
  @override
  Future<RandomRecipesResponse> getRandomRecipes(
      int length, String tags) async {
    var client = http.Client();
    String url =
        '$BASE_URL/recipes/random?limitLicense=true&tags=$tags&number=$length&apiKey=$apiKey';

    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print(jsonString);
        RandomRecipesResponse randomRecipesResponse =
            randomRecipesResponseFromJson(jsonString);
        return randomRecipesResponse;
      } else {
        print(response.statusCode.toString());
        throw UnimplementedError();
      }
    } catch (e) {
      print(e.toString());
      throw UnimplementedError();
    }
  }
}
