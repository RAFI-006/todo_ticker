import 'package:stacked/stacked.dart';
import 'package:todo_ticker/constants/constants_strings.dart';
import 'package:todo_ticker/model/task_model.dart';
import 'package:todo_ticker/services/task_service.dart';

import '../getit/locator.dart';
import '../services/snackbar_service.dart';

class HomePageViewModel extends BaseViewModel {
  var _taskServices = locator<ITaskService>();
  String status = "TODO";
  List<TasksModel> _tasksList = [];

  List<TasksModel> get tasksList => _tasksList;

  List<StatusModel> _taskStatusList = [];

  List<StatusModel> get taskStatusList => _taskStatusList;

  bool isGridView = false;

  HomePageViewModel();

  void toggleView() {
    isGridView == false ? isGridView = true : isGridView = false;
    notifyListeners();
  }

  init() async {
    await getAllTasks();
    _taskStatusList = List.generate(
      _tasksList.length,
      (index) => StatusModel(_tasksList[index].duration ?? 0, index,
          status: _tasksList[index].status ?? "TODO"),
    );
    notifyListeners();
  }

  Future getAllTasks() async {
    try {
      _tasksList = await _taskServices.getAllTasks();
    } catch (e) {
      locator<SnackBarService>().showSnackBar(errorMsg);
    }
  }

  Future updateTasks(model) async {
    try {
      await _taskServices.updateTask(model);
    } catch (e) {
      locator<SnackBarService>().showSnackBar(errorMsg);
    }
  }

  String convertSecondsIntoTimeFormat(int duration) {
    var seconds = duration % 60;
    var min = (duration - seconds) / 60;
    return "${min.toString().split('.').first} : $seconds";
  }

  void updateCurrentTimerOfTile(duration, index) {
    taskStatusList[index].duration = duration;
  }

  onStop(index) async {
    taskStatusList[index].status = "DONE";
    taskStatusList[index].isStart = false;
    taskStatusList[index].duration = 0;

    notifyListeners();
    tasksList[index].status = "DONE";
    await updateTasks(_tasksList[index]);
  }

  void startTimer(index) {
    if (!taskStatusList[index].isStart) {
      if(taskStatusList[index].duration>=3) {
        taskStatusList[index].status = "IN-PROGRESS";
        taskStatusList[index].isStart = true;
      }
      else
        {
          taskStatusList[index].status = "DONE";
          taskStatusList[index].isStart = false;
          taskStatusList[index].duration =0;
        }
    } else {
      taskStatusList[index].status = "IN-PROGRESS";
      taskStatusList[index].isStart = false;
    }

    notifyListeners();
  }
}

class StatusModel {
  int index = 0;
  int duration = 0;
  bool isStart = false;

  String status = "TODO";

  StatusModel(
    this.duration,
    this.index, {
    this.status = "ToDo",
    this.isStart = false,
  });
}
