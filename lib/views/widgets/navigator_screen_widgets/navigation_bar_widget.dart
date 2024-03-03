import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:task/style/app_colors.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget(
      {super.key, required this.mediaQuery, required this.onTabChange});
  final Size mediaQuery;
  final void Function(int)? onTabChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.main,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.width / 15,
            vertical: mediaQuery.height / 200),
        child: GNav(
          backgroundColor: AppColors.main,
          color: Colors.white,
          curve: Curves.easeInSine,
          activeColor: Colors.amber,
          tabBackgroundColor: Colors.white10,
          gap: 2,
          padding: EdgeInsets.all(mediaQuery.height / 60),
          onTabChange: onTabChange,
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'home',
              textSize: MediaQuery.of(context).size.width / 25,
            ),
            GButton(
              icon: Iconsax.cup,
              text: 'marks',
              textSize: MediaQuery.of(context).size.width / 25,
            ),
          ],
        ),
      ),
    );
  }
}
