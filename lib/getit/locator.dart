import 'package:get_it/get_it.dart';
import 'package:todo_ticker/database/database.dart';
import 'package:todo_ticker/services/task_service.dart';
import 'package:todo_ticker/services/task_service_imp.dart';

import '../services/navigation_service.dart';
import '../services/snackbar_service.dart';

final locator = GetIt.instance;
final instance =  DataBaseHelper();

Future<void> setupLocator()async
{
  final db = await instance.db;
  locator.registerSingleton<ITaskService>(TaskServicesImp(db));
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => SnackBarService());
}