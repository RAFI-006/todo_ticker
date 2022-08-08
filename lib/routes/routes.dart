import 'package:flutter/material.dart';
import 'package:todo_ticker/view/add_task_view.dart';
import '../view/home_page_view.dart';


class Routes {
  static const String addTaskView = "/addTaskView";
  static const String homePageView = "/homePageView";

  static Route<dynamic> generatRouter(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePageView());
      case homePageView:
        return MaterialPageRoute(builder: (_) => HomePageView());

      case addTaskView:
        return MaterialPageRoute(builder: (_) =>  AddTaskView());
      default:
        return MaterialPageRoute(builder: (_) =>  HomePageView());
    }
  }
}
