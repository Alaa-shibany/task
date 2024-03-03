import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';
import 'package:task/controllers/quiz_controller.dart';

import '../../../bloc/quiz_bloc.dart';
import '../../screens/navigation_screen.dart';

class CancelWidget extends StatelessWidget {
  const CancelWidget({super.key, required this.mediaQuery});
  final Size mediaQuery;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          text:
              'If you exit the test, all your answers will disappear.\nAre you sure?',
          cancelBtnText: 'no',
          confirmBtnColor: Colors.red,
          onConfirmBtnTap: () {
            QuizController.userAnswer.clear();
            QuizController.index = 0;
            BlocProvider.of<QuizBloc>(context).add(CancelQuiz());
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const NavigationScreen(),
                ));
          },
        );
      },
      icon: Icon(
        Icons.cancel_outlined,
        color: Colors.white,
        size: mediaQuery.width / 15,
      ),
    );
  }
}
