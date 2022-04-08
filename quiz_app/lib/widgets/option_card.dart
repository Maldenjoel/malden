import 'package:flutter/material.dart';
import 'package:quiz_app/models/constant.dart';
import '../models/constant.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({
    Key? key,
    required this.option,
    required this.color,
  }) : super(key: key);
  final String option;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: ListTile(
        title: Text(
          option,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22.0,
            //color ratio when the item is selected...
            color: color.red != color.green ? neutrall : Colors.black,
          ),
        ),
      ),
    );
  }
}
