import 'package:cmon_chef/core/app_constants.dart';
import 'package:cmon_chef/core/app_urls.dart';
import 'package:cmon_chef/core/error/exceptions.dart';
import 'package:cmon_chef/features/search/data/data_sources/autocomplete_search_ds.dart';
import 'package:cmon_chef/features/search/data/models/autocomplete_search_response.dart';
import 'package:http/http.dart' as http;

class AutocompleteSearchDataSourceImpl implements AutocompleteSearchDataSource {
  @override
  Future<List<AutocompleteSearchResponse>> getSearchList(String query) async {
    var client = http.Client();
    String url =
        '$BASE_URL/recipes/autocomplete?query=$query&number=5&apiKey=$apiKey';
    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print(jsonString);
        List<AutocompleteSearchResponse> autoCompleteSearchResponse =
            autocompleteSearchResponseFromJson(jsonString);
        return autoCompleteSearchResponse;
      } else {
        print(response.statusCode.toString());
        throw ServerException();
      }
    } catch (e) {
      print(e.toString());
      throw ServerException();
    }
  }
}
