import 'package:flutter/cupertino.dart';
import 'package:todo_ticker/model/task_model.dart';
import 'package:todo_ticker/routes/routes.dart';

import '../constants/constants_strings.dart';
import '../getit/locator.dart';
import '../services/navigation_service.dart';
import '../services/snackbar_service.dart';
import '../services/task_service.dart';

class AddTasksViewModel extends ChangeNotifier {
  final _taskServices = locator<ITaskService>();
  final _navigationService = locator<NavigationService>();

  AddTasksViewModel();

  TextEditingController titleController = TextEditingController(text: '');
  TextEditingController descriptionController = TextEditingController(text: '');
  List<String> durationItem = ["0", "00"];

  Future addTasks() async {
    var duration =
        (int.parse(durationItem.first) * 60) + int.parse(durationItem.last);
    var model = TasksModel(
        title: titleController.text,
        description: descriptionController.text,
        duration: duration == 0 ? 600 : duration,
        status: "TODO");
    try {
      var response = await _taskServices.addTask(model);

      _navigationService.navigateTo(Routes.homePageView, isStackCleared: true);
    } catch (e) {
      locator<SnackBarService>().showSnackBar(errorMsg);
    }
  }

  void updateDuration(value) {
    durationItem.first = value.first.toString();
    durationItem.last =
        value.last >= 10 ? value.last.toString() : "0${value.last.toString()}";
    notifyListeners();
  }
}
