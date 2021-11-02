// To parse this JSON data, do
//
//     final recipeResponse = recipeResponseFromJson(jsonString);

import 'dart:convert';

RecipeResponse recipeResponseFromJson(String str) => RecipeResponse.fromJson(json.decode(str));

String recipeResponseToJson(RecipeResponse data) => json.encode(data.toJson());

class RecipeResponse {
    RecipeResponse({
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
        required this.winePairing,
        required this.instructions,
        required this.analyzedInstructions,
        required this.originalId,
        required this.spoonacularSourceUrl,
    });

    bool vegetarian;
    bool vegan;
    bool glutenFree;
    bool dairyFree;
    bool veryHealthy;
    bool cheap;
    bool veryPopular;
    bool sustainable;
    num weightWatcherSmartPoints;
    String gaps;
    bool lowFodmap;
    int aggregateLikes;
    num spoonacularScore;
    num healthScore;
    String creditsText;
    String sourceName;
    double pricePerServing;
    List<ExtendedIngredient> extendedIngredients;
    int id;
    String title;
    num readyInMinutes;
    num servings;
    String sourceUrl;
    String image;
    String imageType;
    String summary;
    List<dynamic> cuisines;
    List<String> dishTypes;
    List<String> diets;
    List<dynamic> occasions;
    WinePairing winePairing;
    dynamic instructions;
    List<dynamic> analyzedInstructions;
    dynamic originalId;
    String spoonacularSourceUrl;

    factory RecipeResponse.fromJson(Map<String, dynamic> json) => RecipeResponse(
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
        sourceName: json["sourceName"],
        pricePerServing: json["pricePerServing"].toDouble(),
        extendedIngredients: List<ExtendedIngredient>.from(json["extendedIngredients"].map((x) => ExtendedIngredient.fromJson(x))),
        id: json["id"],
        title: json["title"],
        readyInMinutes: json["readyInMinutes"],
        servings: json["servings"],
        sourceUrl: json["sourceUrl"],
        image: json["image"],
        imageType: json["imageType"],
        summary: json["summary"],
        cuisines: List<dynamic>.from(json["cuisines"].map((x) => x)),
        dishTypes: List<String>.from(json["dishTypes"].map((x) => x)),
        diets: List<String>.from(json["diets"].map((x) => x)),
        occasions: List<dynamic>.from(json["occasions"].map((x) => x)),
        winePairing: WinePairing.fromJson(json["winePairing"]),
        instructions: json["instructions"],
        analyzedInstructions: List<dynamic>.from(json["analyzedInstructions"].map((x) => x)),
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
        "sourceName": sourceName,
        "pricePerServing": pricePerServing,
        "extendedIngredients": List<dynamic>.from(extendedIngredients.map((x) => x.toJson())),
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
        "winePairing": winePairing.toJson(),
        "instructions": instructions,
        "analyzedInstructions": List<dynamic>.from(analyzedInstructions.map((x) => x)),
        "originalId": originalId,
        "spoonacularSourceUrl": spoonacularSourceUrl,
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

    int id;
    String aisle;
    String image;
    String consistency;
    String name;
    String nameClean;
    String original;
    String originalString;
    String originalName;
    num amount;
    String unit;
    List<String> meta;
    List<String> metaInformation;
    Measures measures;

    factory ExtendedIngredient.fromJson(Map<String, dynamic> json) => ExtendedIngredient(
        id: json["id"],
        aisle: json["aisle"],
        image: json["image"],
        consistency: json["consistency"],
        name: json["name"],
        nameClean: json["nameClean"],
        original: json["original"],
        originalString: json["originalString"],
        originalName: json["originalName"],
        amount: json["amount"],
        unit: json["unit"],
        meta: List<String>.from(json["meta"].map((x) => x)),
        metaInformation: List<String>.from(json["metaInformation"].map((x) => x)),
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

    double amount;
    String unitShort;
    String unitLong;

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

class WinePairing {
    WinePairing();

    factory WinePairing.fromJson(Map<String, dynamic> json) => WinePairing(
    );

    Map<String, dynamic> toJson() => {
    };
}
