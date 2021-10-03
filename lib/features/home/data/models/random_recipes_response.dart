import 'dart:convert';

RandomRecipesResponse randomRecipesResponseFromJson(String str) =>
    RandomRecipesResponse.fromJson(json.decode(str));

String randomRecipesResponseToJson(RandomRecipesResponse data) =>
    json.encode(data.toJson());

class RandomRecipesResponse {
  RandomRecipesResponse({
    required this.recipes,
  });

  List<Recipe> recipes;

  factory RandomRecipesResponse.fromJson(Map<String, dynamic> json) =>
      RandomRecipesResponse(
        recipes:
            List<Recipe>.from(json["recipes"].map((x) => Recipe.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "recipes": List<dynamic>.from(recipes.map((x) => x.toJson())),
      };
}

class Recipe {
  Recipe({
    required this.vegetarian,
    required this.vegan,
    required this.glutenFree,
    required this.dairyFree,
    required this.veryHealthy,
    required this.cheap,
    required this.veryPopular,
    required this.sustainable,
    required this.weightWatcherSmartPoints,
    required this.gaps,
    required this.lowFodmap,
    required this.aggregateLikes,
    required this.spoonacularScore,
    required this.healthScore,
    required this.creditsText,
    required this.license,
    required this.sourceName,
    required this.pricePerServing,
    required this.extendedIngredients,
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
    required this.spoonacularSourceUrl,
  });

  dynamic vegetarian;
  dynamic vegan;
  dynamic glutenFree;
  dynamic dairyFree;
  dynamic veryHealthy;
  dynamic cheap;
  dynamic veryPopular;
  dynamic sustainable;
  dynamic weightWatcherSmartPoints;
  dynamic gaps;
  dynamic lowFodmap;
  dynamic aggregateLikes;
  dynamic spoonacularScore;
  dynamic healthScore;
  dynamic creditsText;
  dynamic license;
  dynamic sourceName;
  dynamic pricePerServing;
  List<ExtendedIngredient> extendedIngredients;
  dynamic id;
  dynamic title;
  dynamic readyInMinutes;
  dynamic servings;
  dynamic sourceUrl;
  dynamic image;
  dynamic imageType;
  dynamic summary;
  List<dynamic> cuisines;
  List<dynamic> dishTypes;
  List<dynamic> diets;
  List<dynamic> occasions;
  dynamic instructions;
  List<AnalyzedInstruction> analyzedInstructions;
  dynamic originalId;
  dynamic spoonacularSourceUrl;

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        vegetarian: json["vegetarian"],
        vegan: json["vegan"],
        glutenFree: json["glutenFree"],
        dairyFree: json["dairyFree"],
        veryHealthy: json["veryHealthy"],
        cheap: json["cheap"],
        veryPopular: json["veryPopular"],
        sustainable: json["sustainable"],
        weightWatcherSmartPoints: json["weightWatcherSmartPoints"],
        gaps: json["gaps"],
        lowFodmap: json["lowFodmap"],
        aggregateLikes: json["aggregateLikes"],
        spoonacularScore: json["spoonacularScore"],
        healthScore: json["healthScore"],
        creditsText: json["creditsText"],
        license: json["license"],
        sourceName: json["sourceName"],
        pricePerServing: json["pricePerServing"].toDouble(),
        extendedIngredients: List<ExtendedIngredient>.from(
            json["extendedIngredients"]
                .map((x) => ExtendedIngredient.fromJson(x))),
        id: json["id"],
        title: json["title"],
        readyInMinutes: json["readyInMinutes"],
        servings: json["servings"],
        sourceUrl: json["sourceUrl"],
        image: json["image"],
        imageType: json["imageType"],
        summary: json["summary"],
        cuisines: List<String>.from(json["cuisines"].map((x) => x)),
        dishTypes: List<dynamic>.from(json["dishTypes"].map((x) => x)),
        diets: List<String>.from(json["diets"].map((x) => x)),
        occasions: List<dynamic>.from(json["occasions"].map((x) => x)),
        instructions: json["instructions"],
        analyzedInstructions: List<AnalyzedInstruction>.from(
            json["analyzedInstructions"]
                .map((x) => AnalyzedInstruction.fromJson(x))),
        originalId: json["originalId"],
        spoonacularSourceUrl: json["spoonacularSourceUrl"],
      );

  Map<String, dynamic> toJson() => {
        "vegetarian": vegetarian,
        "vegan": vegan,
        "glutenFree": glutenFree,
        "dairyFree": dairyFree,
        "veryHealthy": veryHealthy,
        "cheap": cheap,
        "veryPopular": veryPopular,
        "sustainable": sustainable,
        "weightWatcherSmartPoints": weightWatcherSmartPoints,
        "gaps": gaps,
        "lowFodmap": lowFodmap,
        "aggregateLikes": aggregateLikes,
        "spoonacularScore": spoonacularScore,
        "healthScore": healthScore,
        "creditsText": creditsText,
        "license": license,
        "sourceName": sourceName,
        "pricePerServing": pricePerServing,
        "extendedIngredients":
            List<dynamic>.from(extendedIngredients.map((x) => x.toJson())),
        "id": id,
        "title": title,
        "readyInMinutes": readyInMinutes,
        "servings": servings,
        "sourceUrl": sourceUrl,
        "image": image,
        "imageType": imageType,
        "summary": summary,
        "cuisines": List<dynamic>.from(cuisines.map((x) => x)),
        "dishTypes": List<dynamic>.from(dishTypes.map((x) => x)),
        "diets": List<dynamic>.from(diets.map((x) => x)),
        "occasions": List<dynamic>.from(occasions.map((x) => x)),
        "instructions": instructions,
        "analyzedInstructions":
            List<dynamic>.from(analyzedInstructions.map((x) => x.toJson())),
        "originalId": originalId,
        "spoonacularSourceUrl": spoonacularSourceUrl,
      };
}

class AnalyzedInstruction {
  AnalyzedInstruction({
    required this.name,
    required this.steps,
  });

