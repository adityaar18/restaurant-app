import 'dart:convert';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fundamental2/data/model/get/get_restaurant.dart';
import 'package:fundamental2/data/model/restaurant.dart';
import 'package:fundamental2/data/nav/navigation.dart';
import 'package:fundamental2/ui/detail_screen.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper{
  static NotificationHelper _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async{
      if(payload != null) {
        var data = Restaurant.fromJson(json.decode(payload));
        await Nav.intentData(DetailScreen.routeName, data);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, GetRestaurant restaurants) async{
    var restaurant = restaurants.restaurants[Random().nextInt(restaurants.restaurants.length)];
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "Restaurant promotion";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName,
        channelDescription: _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    var titleNotification = "<b>Restaurant Promotion</b>";
    var titleNews = "Recommendation Restaurant For You Today is " + restaurant.name;

    await flutterLocalNotificationsPlugin.show(0, titleNotification, titleNews, platformChannelSpecifics,payload: json.encode(restaurant.toJson()));
   }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
          (String payload) async {
        var data = Restaurant.fromJson(json.decode(payload));
        Nav.intentData(route, data);
      },
    );
  }
}