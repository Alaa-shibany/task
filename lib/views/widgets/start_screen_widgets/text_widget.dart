import 'package:flutter/material.dart';
import 'package:task/style/app_colors.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.isMenuOpen,
    required this.mediaQuery,
  });
  final bool isMenuOpen;
  final Size mediaQuery;

  @override
  Widget build(BuildContext context) {
    return isMenuOpen
        ? const SizedBox(
            width: 0,
          )
        : Positioned(
            left: mediaQuery.width / 15,
            bottom: mediaQuery.height / 6,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Swipe up',
                  style: TextStyle(
                      color: AppColors.second,
                      fontWeight: FontWeight.bold,
                      fontSize: mediaQuery.width / 10),
                ),
                Text(
                  'To signIn to the quizzes world',
                  style: TextStyle(
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                      fontSize: mediaQuery.width / 15),
                ),
              ],
            ),
          );
  }
}
