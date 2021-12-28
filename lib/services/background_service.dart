import 'dart:isolate';
import 'dart:ui';
import 'package:fundamental2/data/api/api_service.dart';
import 'package:http/http.dart';

import '../main.dart';
import 'notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService _service;
  static const String _isolateName = 'isolate';

  BackgroundService._createObject();

  factory BackgroundService() {
    _service ??= BackgroundService._createObject();
    return _service;
  }

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await ApiService().getList(Client());
    await _notificationHelper.showNotification(flutterLocalNotificationsPlugin, result);
  }
}
