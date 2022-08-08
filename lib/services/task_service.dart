
import '../model/task_model.dart';

abstract class ITaskService
{
  Future addTask(TasksModel model);
  Future updateTask(TasksModel model);
  Future<List<TasksModel>> getAllTasks();

}