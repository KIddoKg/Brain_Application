import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'attention_game1.dart';


class ImagePassScreen extends StatelessWidget {
  final ImagePass imagePass;

  ImagePassScreen({required this.imagePass});

  List<String> imageUrls = [];
  @override
  Widget build(BuildContext context) {
    imageUrls = imagePass.message;
    print(imagePass.message);
    return  ListView.builder(
      itemCount: imagePass.message.length,
      itemBuilder: (BuildContext context, int index) {
        return Image.asset(imagePass.message[index]);
      },
    );
  }
}

