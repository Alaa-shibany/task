import 'package:flutter/material.dart';
import 'package:task/controllers/quiz_controller.dart';
import 'package:task/style/app_colors.dart';

class AnswersWidget extends StatefulWidget {
  const AnswersWidget({super.key, required this.type, required this.options});
  final int type;
  final List options;

  @override
  State<AnswersWidget> createState() => _AnswersWidgetState();
}

class _AnswersWidgetState extends State<AnswersWidget> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    controller =
        TextEditingController(text: QuizController.userAnswer.last.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.type == 1
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: widget.options
                .asMap()
                .map((index, option) => MapEntry(
                      index,
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: QuizController.userAnswer.contains(option)
                                ? AppColors.main
                                : null),
                        onPressed: () {
                          setState(() {
                            if (QuizController.userAnswer.isEmpty) {
                              QuizController.userAnswer.add(option);
                            } else {
                              QuizController.userAnswer.clear();
                              QuizController.userAnswer.add(option);
                            }
                          });
                        },
                        child: Text(
                          option,
                          style: TextStyle(
                              color: QuizController.userAnswer.contains(option)
                                  ? Colors.white
                                  : null),
                        ),
                      ),
                    ))
                .values
                .toList(),
          )
        : widget.type == 2
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: controller,
                  onChanged: (text) {
                    setState(() {
                      if (QuizController.userAnswer.isEmpty) {
                        QuizController.userAnswer.add(text);
                      } else {
                        QuizController.userAnswer.clear();
                        QuizController.userAnswer.add(text);
                      }
                    });
                  },
                  decoration:
                      const InputDecoration(labelText: 'Enter your answer'),
                ),
              )
            : Column(
                children: widget.options.map((option) {
                  return CheckboxListTile(
                    value: QuizController.userAnswer.contains(option),
                    onChanged: (isChecked) {
                      setState(() {
                        if (isChecked!) {
                          QuizController.userAnswer.add(option);
                        } else {
                          QuizController.userAnswer.remove(option);
                        }
                      });
                      print('.....................................');
                      print(QuizController.userAnswer);
                    },
                    title: Text(option),
                  );
                }).toList(),
              );
  }
}
