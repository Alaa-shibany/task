// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:task/models/start_screen_model.dart';
import 'package:task/views/screens/navigation_screen.dart';
import 'package:task/views/widgets/start_screen_widgets/form_widget%20copy.dart';

import '../../../controllers/start_screen_controller.dart';
import '../../../style/app_colors.dart';

// ignore: must_be_immutable
class SignInWidget extends StatefulWidget {
  SignInWidget(
      {super.key,
      required this.mediaQuery,
      required this.scrollController,
      required this.isMenuOpen});
  Size mediaQuery;
  ScrollController scrollController;
  bool isMenuOpen;

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  FocusNode passNode = FocusNode();
  FocusNode nameNode = FocusNode();
  String enteredEmail = '';
  String enteredPass = '';
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool isSignIn = false;
  String messageError = '';
  void _togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Welcome back',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: mediaQuery.width / 20),
          ),
          SizedBox(
            height: mediaQuery.height / 20,
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: widget.mediaQuery.width / 10),
            child: FormWidget(
              textInputType: TextInputType.text,
              isNormal: true,
              obscureText: false,
              togglePasswordVisibility: () {},
              mediaQuery: widget.mediaQuery,
              textInputAction: TextInputAction.next,
              labelText: 'Email',
              hintText: 'EX: example@gmail.com',
              focusNode: nameNode,
              nextNode: passNode,
              validationFun: (value) {
                if (value == null || value.isEmpty) {
                  return "you need to enter your account name";
                } else if (!value.contains('@') || !value.contains('.com')) {
                  return 'this email is invalid';
                }
                setState(() {
                  enteredEmail = value;
                });
                return null;
              },
            ),
          ),
          SizedBox(
            height: widget.mediaQuery.height / 40,
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: widget.mediaQuery.width / 10),
            child: FormWidget(
              textInputType: TextInputType.text,
              isNormal: false,
              obscureText: obscureText,
              togglePasswordVisibility: _togglePasswordVisibility,
              mediaQuery: widget.mediaQuery,
              textInputAction: TextInputAction.done,
              labelText: 'password',
              hintText: 'password',
              focusNode: passNode,
              nextNode: passNode,
              validationFun: (value) {
                if (value == null || value.isEmpty) {
                  return 'enter your password';
                } else if (value.length < 6) {
                  return 'your password is invalid';
                }
                setState(() {
                  enteredPass = value;
                });
                return null;
              },
            ),
          ),
          SizedBox(
            height: widget.mediaQuery.height / 80,
          ),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                isSignIn = false;
              });
              if (_formKey.currentState!.validate()) {
                QuickAlert.show(
                    context: context,
                    type: QuickAlertType.loading,
                    barrierDismissible: false);

                if (await StartScreenModel()
                    .signUserIn(enteredEmail, enteredPass)) {
                  Navigator.pop(context);

                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const NavigationScreen(),
                      ),
                      (Route<dynamic> route) => false);
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
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.main,
            ),
            child: SizedBox(
              width: widget.mediaQuery.width / 1.5,
              child: const Text(
                'Sign in',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
