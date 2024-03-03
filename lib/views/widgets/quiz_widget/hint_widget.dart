import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quickalert/quickalert.dart';

class HintWidget extends StatelessWidget {
  const HintWidget({super.key, required this.hint, required this.mediaQuery});
  final Size mediaQuery;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.info,
            title: 'Hint',
            text: hint);
      },
      child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: mediaQuery.width / 4,
              vertical: mediaQuery.height / 40),
          decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: const Icon(
            Iconsax.lamp_charge5,
            color: Colors.white,
          )),
    );
  }
}
