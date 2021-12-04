import 'package:flutter/material.dart';
import 'package:sqflite_demo/screens/word_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      home: WordList(),
    );

  }

}
