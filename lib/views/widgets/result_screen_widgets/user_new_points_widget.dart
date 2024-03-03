import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../models/user_model.dart';

class UserNewPointsWidget extends StatelessWidget {
  const UserNewPointsWidget({super.key , required this.isNewScoreTimeStart , required this.mediaQuery , required this.score});
  final bool isNewScoreTimeStart;
  final Size mediaQuery;

  final int score;
  @override
  Widget build(BuildContext context) {
    return isNewScoreTimeStart
                        ? Padding(
                            padding:
                                EdgeInsets.only(left: mediaQuery.width / 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Your new score is',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: mediaQuery.width / 10,
                                    shadows: const [
                                      BoxShadow(
                                        color: Colors.black,
                                        spreadRadius: 1,
                                        blurRadius: 10,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                AnimatedDigitWidget(
                                  value: UserModel.score + score,
                                  duration: const Duration(seconds: 2),
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      shadows: const [
                                        BoxShadow(
                                          color: Colors.black,
                                          spreadRadius: 1,
                                          blurRadius: 10,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                      fontWeight: FontWeight.bold,
                                      fontSize: mediaQuery.width / 10),
                                ),
                              ],
                            )
                                .animate()
                                .scale(duration: const Duration(seconds: 1))
                                .moveY(
                                    delay: const Duration(seconds: 4),
                                    begin: 0,
                                    end: -mediaQuery.height / 3),
                          )
                        : const SizedBox(
                            height: 0,
                          );
  }
}