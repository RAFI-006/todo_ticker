import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_ticker/viewmodel/home_page_viewmodel.dart';
import 'list_item_container_widget.dart';


class TasksGridWidget extends ViewModelWidget<HomePageViewModel>
{

  TasksGridWidget({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context, HomePageViewModel viewModel) {


    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 1,

      shrinkWrap: true,
      crossAxisSpacing: 1,
      itemCount: viewModel.taskStatusList.length,
      itemBuilder: (context, index) {
        return ListItemContainer(index);
      },
    );
  }



}