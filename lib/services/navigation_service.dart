import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName,{isStackCleared=false}) {
   if(!isStackCleared) {
     return navigatorKey.currentState!.pushNamed(routeName);
   }
   else {
     return navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName,(d)=>false);
   }
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}