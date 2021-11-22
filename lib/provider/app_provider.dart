import 'package:flutter/foundation.dart';
import 'package:fundamental2/data/api/api_service.dart';
import 'package:fundamental2/data/model/response/response_restaurant.dart';
import 'package:fundamental2/data/model/response/response_restaurant_detail.dart';
import 'package:fundamental2/data/model/review.dart';

enum ResultState { Loading, NoData, HasData, Error }

class AppProvider extends ChangeNotifier {
  final ApiService apiService;

  AppProvider({@required this.apiService});

  ResponseRestaurant _responseRestaurant;
  ResponseRestaurantDetail _responseRestaurantDetail;
  ResultState _state;
  String _message;
  String _query = "";

  ResponseRestaurant get result => _responseRestaurant;
  ResponseRestaurantDetail get restaurant => _responseRestaurantDetail;
  ResultState get state => _state;
  String get message => _message;

  AppProvider getRestaurants() {
    _fetchRestaurants();
    return this;
  }

  AppProvider getRestaurant(String id) {
    _fetchRestaurant(id);
    return this;
  }

  Future<dynamic> _fetchRestaurants() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final response = await apiService.search(query: _query);
      if (response.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'No data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _responseRestaurant = response;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = e?.message;
    }
  }

  Future<dynamic> _fetchRestaurant(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final response = await apiService.getDetail(id);
      if (!response.error) {
        _state = ResultState.HasData;
        notifyListeners();
        return _responseRestaurantDetail = response;
      } else {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = "No data found";
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  void onSearch(String query) {
    _query = query;
    _fetchRestaurants();
  }

  Future<dynamic> postReview(Review review) async {
    try {
      final response = await apiService.postReview(review);

      if (!response.error) _fetchRestaurant(review.id);
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
