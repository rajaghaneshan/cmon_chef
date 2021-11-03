import 'package:cmon_chef/core/error/exceptions.dart';
import 'package:cmon_chef/features/home/data/data_source/random_recipes_datasrc.dart';
import 'package:cmon_chef/features/home/data/models/random_recipes_response.dart';
import 'package:cmon_chef/core/error/failures.dart';
import 'package:cmon_chef/features/home/domain/repositories/random_recipes_repository.dart';
import 'package:dartz/dartz.dart';

class RandomRecipeRepoImpl implements RandomRecipesRepository {
  @override
  Future<Either<Failure, RandomRecipesResponse>> getRandomRecipes(String tags, int length) async {
    try {
      RandomRecipesResponse response =
          await RandomRecipesDataSourceImpl().getRandomRecipes(length, tags);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
