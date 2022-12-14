import 'package:flutter/material.dart';
import 'package:todo_ticker/getit/locator.dart';
import 'package:todo_ticker/routes/routes.dart';
import 'package:todo_ticker/services/navigation_service.dart';
import 'package:todo_ticker/services/snackbar_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo Ticker',
      navigatorKey: locator<NavigationService>().navigatorKey,
      scaffoldMessengerKey: locator<SnackBarService>().scaffoldKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: Routes.generatRouter,

    );
  }
}

