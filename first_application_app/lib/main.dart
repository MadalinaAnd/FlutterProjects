import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';

void main() => runApp(MyApp());

// ignore: use_key_in_widget_constructors
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final _questions = const [
    {
      'questionText': 'How many permanent teeth does a dog have?',
      'answers': [
        {'text': '42', 'score': 5},
        {'text': '32', 'score': 0},
        {'text': '20', 'score': 0},
        {'text': '50', 'score': 0}
      ],
    },
    {
      'questionText':
          'How many human players are there on each side in a polo match?',
      'answers': [
        {'text': '4', 'score': 5},
        {'text': '5', 'score': 0},
        {'text': '2', 'score': 0},
        {'text': '3', 'score': 0}
      ]
    },
    {
      'questionText': 'What is the smallest planet in our solar system?',
      'answers': [
        {'text': 'Neptune', 'score': 0},
        {'text': 'Saturn', 'score': 0},
        {'text': 'Mercury', 'score': 5},
        {'text': 'Terra', 'score': 0}
      ],
    },
    {
      'questionText':
          'In which European country would you find the Rijksmuseum?',
      'answers': [
        {'text': 'France', 'score': 0},
        {'text': 'Netherlands', 'score': 5},
        {'text': 'Spain', 'score': 0},
        {'text': 'Norway', 'score': 0}
      ],
    },
    {
      'questionText': 'Which Tennis Grand Slam is played on a clay surface?',
      'answers': [
        {'text': 'US Open', 'score': 0},
        {'text': 'Wimbledon', 'score': 0},
        {'text': 'Australian Open', 'score': 0},
        {'text': 'Roland Garros', 'score': 5}
      ],
    },
    {
      'questionText':
          'Which legendary surrealist artist is famous for painting melting clocks?',
      'answers': [
        {'text': 'Masaccio', 'score': 0},
        {'text': 'Leonardo da Vinci,', 'score': 0},
        {'text': 'Salvador Dali', 'score': 5},
        {'text': 'Samuel F. B. Morse', 'score': 0}
      ],
    },
    {
      'questionText':
          'A screwdriver cocktail is orange juice, ice and which spirit?',
      'answers': [
        {'text': 'Gin', 'score': 0},
        {'text': 'Vodka', 'score': 5},
        {'text': 'Whiskey', 'score': 0},
        {'text': 'Tequila', 'score': 0}
      ],
    },
  ];
  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex = _questionIndex + 2;
    });
    // print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('General Quiz'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
              )
            : Result(_totalScore, _resetQuiz),
      ),
    );
  }
}
