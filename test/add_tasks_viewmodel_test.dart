import 'package:flutter_test/flutter_test.dart';
import 'package:todo_ticker/getit/locator.dart';
import 'package:todo_ticker/viewmodel/add_tasks_viewmodel.dart';

void main() {
  group('AddTasksViewModel Tests -', () {
    test('When tilte is empty, should be fasle', () {
      var model = AddTasksViewModel();
      model.titleController.text = "";
      expect("Adding Tasks Not Allowed", false);
    });

    test('When descriptiion is empty, should be true', () {
      var model = AddTasksViewModel();
      model.descriptionController.text = "Title";
      expect("Adding Tasks Allowed", true);
    });

    test('When duration is not given, should be true', () {
      expect("Duration is 10 min by default", true);
    });
  });
}
