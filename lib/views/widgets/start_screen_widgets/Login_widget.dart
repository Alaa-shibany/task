// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:task/views/widgets/start_screen_widgets/regester_widget.dart';
import 'package:task/views/widgets/start_screen_widgets/signIn_widget.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget(
      {super.key, required this.scrollController, required this.isMenuOpen});
  ScrollController scrollController;
  bool isMenuOpen;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget>
    with SingleTickerProviderStateMixin {
  late TabController? controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: mediaQuery.height / 60,
        ),
        GestureDetector(
          onTap: () {
            widget.scrollController.animateTo(
                widget.scrollController.position.minScrollExtent,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn);
            setState(() {
              widget.isMenuOpen = false;
            });
          },
          child: Container(
            width: mediaQuery.width / 3.5,
            height: mediaQuery.height / 200,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              color: Colors.black38,
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: mediaQuery.height / 40),
            child: Tabs(controller: controller!, mediaQuery: mediaQuery)),
        SlidesForTabs(
          mediaQuery: mediaQuery,
          controller: controller,
          scrollController: widget.scrollController,
        ),
      ],
    );
  }
}

class SlidesForTabs extends StatelessWidget {
  SlidesForTabs(
      {super.key,
      required this.mediaQuery,
      required this.controller,
      required this.scrollController});

  final Size mediaQuery;
  final TabController? controller;
  ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: mediaQuery.height / 2,
      child: TabBarView(
        controller: controller,
        children: [
          SignInWidget(
              mediaQuery: mediaQuery,
              scrollController: scrollController,
              isMenuOpen: true),
          RegisterWidget(
              mediaQuery: mediaQuery,
              scrollController: scrollController,
              isMenuOpen: true),
        ],
      ),
    );
  }
}

class Tabs extends StatelessWidget {
  Tabs({
    required this.controller,
    required this.mediaQuery,
  });
  final Size mediaQuery;
  final TabController controller;
  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      dividerColor: Colors.transparent,
      tabs: const [
        Tab(
          text: 'SignIn',
        ),
        Tab(
          text: 'Register',
        ),
      ],
    );
  }
}
