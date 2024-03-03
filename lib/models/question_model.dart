class Question {
  String prompt;
  List<String> options;
  List correctIndex;
  List userAnswer;
  String feedBack;
  String hint;
  int type;

  Question(
      {required this.prompt,
      required this.userAnswer,
      required this.options,
      required this.correctIndex,
      required this.feedBack,
      required this.hint,
      required this.type});
}
