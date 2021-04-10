// To parse this JSON data, do
//
//     final linkedinModel = linkedinModelFromJson(jsonString);

import 'dart:convert';

LinkedinModel linkedinModelFromJson(String str) =>
    LinkedinModel.fromJson(json.decode(str));

String linkedinModelToJson(LinkedinModel data) => json.encode(data.toJson());

class LinkedinModel {
  LinkedinModel({
    this.name,
    this.organisation,
    this.maxCount,
    this.language,
  });

  String name;
  String organisation;
  String maxCount;
  String language;

  factory LinkedinModel.fromJson(Map<String, dynamic> json) => LinkedinModel(
        name: json["name"],
        organisation: json["organisation"],
        maxCount: json["max_count"],
        language: json["language"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "organisation": organisation,
        "max_count": maxCount,
        "language": language,
      };
}
