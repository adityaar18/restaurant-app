import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:fundamental2/data/model/get/get_restaurant.dart';
import 'package:fundamental2/data/model/get/get_detail.dart';

const String BASE_URL = 'https://restaurant-api.dicoding.dev/';
const String failed_get_data = "Failed to get the data";
const String failed_post_review = "Failed to post review";

class ApiService {
  Future<GetRestaurant> getList() async {
    try {
      final response = await http.get(Uri.parse(BASE_URL + 'list'));
      if (response.statusCode == 200) {
        return GetRestaurant.fromJson(json.decode(response.body));
      } else {
        throw Exception(failed_get_data);
      }
    } catch (e) {
      throw Exception(e.message);
    }
  }

  Future<GetRestaurant> search({String query = ""}) async {
    try {
      final response = await http.get(Uri.parse(BASE_URL + 'search?q=' + query));
      if (response.statusCode == 200) {
        return GetRestaurant.fromJson(json.decode(response.body));
      } else {
        throw Exception(failed_get_data);
      }
    } catch (e) {
      throw Exception(e.message);
    }
  }

  Future<GetDetail> getDetail(String id) async {
    final response = await http.get(Uri.parse(BASE_URL + 'detail/$id'));
    if (response.statusCode == 200) {
      return GetDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception(failed_get_data);
    }
  }
}
