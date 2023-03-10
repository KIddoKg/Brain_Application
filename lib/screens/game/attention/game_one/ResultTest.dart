import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:brain_application/screens/game/attention/Attention_Screen.dart';
import 'attention_game1.dart';
import 'package:brain_application/general/app_route.dart';
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
         TextButton(
                    child: const Text('Chơi lại',
                        style: TextStyle(fontSize: 20, color: Colors.blue)),
                    onPressed: () {
              Navigator.pushReplacement( context,
                  MaterialPageRoute(builder: (context) => AttentionScreen()));
              Navigator.popUntil(context, ModalRoute.withName('/attentionScreen'));
                    },
         ),

          ],
        ),
      ),
    );
  }
}

