import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class Nav{
  static intentData(String routeName, Object arguments){
    navKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static back() => navKey.currentState?.pop();
}