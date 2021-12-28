import 'package:flutter/foundation.dart';
import 'package:fundamental2/data/api/api_service.dart';
import 'package:fundamental2/data/database/database_helper.dart';
import 'package:fundamental2/data/model/favorite.dart';
import 'package:fundamental2/data/model/get/get_restaurant.dart';
import 'package:fundamental2/data/model/get/get_detail.dart';
import 'package:http/http.dart';

enum ResultState { Loading, NoData, HasData, Error }

class AppProvider extends ChangeNotifier {
  final ApiService apiService= ApiService();
  final DatabaseHelper databaseHelper  = DatabaseHelper();

  List<Favorite> _favorites = [];
  List<Favorite> get favorites => _favorites;

  GetRestaurant _responseRestaurant;
  GetDetail _responseRestaurantDetail;
  ResultState _state;
  String _message;
  String _query = "";

  GetRestaurant get result => _responseRestaurant;
  GetDetail get restaurant => _responseRestaurantDetail;
  ResultState get state => _state;
  String get message => _message;

  AppProvider(){
    _fetchRestaurants();
    _getFavorites();
  }

  AppProvider getRestaurants() {
    _fetchRestaurants();
    return this;
  }

  AppProvider getRestaurant(String id) {
    _fetchRestaurant(id);
    return this;
  }

  AppProvider listFavorite() {
    _getFavorites();
    return this;
  }

  Future<dynamic> _fetchRestaurants() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      if (_query == ""){
        final response = await apiService.getRestaurants();
        if (response.restaurants.isEmpty) {
          _state = ResultState.NoData;
          notifyListeners();
          return _message = 'No data';
        } else {
          _state = ResultState.HasData;
          notifyListeners();
          return _responseRestaurant = response;
        }
      }else{
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

  void _getFavorites() async {
    _favorites = await databaseHelper.getFavorites();
    notifyListeners();
  }

  Future<bool> getFavoriteById(String id) async =>
      await databaseHelper.getFavoriteById(id);

  void addFavorite(Favorite favorite) async {
    await databaseHelper.addFavorite(favorite);
    _getFavorites();
  }

  void removeFavorite(String id) async {
    await databaseHelper.removeFavorite(id);
    notifyListeners();
    _getFavorites();
  }
}
