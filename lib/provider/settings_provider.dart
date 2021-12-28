import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:fundamental2/services/background_service.dart';
import 'package:fundamental2/services/time_helper.dart';

class SettingsProvider extends ChangeNotifier{
  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  Future<bool> activeSchedule(bool value) async{
    _isScheduled = value;
    if(_isScheduled){
      debugPrint('Scheduling info activated');
      debugPrint(DateTimeHelper.format().toIso8601String());
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else{
      debugPrint("Schedule info cancelled");
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}