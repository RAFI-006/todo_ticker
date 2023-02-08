import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:todo_ticker/common/view_model_widget.dart';
import 'package:todo_ticker/viewmodel/home_page_viewmodel.dart';

import '../../constants/constant_styles.dart';

class CountDownTimer extends ViewModelWidget<HomePageViewModel> {
  int index = 0;
  CountDownTimer(this.index, {Key? key}) : super(key: key, reactive: false);
  @override
  Widget build(BuildContext context, HomePageViewModel viewModel) {
    return CountdownTimer(
      widgetBuilder: (context, CurrentRemainingTime? time) {
        if (time != null) {
          int duration =
              time.min == null ? 0 + time.sec! : (time.min! * 60) + time.sec!;
          viewModel.updateCurrentTimerOfTile(duration, index);
        }
        return time == null
            ? Text("00:00",
                style: mediumTextStyle.copyWith(color: Colors.yellow))
            : Text(
                "${time.min ?? 00}:${time.sec ?? 00}",
                style: mediumTextStyle.copyWith(color: Colors.yellow),
              );
      },
      onEnd: () {
        if (viewModel.taskStatusList[index].isStart) viewModel.onStop(index);
      },
      endTime: DateTime.now().millisecondsSinceEpoch +
          1000 * viewModel.taskStatusList[index].duration,
    );
  }
}
