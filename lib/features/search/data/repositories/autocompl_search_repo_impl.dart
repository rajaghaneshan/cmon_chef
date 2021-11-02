import 'package:cmon_chef/core/error/exceptions.dart';
import 'package:cmon_chef/features/search/data/data_sources/autocompl_search_ds_impl.dart';
import 'package:cmon_chef/features/search/data/models/autocomplete_search_response.dart';
import 'package:cmon_chef/core/error/failures.dart';
import 'package:cmon_chef/features/search/domain/repositories/autocomplete_search_repo.dart';
import 'package:dartz/dartz.dart';

class AutocompleteSearchRepoImpl implements AutocompleteSearchRepository {
  @override
  Future<Either<Failure, List<AutocompleteSearchResponse>>> getSearchResults(
      String query) async {
    try {
      List<AutocompleteSearchResponse> response =
          await AutocompleteSearchDataSourceImpl().getSearchList(query);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
