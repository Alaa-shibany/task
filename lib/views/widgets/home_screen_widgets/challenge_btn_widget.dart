import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChallengeBtnWidget extends StatelessWidget {
  ChallengeBtnWidget(
      {super.key,
      required this.mediaQuery,
      required this.title,
      required this.imageUrl,
      required this.isReversed,
      required this.onTap});
  final Size mediaQuery;
  final String title;
  final String imageUrl;
  final bool isReversed;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: mediaQuery.width / 2.2,
        height: mediaQuery.height / 8,
        margin: EdgeInsets.symmetric(horizontal: mediaQuery.width / 50),
        decoration: const BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: isReversed
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(imageUrl),
                    height: mediaQuery.height / 15,
                  ),
                  SizedBox(
                    width: mediaQuery.width / 30,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: mediaQuery.width / 18),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: mediaQuery.width / 18),
                  ),
                  SizedBox(
                    width: mediaQuery.width / 30,
                  ),
                  Image(
                    image: AssetImage(imageUrl),
                    height: mediaQuery.height / 15,
                  )
                ],
              ),
      ),
    );
  }
}
