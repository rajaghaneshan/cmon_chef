import 'package:cmon_chef/core/error/exceptions.dart';
import 'package:cmon_chef/features/recipe/data/data_sources/recipe_datasource_impl.dart';
import 'package:cmon_chef/features/recipe/data/models/recipe_response.dart';
import 'package:cmon_chef/core/error/failures.dart';
import 'package:cmon_chef/features/recipe/domain/repositories/recipe_repository.dart';
import 'package:dartz/dartz.dart';

class RecipeRepoImpl implements RecipeRepository {
  @override
  Future<Either<Failure, RecipeResponse>> getRecipe(int id) async {
    try {
      RecipeResponse response = await RecipeDataSoruceImpl().getRecipeInfo(id);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
