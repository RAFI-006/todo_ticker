import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_ticker/common/view_model_widget.dart';
import 'package:todo_ticker/view/widgets/count_down_timer.dart';
import 'package:todo_ticker/viewmodel/home_page_viewmodel.dart';

import '../../constants/constant_colors.dart';
import '../../constants/constant_styles.dart';
import '../../constants/constant_widgets.dart';

class ListItemContainer extends ViewModelWidget<HomePageViewModel> {
  int index = 0;
  ListItemContainer(this.index, {Key? key}) : super(key: key, reactive: true);
  @override
  Widget build(BuildContext context, HomePageViewModel viewModel) {
    return GestureDetector(
      onTap: () {
        if (viewModel.taskStatusList[index].status != "DONE") {
          viewModel.startTimer(index);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: secondaryColor.withOpacity(0.5))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                child: Text(
              viewModel.tasksList[index].title ?? "NA",
              style: mediumTextStyle.copyWith(
                  color: secondaryColor, fontWeight: FontWeight.w500),
              softWrap: true,
            )),
            verticalSpace(10),
            Flexible(
                child: Text(
              viewModel.tasksList[index].description ?? "NA",
              style: bodyTextStyle.copyWith(color: secondaryColor),
              softWrap: true,
            )),
            verticalSpace(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                viewModel.taskStatusList[index].isStart
                    ? CountDownTimer(
                        index,
                        key: key,
                      )
                    : Text(
                        viewModel.convertSecondsIntoTimeFormat(
                            viewModel.taskStatusList[index].duration),
                        style: mediumTextStyle.copyWith(color: Colors.yellow),
                      ),
                Text(
                  viewModel.taskStatusList[index].status,
                  style: bodyTextStyle.copyWith(color: secondaryColor),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
