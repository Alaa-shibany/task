import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:task/data/quizzes.dart';
import 'package:task/views/widgets/quiz_widget/cancel_widget.dart';
import 'package:task/views/widgets/quiz_widget/change_question_widget.dart';
import 'package:task/views/widgets/quiz_widget/question_widget.dart';

import '../../controllers/quiz_controller.dart';

class NormalQuiz extends StatefulWidget {
  NormalQuiz({super.key});

  @override
  State<NormalQuiz> createState() => _NormalQuizState();
}

class _NormalQuizState extends State<NormalQuiz> {
  final controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const SizedBox(width: 0),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          CancelWidget(mediaQuery: mediaQuery),
        ],
      ),
      body: Stack(
        children: [
          const SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image(
              image: AssetImage('assets/images/home.png'),
              fit: BoxFit.fill,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: mediaQuery.height / 7,
                ),
                CarouselSlider.builder(
                  options: CarouselOptions(
                      initialPage: 0,
                      height: mediaQuery.height / 1.5,
                      viewportFraction: 1,
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index, reason) {
                        setState(() {
                          QuizController.index = index;
                        });
                      },
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true),
                  carouselController: controller,
                  itemCount: QuizzesModel.questions.length,
                  itemBuilder: (context, index, realIndex) {
                    return QuestionWidget(
                      mediaQuery: mediaQuery,
                    );
                  },
                ),
                ChangeQuestionWidget(
                  controller: controller,
                  mediaQuery: mediaQuery,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
