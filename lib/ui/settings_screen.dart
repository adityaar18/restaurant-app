import 'package:flutter/material.dart';
import 'package:fundamental2/provider/preference_provider.dart';
import 'package:fundamental2/provider/settings_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget{
  static const routeName = '/settings_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: Consumer<PreferencesProvider>(
        builder: (context, preferences, _){
          return ListTile(
            title: Text('Notification'),
            trailing: Consumer<SettingsProvider>(
              builder: (context, settings, _){
                return Container(
                  margin: EdgeInsets.all(16.0),
                  child: Switch.adaptive(
                      value: preferences.isDailyNotificationActive,
                      onChanged: (value) async{
                        settings.activeSchedule(value);
                        preferences.enableNotification(value);
                      }),
                );
              },
            ),
          );
        },
      )
    );
  }
}