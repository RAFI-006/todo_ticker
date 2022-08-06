import 'package:get_it/get_it.dart';
import 'package:todo_ticker/database/database.dart';
import 'package:todo_ticker/services/task_service.dart';
import 'package:todo_ticker/services/task_service_imp.dart';

final locator = GetIt.instance;
final instance =  DataBaseHelper.instance();
Future<void> setupLocator()async
{
  locator.registerSingleton<ITaskService>(TaskServicesImp(instance.db));
}