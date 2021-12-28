import 'package:flutter/cupertino.dart';

class Favorite {
  String id;
  String pictureId;
  String name;
  String city;

  Favorite({
    @required this.id,
    @required this.pictureId,
    @required this.name,
    @required this.city,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pictureId': pictureId,
      'name': name,
      'city': city,
    };
  }

  Favorite.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    pictureId = map['pictureId'];
    name = map['name'];
    city = map['city'];
  }
}
