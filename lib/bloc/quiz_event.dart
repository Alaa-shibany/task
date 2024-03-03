part of 'quiz_bloc.dart';

@immutable
sealed class QuizEvent {}

class InitialState extends QuizEvent {}

class AnswerSelected extends QuizEvent {
  final List selectedAnswerIndex;
  final int nextIndex;
  final int currentIndex;

  AnswerSelected(
      {required this.selectedAnswerIndex,
      required this.nextIndex,
      required this.currentIndex});
}

class QuestionSubmitted extends QuizEvent {
  final bool isNormal;
  QuestionSubmitted({required this.isNormal});
}

class CancelQuiz extends QuizEvent {}
