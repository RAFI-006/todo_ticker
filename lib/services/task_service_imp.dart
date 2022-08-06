import 'package:sqflite/sqflite.dart';
import 'package:todo_ticker/model/task_model.dart';
import 'package:todo_ticker/services/task_service.dart';



class TaskServicesImp implements ITaskService
{
  Database? db;
  TaskServicesImp(this.db);
  @override
  Future addTask(TasksModel model) async{
    try
    {
      var response = await db?.insert("task", model.toMap(), conflictAlgorithm: ConflictAlgorithm.replace,);
    }
    catch(e)
    {
      print(e);
    }

  }

  @override
  Future getTask() {
    // TODO: implement getTask
    throw UnimplementedError();
  }

}