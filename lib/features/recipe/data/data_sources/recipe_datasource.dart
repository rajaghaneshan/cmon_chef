import 'package:cmon_chef/features/recipe/data/models/recipe_response.dart';

abstract class RecipeDataSource {
  Future<RecipeResponse> getRecipeInfo(int id);
}
