import 'package:flutter/material.dart';

class HelpTextWidget extends StatelessWidget {
  const HelpTextWidget(
      {super.key, required this.score, required this.mediaQuery});
  final int score;
  final Size mediaQuery;

  @override
  Widget build(BuildContext context) {
    return score < 300
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'You are a noob',
                style: TextStyle(
                    color: Colors.white60,
                    fontWeight: FontWeight.bold,
                    fontSize: mediaQuery.width / 20),
              ),
              SizedBox(
                width: mediaQuery.width / 30,
              ),
              Image(
                image: const AssetImage('assets/images/noob.png'),
                width: mediaQuery.width / 20,
              )
            ],
          )
        : score > 300 && score < 800
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'You are good',
                    style: TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.bold,
                        fontSize: mediaQuery.width / 20),
                  ),
                  SizedBox(
                    width: mediaQuery.width / 30,
                  ),
                  Image(
                    image: const AssetImage('assets/images/good.png'),
                    width: mediaQuery.width / 20,
                  )
                ],
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'You are cool',
                    style: TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.bold,
                        fontSize: mediaQuery.width / 20),
                  ),
                  SizedBox(
                    width: mediaQuery.width / 30,
                  ),
                  Image(
                    image: const AssetImage('assets/images/cool.png'),
                    width: mediaQuery.width / 20,
                  )
                ],
              );
  }
}
