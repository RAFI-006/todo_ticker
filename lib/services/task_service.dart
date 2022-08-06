
import '../model/task_model.dart';

abstract class ITaskService
{
  Future addTask(TasksModel model);
  Future getTask();

}