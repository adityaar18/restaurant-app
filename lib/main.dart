import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fundamental2/data/database/preference_helper.dart';
import 'package:fundamental2/provider/app_provider.dart';
import 'package:fundamental2/provider/preference_provider.dart';
import 'package:fundamental2/provider/settings_provider.dart';
import 'package:fundamental2/services/background_service.dart';
import 'package:fundamental2/services/notification_helper.dart';
import 'package:fundamental2/ui/detail_screen.dart';
import 'package:fundamental2/ui/main_screen.dart';
import 'package:fundamental2/ui/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/nav/navigation.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final _notificationHelper = NotificationHelper();
  final _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) await AndroidAlarmManager.initialize();

  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:  [
        ChangeNotifierProvider<AppProvider>(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => PreferencesProvider(preferencesHelper: PreferencesHelper(
          sharedPreferences:SharedPreferences.getInstance()
        )))
      ],
      child: MaterialApp(
        title: "Restaurant App",
        theme: ThemeData(
            primarySwatch: Colors.amber
        ),
        navigatorKey: navKey,
        initialRoute: MainScreen.routeName,
        routes: {
          MainScreen.routeName: (context) => MainScreen(),
          DetailScreen.routeName: (context) => DetailScreen(
            restaurant: ModalRoute.of(context).settings.arguments as String,
          ),
          SettingsScreen.routeName: (context) => SettingsScreen()
        },
      ),
    );
  }
}