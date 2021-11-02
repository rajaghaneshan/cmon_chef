// To parse this JSON data, do
//
//     final autocompleteSearchResponse = autocompleteSearchResponseFromJson(jsonString);

import 'dart:convert';

List<AutocompleteSearchResponse> autocompleteSearchResponseFromJson(String str) => List<AutocompleteSearchResponse>.from(json.decode(str).map((x) => AutocompleteSearchResponse.fromJson(x)));

String autocompleteSearchResponseToJson(List<AutocompleteSearchResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AutocompleteSearchResponse {
    AutocompleteSearchResponse({
        required this.id,
        required this.title,
        required this.imageType,
    });

    int id;
    String title;
    String imageType;

    factory AutocompleteSearchResponse.fromJson(Map<String, dynamic> json) => AutocompleteSearchResponse(
        id: json["id"],
        title: json["title"],
        imageType: json["imageType"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "imageType": imageType,
    };
}
