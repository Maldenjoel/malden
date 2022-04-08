import 'package:flutter/material.dart';
import 'package:quiz_app/models/constant.dart';
import '../models/question_model.dart';
import '../models/constant.dart'; //question model
import '../widgets/question_widget.dart'; //question widget
import '../widgets/next_button.dart';
import '../widgets/option_card.dart';
import '../widgets/result_box.dart';
import '../models/db_connection.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var db = DBconnect();
  /*List<Question> _questions = [
    Question(
        id: '10',
        title: 'what is 2+3?',
        options: {'1': false, '5': true, '30': false, '10': false}),
    Question(
        id: '11',
        title: 'what is 2+1?',
        options: {'5': false, '3': true, '30': false, '10': false}),
    Question(
        id: '12',
        title: 'what is 2+2?',
        options: {'5': false, '4': true, '30': false, '10': false}),
    Question(
        id: '13',
        title: 'what is 2+4?',
        options: {'5': false, '6': true, '30': false, '10': false}),
  ];*/

  late Future _questions;
  Future<List<Question>> getData() async {
    final data = await FirebaseFirestore.instance
        .collection('quiz')
        .where('question', isEqualTo: "who are you?")
        //.where('pid',isEqualTo:_qrdatafield.value.text)
        .get();

    print("hiii" + data.toString());
    return db.fetchQuestions();
  }

  @override
  void initState() {
    _questions = getData();
    super.initState();
  }

  int index = 0;
  int score = 0;
  //to check if user has clicked
  bool isPressed = false;

  bool isAlreadySelected = false;
  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      //Questions End
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => ResultBox(
                result: score, //total points user got
                questionLength: questionLength, //how many questions
                onPressed: startOver,
              ));
    } else {
      if (isPressed) {
        setState(() {
          index++; //when the index will change to 1 rebuild the app
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please selectany option'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20.0),
        ));
      }
    }
  }

  //create  function for changing color
  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });
    }
  }

  //function to start over
  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _questions as Future<List<Question>>,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var extractedData = snapshot.data as List<Question>;
            return Scaffold(
              backgroundColor: background,
              appBar: AppBar(
                title: const Text('Quiz App'),
                backgroundColor: background,
                shadowColor: Colors.transparent,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Score: $score',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              ),
              body: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    QuestionWidget(
                        question: extractedData[index]
                            .title, //first question in the list
                        indexAction: index, //currently at zero
                        totalQuestions:
                            extractedData.length //total length of list
                        ),
                    const Divider(color: neutral),
                    const SizedBox(height: 25.0),
                    for (int i = 0;
                        i < extractedData[index].options.length;
                        i++)
                      GestureDetector(
                        onTap: () => checkAnswerAndUpdate(
                            extractedData[index].options.values.toList()[i]),
                        child: OptionCard(
                          option: extractedData[index].options.keys.toList()[i],
                          color: isPressed
                              ? extractedData[index]
                                          .options
                                          .values
                                          .toList()[i] ==
                                      true
                                  ? correct
                                  : incorrect
                              : neutral,
                        ),
                      ),
                  ],
                ),
              ),
              floatingActionButton: GestureDetector(
                onTap: () => nextQuestion(extractedData.length),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: NextButton(),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const Center(
          child: Text('No data'),
        );
      },
    );
  }
}
