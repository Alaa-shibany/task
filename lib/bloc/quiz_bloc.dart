import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task/controllers/quiz_controller.dart';
import 'package:task/models/question_model.dart';

import '../data/quizzes.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  List<Question> userAnswers = [];
  List<Question> feedBack = [];

  QuizBloc()
      : super(QuestionLoaded(
            QuizzesModel.questions[0].correctIndex,
            QuizzesModel.questions[0].prompt,
            QuizzesModel.questions[0].options,
            QuizzesModel.questions[0].hint,
            QuizzesModel.questions[0].type,
            QuizzesModel.questions[0].userAnswer,
            false)) {
    on<QuizEvent>(
      (event, emit) {
        if (event is AnswerSelected) {
          if (checkExist(nextIndex: event.currentIndex) != -1) {
            userAnswers[event.currentIndex] = Question(
                prompt: QuizzesModel.questions[event.currentIndex].prompt,
                userAnswer: event.selectedAnswerIndex,
                options: QuizzesModel.questions[event.currentIndex].options,
                correctIndex:
                    QuizzesModel.questions[event.currentIndex].correctIndex,
                feedBack: QuizzesModel.questions[event.currentIndex].feedBack,
                hint: QuizzesModel.questions[event.currentIndex].hint,
                type: QuizzesModel.questions[event.currentIndex].type);
          } else {
            userAnswers.add(Question(
                prompt: QuizzesModel.questions[event.currentIndex].prompt,
                userAnswer: event.selectedAnswerIndex,
                options: QuizzesModel.questions[event.currentIndex].options,
                correctIndex:
                    QuizzesModel.questions[event.currentIndex].correctIndex,
                feedBack: QuizzesModel.questions[event.currentIndex].feedBack,
                hint: QuizzesModel.questions[event.currentIndex].hint,
                type: QuizzesModel.questions[event.currentIndex].type));
          }

          int check = checkExist(nextIndex: event.nextIndex);
          if (check != -1) {
            emit.call(QuestionLoaded(
                userAnswers[check].correctIndex,
                userAnswers[check].prompt,
                userAnswers[check].options,
                userAnswers[check].hint,
                userAnswers[check].type,
                userAnswers[check].userAnswer,
                event.nextIndex == QuizzesModel.questions.length - 1
                    ? true
                    : false));
          } else {
            emit.call(QuestionLoaded(
                QuizzesModel.questions[event.nextIndex].correctIndex,
                QuizzesModel.questions[event.nextIndex].prompt,
                QuizzesModel.questions[event.nextIndex].options,
                QuizzesModel.questions[event.nextIndex].hint,
                QuizzesModel.questions[event.nextIndex].type,
                QuizzesModel.questions[event.nextIndex].userAnswer,
                event.nextIndex == QuizzesModel.questions.length - 1
                    ? true
                    : false));
          }
        } else if (event is QuestionSubmitted) {
          if (event.isNormal) {
            int userScore = calculateScore();
            emit.call(AnswerSubmitted(userAnswers, feedBack, userScore));
          } else {
            int userScore = -100;
            emit.call(AnswerSubmitted(userAnswers, feedBack, userScore));
          }
        } else if (event is CancelQuiz) {
          userAnswers.clear();
          feedBack.clear();
          QuizController.index = 0;
          QuizController.userAnswer.clear();
          QuizController.defaultAnswer.clear();
          print(userAnswers);
          print(feedBack);
        }
      },
    );
  }

  int checkExist({required int nextIndex}) {
    for (int i = 0; i < userAnswers.length; i++) {
      if (userAnswers[i].prompt == QuizzesModel.questions[nextIndex].prompt) {
        return i;
      }
    }
    return -1;
  }

  int calculateScore() {
    int score = 0;
    for (int i = 0; i < QuizzesModel.questions.length; i++) {
      if (checkAnswer(
          userAnswers[i].userAnswer, QuizzesModel.questions[i].correctIndex)) {
        score += 50;
      } else {
        feedBack.add(QuizzesModel.questions[i]);
      }
    }
    return score;
  }

  bool checkAnswer(List userAnswers, List rightAnswers) {
    List<String> user =
        userAnswers.map((element) => element.toString()).toList();
    List<String> right =
        rightAnswers.map((element) => element.toString()).toList();
    user.sort();
    right.sort();

    if (userAnswers.length == rightAnswers.length &&
        userAnswers.every((element) => rightAnswers.contains(element))) {
      return true;
    }
    return false;
  }
}
