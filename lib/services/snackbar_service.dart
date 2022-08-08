


import 'package:flutter/material.dart';
import 'package:todo_ticker/constants/constant_colors.dart';
import 'package:todo_ticker/constants/constant_styles.dart';

class SnackBarService
{
  final GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  void showSnackBar(String message)
  {
    scaffoldKey.currentState!.showSnackBar( SnackBar(content:  Text(message,style: mediumTextStyle,),duration: const Duration(seconds: 5),backgroundColor: secondaryColor,));
  }


}