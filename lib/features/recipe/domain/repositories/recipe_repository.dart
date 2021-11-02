import 'package:cmon_chef/core/error/failures.dart';
import 'package:cmon_chef/features/recipe/data/models/recipe_response.dart';
import 'package:dartz/dartz.dart';

abstract class RecipeRepository {
  Future<Either<Failure, RecipeResponse>> getRecipe(int id);
}