  dynamic name;
  List<Step> steps;

  factory AnalyzedInstruction.fromJson(Map<String, dynamic> json) =>
      AnalyzedInstruction(
        name: json["name"],
        steps: List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
      };
}

class Step {
  Step({
    required this.number,
    required this.step,
    required this.ingredients,
    required this.equipment,
    required this.length,
  });

  dynamic number;
  dynamic step;
  List<Ent> ingredients;
  List<Ent> equipment;
  Length? length;

  factory Step.fromJson(Map<String, dynamic> json) => Step(
        number: json["number"],
        step: json["step"],
        ingredients:
            List<Ent>.from(json["ingredients"].map((x) => Ent.fromJson(x))),
        equipment:
            List<Ent>.from(json["equipment"].map((x) => Ent.fromJson(x))),
        length: json["length"] == null ? null : Length.fromJson(json["length"]),
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "step": step,
        "ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
        "equipment": List<dynamic>.from(equipment.map((x) => x.toJson())),
        "length": length == null ? null : length!.toJson(),
      };
}

class Ent {
  Ent({
    required this.id,
    required this.name,
    required this.localizedName,
    required this.image,
  });

  dynamic id;
  dynamic name;
  dynamic localizedName;
  dynamic image;

  factory Ent.fromJson(Map<String, dynamic> json) => Ent(
        id: json["id"],
        name: json["name"],
        localizedName: json["localizedName"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "localizedName": localizedName,
        "image": image,
      };
}

class Length {
  Length({
    required this.number,
    required this.unit,
  });

  dynamic number;
  dynamic unit;

  factory Length.fromJson(Map<String, dynamic> json) => Length(
        number: json["number"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "unit": unit,
      };
}

class ExtendedIngredient {
  ExtendedIngredient({
    required this.id,
    required this.aisle,
    required this.image,
    required this.consistency,
    required this.name,
    required this.nameClean,
    required this.original,
    required this.originalString,
    required this.originalName,
    required this.amount,
    required this.unit,
    required this.meta,
    required this.metaInformation,
    required this.measures,
  });

  dynamic id;
  dynamic aisle;
  dynamic image;
  dynamic consistency;
  dynamic name;
  dynamic nameClean;
  dynamic original;
  dynamic originalString;
  dynamic originalName;
  dynamic amount;
  dynamic unit;
  List<dynamic> meta;
  List<dynamic> metaInformation;
  Measures measures;

  factory ExtendedIngredient.fromJson(Map<String, dynamic> json) =>
      ExtendedIngredient(
        id: json["id"],
        aisle: json["aisle"],
        image: json["image"],
        consistency: json["consistency"],
        name: json["name"],
        nameClean: json["nameClean"],
        original: json["original"],
        originalString: json["originalString"],
        originalName: json["originalName"],
        amount: json["amount"].toDouble(),
        unit: json["unit"],
        meta: List<String>.from(json["meta"].map((x) => x)),
        metaInformation:
            List<String>.from(json["metaInformation"].map((x) => x)),
        measures: Measures.fromJson(json["measures"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "aisle": aisle,
        "image": image,
        "consistency": consistency,
        "name": name,
        "nameClean": nameClean,
        "original": original,
        "originalString": originalString,
        "originalName": originalName,
        "amount": amount,
        "unit": unit,
        "meta": List<dynamic>.from(meta.map((x) => x)),
        "metaInformation": List<dynamic>.from(metaInformation.map((x) => x)),
        "measures": measures.toJson(),
      };
}

class Measures {
  Measures({
    required this.us,
    required this.metric,
  });

  Metric us;
  Metric metric;

  factory Measures.fromJson(Map<String, dynamic> json) => Measures(
        us: Metric.fromJson(json["us"]),
        metric: Metric.fromJson(json["metric"]),
      );

  Map<String, dynamic> toJson() => {
        "us": us.toJson(),
        "metric": metric.toJson(),
      };
}

class Metric {
  Metric({
    required this.amount,
    required this.unitShort,
    required this.unitLong,
  });

  dynamic amount;
  dynamic unitShort;
  dynamic unitLong;

  factory Metric.fromJson(Map<String, dynamic> json) => Metric(
        amount: json["amount"].toDouble(),
        unitShort: json["unitShort"],
        unitLong: json["unitLong"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "unitShort": unitShort,
        "unitLong": unitLong,
      };
}
