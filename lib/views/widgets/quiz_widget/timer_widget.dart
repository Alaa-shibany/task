import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';
import 'package:task/views/screens/result_screen.dart';

import '../../../bloc/quiz_bloc.dart';
import '../../../controllers/quiz_controller.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key, required this.mediaQuery});
  final Size mediaQuery;

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  bool isCounting = true;
  Duration duration = const Duration();
  Timer? timer;
  bool isTimeUp = false;
  static const countDownDuration = Duration(minutes: 1);
  @override
  void initState() {
    super.initState();
    reset();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => addTime(),
    );
  }

  void reset() {
    if (isCounting) {
      setState(() {
        duration = countDownDuration;
      });
    } else {
      setState(() {
        duration = const Duration();
      });
    }
  }

  void showDialogTime() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      barrierDismissible: false,
      title: 'Time is over',
      confirmBtnColor: Colors.red,
      onConfirmBtnTap: () {
        BlocProvider.of<QuizBloc>(context).add(AnswerSelected(
            selectedAnswerIndex: QuizController.userAnswer.isEmpty
                ? [-1]
                : QuizController.userAnswer,
            nextIndex: QuizController.index,
            currentIndex: QuizController.index));
        BlocProvider.of<QuizBloc>(context)
            .add(QuestionSubmitted(isNormal: false));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ResultScreen(),
          ),
        );
      },
    );
  }

  void addTime() {
    final addSecond = isCounting ? -1 : 1;
    setState(() {
      final seconds = duration.inSeconds + addSecond;
      if (seconds < 0) {
        timer?.cancel();
        showDialogTime();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    String hours = twoDigits(duration.inHours);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TimeCardWidget(time: hours, mediaQuery: widget.mediaQuery),
        SizedBox(
          width: widget.mediaQuery.width / 100,
        ),
        TimeCardWidget(time: minutes, mediaQuery: widget.mediaQuery),
        SizedBox(
          width: widget.mediaQuery.width / 100,
        ),
        TimeCardWidget(time: seconds, mediaQuery: widget.mediaQuery),
      ],
    );
  }

  Widget TimeCardWidget({required String time, required Size mediaQuery}) =>
      Container(
        padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.width / 17,
            vertical: mediaQuery.height / 60),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Text(
          time,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      );
}
