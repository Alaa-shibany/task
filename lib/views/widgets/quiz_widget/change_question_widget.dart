// ignore_for_file: must_be_immutable

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/style/app_colors.dart';
import 'package:task/views/screens/result_screen.dart';

import '../../../bloc/quiz_bloc.dart';
import '../../../controllers/quiz_controller.dart';

class ChangeQuestionWidget extends StatelessWidget {
  ChangeQuestionWidget({
    super.key,
    required this.controller,
    required this.mediaQuery,
  });
  final CarouselController controller;
  final Size mediaQuery;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mediaQuery.width / 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              controller.previousPage(
                  duration: const Duration(microseconds: 100));
              int previousIndex =
                  QuizController.index == 0 ? 0 : QuizController.index - 1;
              BlocProvider.of<QuizBloc>(context).add(AnswerSelected(
                  selectedAnswerIndex: QuizController.userAnswer.isEmpty
                      ? [-1]
                      : QuizController.userAnswer,
                  nextIndex: previousIndex,
                  currentIndex: QuizController.index));
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.width / 20,
                  vertical: mediaQuery.height / 40),
              decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          BlocBuilder<QuizBloc, QuizState>(
            builder: (context, state) {
              if (state is QuestionLoaded) {
                print(state.isLastQuestion);
                return state.isLastQuestion
                    ? GestureDetector(
                        onTap: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            title: 'Are you sure',
                            desc:
                                'Do you want to end the quiz and show the result?',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {
                              BlocProvider.of<QuizBloc>(context).add(
                                  AnswerSelected(
                                      selectedAnswerIndex:
                                          QuizController.userAnswer.isEmpty
                                              ? [-1]
                                              : QuizController.userAnswer,
                                      nextIndex: QuizController.index,
                                      currentIndex: QuizController.index));
                              BlocProvider.of<QuizBloc>(context)
                                  .add(QuestionSubmitted(isNormal: true));
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => const ResultScreen(),
                              ));
                            },
                          ).show();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: mediaQuery.width / 1.8,
                          padding: EdgeInsets.symmetric(
                              horizontal: mediaQuery.width / 20,
                              vertical: mediaQuery.height / 40),
                          decoration: BoxDecoration(
                              color: AppColors.main,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: const Text(
                            'submit',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : const SizedBox();
              }
              return Container();
            },
          ),
          GestureDetector(
            onTap: () {
              controller.nextPage(duration: const Duration(microseconds: 100));
              int nextIndex =
                  QuizController.index == 4 ? 4 : QuizController.index + 1;
              BlocProvider.of<QuizBloc>(context).add(AnswerSelected(
                  selectedAnswerIndex: QuizController.userAnswer.isEmpty
                      ? [-1]
                      : QuizController.userAnswer,
                  nextIndex: nextIndex,
                  currentIndex: QuizController.index));
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.width / 20,
                  vertical: mediaQuery.height / 40),
              decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
