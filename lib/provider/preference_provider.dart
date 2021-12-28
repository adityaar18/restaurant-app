import 'package:flutter/material.dart';
import 'package:fundamental2/data/database/preference_helper.dart';


class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({@required this.preferencesHelper}) {
    _getNotificationPreferences();
  }

  bool _isNotificationRestaurantActive = false;
  bool get isDailyNotificationActive => _isNotificationRestaurantActive;


  void _getNotificationPreferences() async {
    _isNotificationRestaurantActive = await preferencesHelper.isNotificationActive;
    notifyListeners();
  }


  void enableNotification(bool value) {
    preferencesHelper.setNotification(value);
    _getNotificationPreferences();
  }
}
