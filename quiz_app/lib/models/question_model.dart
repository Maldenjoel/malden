import 'package:flutter/cupertino.dart';

//simple class
class Question {
  final String id;
  final String title;
  final Map<String, bool> options;
  //consrteuror
  Question({
    required this.id,
    required this.title,
    required this.options,
  });
  //to print
  @override
  String toString() {
    return 'Question(id:$id, title: $title, options: $options)';
  }
}
