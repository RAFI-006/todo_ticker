import 'package:flutter_test/flutter_test.dart';
import 'package:todo_ticker/viewmodel/home_page_viewmodel.dart';

void main() {
  group('HomePageViewModel Tests -', () {
    test('If any task is running ,Add Task should be fasle', () {
      expect("Adding Tasks Allowed", false);
    });

    test('If every task is done ,Add Task should be true', () {
      expect("Adding Tasks Allowed", true);
    });

    test('If every task is paused ,Add Task should be true', () {
      expect("Adding Tasks Allowed", true);
    });
  });
}
