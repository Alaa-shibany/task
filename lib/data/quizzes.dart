import 'package:task/models/question_model.dart';

class QuizzesModel {
  static List<Question> questions = [
    Question(
      prompt: "What is the capital of France?",
      hint: 'You don\'t need a hint',
      feedBack: 'Ask google',
      options: ["London", "Berlin", "Paris", "Rome"],
      correctIndex: [
        '-1',
        "London",
        "Berlin",
        "Paris",
      ],
      userAnswer: [-1],
      type: 3,
    ),
    Question(
      prompt: "What is 2 + 2?",
      hint: 'Are you serious?',
      feedBack: 'If you add 2 to 2 you will got 4',
      options: ["3", "4", "5", "6"],
      correctIndex: ["4"],
      userAnswer: [-1],
      type: 1,
    ),
    Question(
      prompt: "Is this app useful",
      hint: 'How dare you!',
      feedBack: 'This app is useful because..Nop you are right not useful',
      options: ["True", "false"],
      correctIndex: ["True"],
      userAnswer: [-1],
      type: 1,
    ),
    Question(
      prompt: "What is Alaa expected salary?",
      hint: 'Alaa already answered this question',
      feedBack: 'He changed his mind :)',
      options: [],
      correctIndex: ['1000'],
      userAnswer: [''],
      type: 2,
    ),
    Question(
      prompt: "Is this the last question?",
      hint: 'True',
      feedBack: 'How can you go wrong with this!!',
      options: ["True", "false"],
      correctIndex: ["True"],
      userAnswer: [-1],
      type: 1,
    ),
  ];

  static List<Question> special = [
    Question(
      prompt: "Is this app useful",
      hint: 'How dare you!',
      feedBack: 'This app is useful because..Nop you are right not useful',
      options: ["True", "false"],
      correctIndex: ["True"],
      userAnswer: [-1],
      type: 1,
    ),
    Question(
      prompt: "What is the best time for Alaa to work?",
      hint: 'I don\'t know',
      feedBack: 'Because he has a university',
      options: ["9->4", "12->7", "11->6", "10->5"],
      correctIndex: ["12->7"],
      userAnswer: [-1],
      type: 1,
    ),
    Question(
      prompt: "What is Alaa expected salary?",
      hint: 'Alaa already answered this question',
      feedBack: 'He changed his mind :)',
      options: [],
      correctIndex: ['1000'],
      userAnswer: [''],
      type: 2,
    ),
    Question(
      prompt: "What is Alaa age?",
      hint: 'guess',
      feedBack: 'May god save him',
      options: [],
      correctIndex: ['21'],
      userAnswer: [''],
      type: 2,
    ),
    Question(
      prompt: "Is this the last question?",
      hint: 'True',
      feedBack: 'How can you go wrong with this!!',
      options: ["True", "false"],
      correctIndex: ["True"],
      userAnswer: [-1],
      type: 1,
    ),
  ];

  static List<Question> normalQuestions = [
    Question(
      prompt: "What are the borders of the state of Lebanon?",
      hint: 'Arab countries',
      feedBack:
          'to the north and east it is bordered by Syria, and to the south it is bordered by Palestine',
      options: ["syria", "jordan", "Paris", "palestine"],
      correctIndex: [
        '-1',
        "syria",
        "palestine",
      ],
      userAnswer: [-1],
      type: 3,
    ),
    Question(
      prompt: "Which of the following are primary colors?",
      hint: 'Mixing them produces other colors',
      feedBack: 'The primary colors are red, blue, and yellow.',
      options: ["red", "green", "blue", "yellow"],
      correctIndex: ["-1", "red", "blue", "yellow"],
      userAnswer: [-1],
      type: 3,
    ),
    Question(
      prompt: "What is 2 + 2?",
      hint: 'Are you serious?',
      feedBack: 'If you add 2 to 2 you will got 4',
      options: ["3", "4", "5", "6"],
      correctIndex: ["4"],
      userAnswer: [-1],
      type: 1,
    ),
    Question(
      prompt: "What is the largest continent in the world?",
      hint: 'No hint for you',
      feedBack: 'ask google if you want',
      options: [],
      correctIndex: ['Asia'],
      userAnswer: [''],
      type: 2,
    ),
    Question(
      prompt: "Name countries in South America.",
      hint: 'Continent below North America',
      feedBack:
          'Some countries in South America include Brazil, Argentina, and Chile.',
      options: ["Mexico", "Brazil", "Canada", "Argentina", "Chile"],
      correctIndex: ["-1", "Brazil", "Argentina", "Chile"],
      userAnswer: [-1],
      type: 3,
    ),
  ];

  static List<Question> timeQuestions = [
    Question(
      prompt: "What is 5 x 7?",
      hint: 'think about repeated addition',
      feedBack: '5 times 7 equals 35',
      options: ["20", "25", "30", "35"],
      correctIndex: ["35"],
      userAnswer: [-1],
      type: 1,
    ),
    Question(
      prompt: "What is the square root of 64?",
      hint: 'a number multiplied by itself gives the square',
      feedBack: 'The square root of 64 is 8',
      options: ["6", "7", "8", "9"],
      correctIndex: ["8"],
      userAnswer: [-1],
      type: 1,
    ),
    Question(
      prompt: "What is 9 squared?",
      hint: 'think of it as 9 times 9',
      feedBack: '9 squared equals 81',
      options: ["63", "72", "81", "90"],
      correctIndex: ["81"],
      userAnswer: [-1],
      type: 1,
    ),
    Question(
      prompt: "What is 20 divided by 5?",
      hint: 'think of it as sharing equally among 5 people',
      feedBack: '20 divided by 5 is 4',
      options: ["2", "4", "5", "6"],
      correctIndex: ["4"],
      userAnswer: [-1],
      type: 1,
    ),
    Question(
      prompt: "What is 3 to the power of 4?",
      hint: 'think of repeated multiplication',
      feedBack: '3 to the power of 4 equals 81',
      options: ["64", "72", "81", "90"],
      correctIndex: ["81"],
      userAnswer: [-1],
      type: 1,
    ),
  ];
}