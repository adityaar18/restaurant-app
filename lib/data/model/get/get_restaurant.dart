import 'package:flutter/foundation.dart';
import 'package:fundamental2/data/model/restaurant.dart';

class GetRestaurant {
  GetRestaurant(
      {@required this.error, @required this.message, @required this.count, @required this.restaurants});

  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  factory GetRestaurant.fromJson(Map<String, dynamic> json) => GetRestaurant(
      error: json['error'],
      message: json['message'],
      count: json['count'],
      restaurants: List<Restaurant>.from(json['restaurants'].map((x) => Restaurant.fromJson(x))));
}
