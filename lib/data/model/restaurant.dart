import 'package:flutter/foundation.dart';
import 'package:fundamental2/data/model/categories.dart';
import 'menus.dart';

const String BASE_URL = 'https://restaurant-api.dicoding.dev/';
const String IMG_SMALL_URL = BASE_URL + "images/small/";
const String IMG_MEDIUM_URL = BASE_URL + "images/medium/";
const String IMG_LARGE_URL = BASE_URL + "images/large/";

class Restaurant {
  Restaurant(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.pictureId,
      @required this.city,
      @required this.rating,
      this.address,
      this.categories,
      this.menus});

  String id;
  String name;
  String description;
  String pictureId;
  String address;
  String city;
  double rating;
  List<Categories> categories;
  Menus menus;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      pictureId: json["pictureId"],
      address: json["address"] == null ? null : json["address"],
      city: json["city"],
      rating: json["rating"].toDouble(),
      categories: json["categories"] == null
          ? null
          : List<Categories>.from(json['categories'].map((x) => Categories.fromJson(x))),
      menus: json["menus"] == null ? null : Menus.fromJson(json["menus"]));

  String getSmallPicture() => IMG_SMALL_URL + this.pictureId;

  String getMediumPicture() => IMG_MEDIUM_URL + this.pictureId;

  String getLargePicture() => IMG_LARGE_URL + this.pictureId;
}
