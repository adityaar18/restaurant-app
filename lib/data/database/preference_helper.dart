import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({this.sharedPreferences});

  static const notificationNews = 'DAILY_NEWS';

  Future<bool> get isNotificationActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(notificationNews) ?? false;
  }

  void setNotification(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(notificationNews, value);
  }
}