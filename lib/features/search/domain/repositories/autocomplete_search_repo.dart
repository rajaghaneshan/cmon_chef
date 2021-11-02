import 'package:cmon_chef/core/error/failures.dart';
import 'package:cmon_chef/features/search/data/models/autocomplete_search_response.dart';
import 'package:dartz/dartz.dart';

abstract class AutocompleteSearchRepository {
  Future<Either<Failure, List<AutocompleteSearchResponse>>> getSearchResults(
      String query);
}
