import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:task/bloc/quiz_bloc.dart';
import 'package:task/controllers/quiz_controller.dart';
import 'package:task/data/quizzes.dart';

import 'package:task/models/home_screen_model.dart';
import 'package:task/models/user_model.dart';
import 'package:task/views/screens/normal_quiz_screen.dart';
import 'package:task/views/screens/time_quiz_screen.dart';
import 'package:task/views/widgets/home_screen_widgets/challenge_btn_widget.dart';
import 'package:task/views/widgets/home_screen_widgets/help_text_widget.dart';
import 'package:task/views/widgets/home_screen_widgets/menu_button_widget.dart';
import 'package:task/views/widgets/home_screen_widgets/score_text_widget.dart';

import 'package:awesome_dialog/awesome_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    print('UserId => ${UserModel.id}');
    print('UserEmail => ${UserModel.email}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [MenuButtonWidget(mediaQuery: mediaQuery)],
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
          StreamBuilder<int>(
            stream: HomeScreenModel().getUserScore(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.hasData) {
                UserModel.score = snapshot.data!;
                return Stack(
                  children: [
                    Positioned(
                      top: mediaQuery.height / 8,
                      right: mediaQuery.width / 5,
                      left: mediaQuery.width / 5,
                      child: Opacity(
                        opacity: 0.3,
                        child: Lottie.asset('assets/lotties/homeScore.json',
                            repeat: true),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: mediaQuery.height / 9,
                            ),
                            CircularPercentIndicator(
                              radius: 120,
                              lineWidth: 20,
                              percent: (UserModel.score) / 1000 > 1
                                  ? 1
                                  : (UserModel.score) / 1000,
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: Colors.amber,
                              center: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ScoreTextWidget(mediaQuery: mediaQuery),
                                  Text(
                                    'score',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: mediaQuery.width / 15),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: mediaQuery.height / 50,
                            ),
                            HelpTextWidget(
                                score: UserModel.score, mediaQuery: mediaQuery),
                            SizedBox(
                              height: mediaQuery.height / 15,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ChallengeBtnWidget(
                                  mediaQuery: mediaQuery,
                                  title: 'Normal',
                                  imageUrl: 'assets/images/normal.png',
                                  isReversed: false,
                                  onTap: () {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.info,
                                      animType: AnimType.rightSlide,
                                      title: 'About the quiz',
                                      desc:
                                          '-This quiz is the normal one.\n-You will get 50 points for each correct answer.\n-Use the hint if you need any help.\ngood luck',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        QuizController().getQuestions(
                                          list1: QuizzesModel.normalQuestions,
                                        );
                                        BlocProvider.of<QuizBloc>(context).add(
                                          AnswerSelected(
                                              selectedAnswerIndex: ['-1'],
                                              nextIndex: 0,
                                              currentIndex: 0),
                                        );
                                        Navigator.of(context)
                                            .pushReplacement(MaterialPageRoute(
                                          builder: (context) => NormalQuiz(),
                                        ));
                                      },
                                    ).show();
                                  },
                                ),
                                ChallengeBtnWidget(
                                  mediaQuery: mediaQuery,
                                  title: 'Time',
                                  imageUrl: 'assets/images/time.png',
                                  isReversed: false,
                                  onTap: () {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.info,
                                      animType: AnimType.rightSlide,
                                      title: 'About the quiz',
                                      desc:
                                          '-This quiz is the time quiz (only 1 min).\n-You will get 50 points for each correct answer.\n-If the times up you will lose 100 points .\ngood luck',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        QuizController().getQuestions(
                                          list1: QuizzesModel.timeQuestions,
                                        );
                                        BlocProvider.of<QuizBloc>(context).add(
                                          AnswerSelected(
                                              selectedAnswerIndex: ['-1'],
                                              nextIndex: 0,
                                              currentIndex: 0),
                                        );
                                        Navigator.of(context)
                                            .pushReplacement(MaterialPageRoute(
                                          builder: (context) => TimeQuiz(),
                                        ));
                                      },
                                    ).show();
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: mediaQuery.height / 50,
                            ),
                            ChallengeBtnWidget(
                              mediaQuery: mediaQuery,
                              title: 'Special',
                              imageUrl: 'assets/images/special.png',
                              isReversed: false,
                              onTap: () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.info,
                                  animType: AnimType.rightSlide,
                                  title: 'About the quiz',
                                  desc: 'Open it if you want to know',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {
                                    QuizController().getQuestions(
                                      list1: QuizzesModel.special,
                                    );
                                    BlocProvider.of<QuizBloc>(context).add(
                                      AnswerSelected(
                                          selectedAnswerIndex: ['-1'],
                                          nextIndex: 0,
                                          currentIndex: 0),
                                    );
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) => NormalQuiz(),
                                    ));
                                  },
                                ).show();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              }

              return Center(child: const CircularProgressIndicator());
            },
          )
        ],
      ),
    );
  }
}
