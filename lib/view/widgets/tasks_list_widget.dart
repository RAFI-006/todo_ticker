import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_ticker/common/view_model_widget.dart';
import 'package:todo_ticker/viewmodel/home_page_viewmodel.dart';

import 'list_item_container_widget.dart';

class TasksListWidget extends ViewModelWidget<HomePageViewModel> {
  TasksListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomePageViewModel viewModel) {
    return ListView.builder(
        itemCount: viewModel.taskStatusList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ListItemContainer(
              viewModel.taskStatusList.length - (index + 1));
        });
  }
}
