part of 'quiz_bloc.dart';

@immutable
sealed class QuizState {}

final class QuizInitial extends QuizState {}

class QuestionLoaded extends QuizState {
  final List questionIndex;
  final String prompt;
  final List<String> options;
  final String hint;
  final int type;
  final List userAnswers;
  final bool isLastQuestion;

  QuestionLoaded(this.questionIndex, this.prompt, this.options, this.hint,
      this.type, this.userAnswers, this.isLastQuestion);
}

class AnswerSubmitted extends QuizState {
  final List userAnswers;
  final List<Question> feedBack;
  final int score;

  AnswerSubmitted(this.userAnswers, this.feedBack, this.score);
}
