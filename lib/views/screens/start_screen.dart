import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:task/controllers/start_screen_controller.dart';
import 'package:task/style/app_colors.dart';

import '../widgets/start_screen_widgets/Login_widget.dart';
import '../widgets/start_screen_widgets/text_widget.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  void scrollListener() {
    if (StartScreenController.scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      StartScreenController.scrollController.animateTo(
          StartScreenController.scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 50),
          curve: Curves.easeIn);
      setState(() {
        StartScreenController.isMenuOpen = false;
      });
    } else if (StartScreenController
            .scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      StartScreenController.scrollController.animateTo(
          StartScreenController.scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 50),
          curve: Curves.easeIn);
      setState(() {
        StartScreenController.isMenuOpen = true;
      });
    }
  }

  @override
  void initState() {
    StartScreenController.scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.main,
      body: Stack(
        children: [
          ListView(
            controller: StartScreenController.scrollController,
            children: [
              SizedBox(
                width: mediaQuery.width,
                height: mediaQuery.height / 1.08,
                child: const Image(
                  image: AssetImage('assets/images/auth.png'),
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                height: mediaQuery.height / 1.5,
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(50),
                      topEnd: Radius.circular(50),
                    ),
                    color: Colors.white),
                child: LoginWidget(
                  scrollController: StartScreenController.scrollController,
                  isMenuOpen: StartScreenController.isMenuOpen,
                ),
              )
            ],
          ),
          TextWidget(
            isMenuOpen: StartScreenController.isMenuOpen,
            mediaQuery: mediaQuery,
          ),
          StartScreenController.isMenuOpen
              ? const SizedBox(
                  height: 0,
                )
              : Positioned(
                  bottom: 10,
                  right: 150,
                  left: 150,
                  child: GestureDetector(
                    onTap: () {
                      StartScreenController.scrollController.animateTo(
                          StartScreenController
                              .scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                      setState(() {
                        StartScreenController.isMenuOpen = true;
                      });
                    },
                    child: Lottie.asset(
                      'assets/lotties/scroll.json',
                    ),
                  )),
        ],
      ),
    );
  }
}
