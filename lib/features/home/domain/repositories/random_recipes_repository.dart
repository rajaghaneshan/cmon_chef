import 'package:cmon_chef/core/error/failures.dart';
import 'package:cmon_chef/features/home/data/models/random_recipes_response.dart';
import 'package:dartz/dartz.dart';

abstract class RandomRecipesRepository {
  Future<Either<Failure, RandomRecipesResponse>> getRandomRecipes(String tags);
}
