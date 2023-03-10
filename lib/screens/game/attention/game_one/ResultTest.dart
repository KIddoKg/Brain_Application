import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'attention_game1.dart';

class ResultScreen extends StatelessWidget {
  final Result result;

  ResultScreen({required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Score: ${result.score}'),
            Text('Message: ${result.message}'),
          ],
        ),
      ),
    );
  }
}

