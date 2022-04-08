import 'package:flutter/material.dart';
import '../models/constant.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: neutral,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        'Next Question',
        textAlign: TextAlign.center,
      ),
    );
  }
}
