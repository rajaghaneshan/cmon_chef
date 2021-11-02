import 'package:hive/hive.dart';

part 'offline_recipe.g.dart';

@HiveType(typeId: 0)
class Offlinerecipe {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final num readyInMinutes;
  @HiveField(3)
  final num servings;
  @HiveField(4)
  final String sourceUrl;
  @HiveField(5)
  final String image;
  @HiveField(6)
  final String imageType;
  @HiveField(7)
  final String summary;
  @HiveField(8)
  final List<dynamic> cuisines;
  @HiveField(9)
  final List<String> dishTypes;
  @HiveField(10)
  final List<String> diets;
  @HiveField(11)
  final List<dynamic> occasions;
  @HiveField(12)
  final dynamic instructions;
  @HiveField(13)
  final List<dynamic> analyzedInstructions;
  @HiveField(14)
  final dynamic originalId;

  Offlinerecipe({
    required this.id,
    required this.title,
    required this.readyInMinutes,
    required this.servings,
    required this.sourceUrl,
    required this.image,
    required this.imageType,
    required this.summary,
    required this.cuisines,
    required this.dishTypes,
    required this.diets,
    required this.occasions,
    required this.instructions,
    required this.analyzedInstructions,
    required this.originalId,
  });
}
