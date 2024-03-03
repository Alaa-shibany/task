// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task/bloc/quiz_bloc.dart';
import 'package:task/style/app_colors.dart';
import 'package:task/views/widgets/quiz_widget/answers_widget.dart';
import 'package:task/views/widgets/quiz_widget/hint_widget.dart';
import 'package:task/views/widgets/quiz_widget/indicator_widget.dart';

import '../../../controllers/quiz_controller.dart';
import '../../../data/quizzes.dart';

class QuestionWidget extends StatelessWidget {
  QuestionWidget({
    super.key,
    required this.mediaQuery,
  });
  final Size mediaQuery;
  int newQuestionIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        if (state is QuestionLoaded) {
          QuizController.userAnswer = state.userAnswers;
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: mediaQuery.width / 30),
                  height: mediaQuery.height / 1.9,
                  width: mediaQuery.width / 1.1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.amber, width: 2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: mediaQuery.height / 50,
                      ),
                      Text(
                        state.type == 1
                            ? 'Choose the correct answer'
                            : state.type == 2
                                ? 'Enter the right answer'
                                : 'Choose the correct answer\nthere is more than one answer',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.main,
                            fontWeight: FontWeight.bold,
                            fontSize: mediaQuery.width / 20),
                      ),
                      SizedBox(
                        height: mediaQuery.height / 20,
                      ),
                      Text(
                        state.prompt,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: mediaQuery.height / 60,
                      ),
                      AnswersWidget(
                        type: state.type,
                        options: state.options,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: mediaQuery.height / 100,
                ),
                IndicatorWidget(
                    activeIndex: QuizController.index,
                    count: QuizzesModel.questions.length),
                SizedBox(
                  height: mediaQuery.height / 50,
                ),
                HintWidget(hint: state.hint, mediaQuery: mediaQuery)
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
