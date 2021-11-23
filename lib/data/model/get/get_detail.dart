import 'package:flutter/foundation.dart';
import 'package:fundamental2/data/model/restaurant.dart';

class GetDetail {
  GetDetail({@required this.error, @required this.message, @required this.restaurant});

  bool error;
  String message;
  Restaurant restaurant;

  factory GetDetail.fromJson(Map<String, dynamic> json) => GetDetail(
      error: json["error"], message: json["message"], restaurant: Restaurant.fromJson(json["restaurant"]));
}
