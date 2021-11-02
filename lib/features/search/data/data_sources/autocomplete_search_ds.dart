import 'package:cmon_chef/features/search/data/models/autocomplete_search_response.dart';

abstract class AutocompleteSearchDataSource {
  Future<List<AutocompleteSearchResponse>> getSearchList(String query);
}
