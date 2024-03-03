import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/models/home_screen_model.dart';
import 'package:task/models/question_model.dart';
import 'package:task/views/screens/navigation_screen.dart';

import '../../../bloc/quiz_bloc.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget(
      {super.key,
      required this.score,
      required this.feedBack,
      required this.mediaQuery});
  final Size mediaQuery;
  final List<Question> feedBack;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: mediaQuery.width / 20),
      width: mediaQuery.width / 1.1,
      height: mediaQuery.height / 2,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: Colors.amber),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: mediaQuery.height / 80,
          ),
          Text(
            'Review',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: mediaQuery.width / 20),
          ),
          SizedBox(
            height: mediaQuery.height / 40,
          ),
          SizedBox(
            height: mediaQuery.height / 3,
            child: feedBack.isEmpty && score >= 0
                ? const Center(
                    child: Text(
                      'Nice..All your answers are correct',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                : feedBack.isEmpty && score < 0
                    ? const Center(
                        child: Text(
                          'You have to answer on questions to get reviews',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: feedBack.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: mediaQuery.width / 50,
                                vertical: mediaQuery.height / 100),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white30, width: 2)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  feedBack[index].prompt,
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: mediaQuery.height / 90,
                                ),
                                Text(
                                  feedBack[index].correctIndex.toString(),
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: mediaQuery.height / 90,
                                ),
                                Text(
                                  feedBack[index].feedBack,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: mediaQuery.height / 30,
                                )
                              ],
                            ),
                          );
                        },
                      ),
          ),
          ElevatedButton(
              onPressed: () {
                HomeScreenModel().incrementScore(score);
                BlocProvider.of<QuizBloc>(context).add(CancelQuiz());
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const NavigationScreen(),
                    ),
                    (Route<dynamic> route) => false);
              },
              style: ElevatedButton.styleFrom(primary: Colors.amber),
              child: const Text(
                'Ok',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    ).animate().moveY(
        begin: mediaQuery.height / 1,
        end: mediaQuery.height / 4,
        duration: const Duration(seconds: 1));
  }
}
