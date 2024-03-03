// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:task/controllers/start_screen_controller.dart';
import 'package:task/models/user_model.dart';
import 'package:task/views/screens/start_screen.dart';

import '../../../models/start_screen_model.dart';
import '../../../style/app_colors.dart';

class MenuButtonWidget extends StatefulWidget {
  const MenuButtonWidget({super.key, required this.mediaQuery});
  final Size mediaQuery;

  @override
  State<MenuButtonWidget> createState() => _MenuButtonWidgetState();
}

class _MenuButtonWidgetState extends State<MenuButtonWidget>
    with SingleTickerProviderStateMixin {
  String messageError = '';
  late AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
    super.initState();
  }

  bool _isIconTabes = false;

  void _iconTab() {
    if (_isIconTabes) {
      animationController.reverse();
      _isIconTabes = false;
    } else {
      animationController.forward();
      _isIconTabes = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: widget.mediaQuery.width / 30),
      decoration:
          const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: PopupMenuButton<String>(
        onOpened: _iconTab,
        onCanceled: _iconTab,
        offset: Offset(0, widget.mediaQuery.height / 20),
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: animationController,
          size: widget.mediaQuery.width / 15,
        ),
        itemBuilder: (BuildContext context) {
          return [
            // PopupMenuItem<String>(
            //   value: 'userEmail',
            //   child: TextButton.icon(
            //       label: Text(
            //         UserModel.email,
            //         style: TextStyle(
            //             fontWeight: FontWeight.bold, color: AppColors.main),
            //       ),
            //       onPressed: () {},
            //       icon: const SizedBox()),
            // ),
            PopupMenuItem<String>(
              value: 'logout',
              child: Column(
                children: [
                  Text(
                    UserModel.email,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: AppColors.main),
                  ),
                  TextButton.icon(
                    label: Text(
                      'Logout',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: AppColors.main),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.loading,
                          barrierDismissible: false);
                      if (await StartScreenModel().signUserOut()) {
                        Navigator.pop(context);
                        StartScreenController.isMenuOpen = false;
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const StartScreen(),
                        ));
                      } else {
                        setState(() {
                          messageError = StartScreenController.message;
                        });
                        Navigator.of(context).pop();
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: StartScreenController.message,
                          btnCancelOnPress: () {},
                        ).show();
                      }
                    },
                    icon: Icon(
                      Icons.logout,
                      color: AppColors.main,
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );
  }
}
