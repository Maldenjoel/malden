import 'dart:math';

import 'package:http/http.dart' as http;
import '../models/question_model.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class DBconnect {
  Future<List<Question>> fetchQuestions() async {
    List<Question> newQuestions = [];
    // data.forEach((key, value) {
    //   var newQuestion = Question(
    //     id: key,
    //     title: value['title'],
    //     options: Map.castFrom(value['options']),
    //   );
    // newQuestions.add(newQuestion);
    //});

    /*int randomIndex = Random().nextInt(newQuestions.length);
      print(newQuestions[randomIndex]);*/
    return newQuestions;
  }
}
