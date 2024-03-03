import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:task/views/widgets/result_screen_widgets/points_widget.dart';
import 'package:task/views/widgets/result_screen_widgets/review_widget.dart';
import 'package:task/views/widgets/result_screen_widgets/user_new_points_widget.dart';
import '../../bloc/quiz_bloc.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool isPointTimeEnd = false;
  bool isNewScoreTimeStart = false;
  bool isFeedBackTimeStart = false;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        isPointTimeEnd = true;
      });
    });
    Timer(const Duration(seconds: 4), () {
      setState(() {
        isNewScoreTimeStart = true;
      });
    });
    Timer(const Duration(seconds: 8), () {
      setState(() {
        isFeedBackTimeStart = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const SizedBox(),
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
          BlocBuilder<QuizBloc, QuizState>(
            builder: (context, state) {
              if (state is AnswerSubmitted) {
                return Stack(
                  children: [
                    state.score > 0
                        ? Lottie.asset('assets/lotties/celebrate.json')
                        : const SizedBox(
                            width: 0,
                          ),
                    PointsWidget(
                        isPointTimeEnd: isPointTimeEnd,
                        mediaQuery: mediaQuery,
                        score: state.score),
                    UserNewPointsWidget(
                        isNewScoreTimeStart: isNewScoreTimeStart,
                        mediaQuery: mediaQuery,
                        score: state.score),
                    isFeedBackTimeStart
                        ? ReviewWidget(
                            feedBack: state.feedBack,
                            mediaQuery: mediaQuery,
                            score: state.score,
                          )
                        : const SizedBox()
                  ],
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
