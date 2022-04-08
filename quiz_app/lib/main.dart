import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiz_app/models/question_model.dart';
import './screens/home_screen.dart';
import './models/db_connection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var db = DBconnect();
  /*db.addQuestion(Question(id: '20', title: 'whatt is 20?', options: {
    '100': false,
    '200': true,
    '300': false,
    '400': false,
  }));*/
  db.fetchQuestions();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
