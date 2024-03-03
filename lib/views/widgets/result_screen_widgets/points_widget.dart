import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PointsWidget extends StatelessWidget {
  const PointsWidget(
      {super.key,
      required this.isPointTimeEnd,
      required this.mediaQuery,
      required this.score});
  final bool isPointTimeEnd;
  final Size mediaQuery;
  final int score;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isPointTimeEnd ? 0.0 : 1.0,
      duration: const Duration(seconds: 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          score > 0
              ? Text(
                  'Congratulations',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: mediaQuery.width / 10,
                    shadows: const [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Text(
                  'Try hard next time',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: mediaQuery.width / 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          Center(
            child: Text(
              score >= 0
                  ? '+${score.toString()} Points'
                  : '${score.toString()} Points',
              style: TextStyle(
                  color: Colors.white,
                  shadows: const [
                    BoxShadow(
                      color: Colors.black,
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  fontSize: mediaQuery.width / 10,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ).animate().scale(duration: const Duration(seconds: 1)),
    );
  }
}
