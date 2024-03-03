import 'package:task/data/quizzes.dart';
import 'package:task/models/question_model.dart';

class QuizController {
  static List<dynamic> userAnswer = [-1];
  static List<dynamic> defaultAnswer = [];
  static int index = 0;

  void getQuestions({
    required List<Question> list1,
  }) {
    QuizzesModel.questions.clear();
    for (int i = 0; i < list1.length; i++) {
      QuizzesModel.questions.add(list1[i]);
    }
  }
}
