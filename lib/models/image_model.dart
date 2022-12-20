// To parse this JSON data, do
//
//     final imageModel = imageModelFromJson(jsonString);

import 'dart:convert';

ImageModel imageModelFromJson(String str) =>
    ImageModel.fromJson(json.decode(str));

String imageModelToJson(ImageModel data) => json.encode(data.toJson());

class ImageModel {
  ImageModel({
    this.created,
    this.data,
  });

  int? created;
  List<Datum>? data;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        created: json["created"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "created": created,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.url,
  });

  String? url;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
