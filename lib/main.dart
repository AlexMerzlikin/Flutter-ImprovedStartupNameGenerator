import 'package:flutter/material.dart';
import 'package:flutter_app/random_words/random_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Startup Name Generator",
      home: RandomWords(),
    );
  }
}
