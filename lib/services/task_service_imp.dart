import 'package:sqflite/sqflite.dart';
import 'package:todo_ticker/model/task_model.dart';
import 'package:todo_ticker/services/snackbar_service.dart';
import 'package:todo_ticker/services/task_service.dart';

import '../constants/constants_strings.dart';
import '../getit/locator.dart';

class TaskServicesImp implements ITaskService {
  final Database? _db;

  TaskServicesImp(this._db);

  @override
  Future addTask(TasksModel model) async {
    try {
       await _db?.insert(
        "task",
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

    } catch (e) {

      locator<SnackBarService>().showSnackBar(errorMsg);

    }
  }

  @override
  Future<List<TasksModel>> getAllTasks() async {
    List<TasksModel> data = [];
    try {
      final List<Map<String, dynamic>>? maps = await _db?.query("task");

      maps?.forEach((element) {
        data.add(TasksModel.fromMap(element));
      });
    } catch (e) {
      locator<SnackBarService>().showSnackBar(errorMsg);

    }

    return data;
  }

  @override
  Future updateTask(TasksModel model) async {
    try {
      await _db?.update(
        'task',
        model.toMap(),
        // Ensure that the Dog has a matching id.
        where: 'id = ?',
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [model.id],
      );
    } catch (e) {
      print(e);
    }
  }
}
