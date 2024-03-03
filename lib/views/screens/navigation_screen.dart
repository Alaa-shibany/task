import 'package:flutter/material.dart';
import 'package:task/views/screens/home_screen.dart';
import 'package:task/views/screens/marks_screen.dart';

import '../widgets/navigator_screen_widgets/navigation_bar_widget.dart';

class NavigationScreen extends StatefulWidget {
  static const String routName = '/navigation-screen';
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  List screens = [const HomeScreen(), const MarksScreen()];
  int index = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: NavigationBarWidget(
        mediaQuery: mediaQuery,
        onTabChange: (value) {
          setState(() {
            index = value;
          });
        },
      ),
      body: Stack(
        children: [
          screens[index],
        ],
      ),
    );
  }
}
