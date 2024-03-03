import 'package:flutter/material.dart';

import '../../../models/user_model.dart';
import 'package:animated_digit/animated_digit.dart';

class ScoreTextWidget extends StatelessWidget {
  const ScoreTextWidget({super.key, required this.mediaQuery});
  final Size mediaQuery;

  @override
  Widget build(BuildContext context) {
    return AnimatedDigitWidget(
      value: UserModel.score,
      // animateAutoSize: true,
      duration: const Duration(seconds: 3),
      textStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: mediaQuery.width / 5),
    );
  }
}
