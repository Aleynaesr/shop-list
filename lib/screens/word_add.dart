import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite_demo/data/db_helper.dart';
import 'package:sqflite_demo/models/word.dart';

class WordAdd extends StatefulWidget {
  const WordAdd({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return WordAddState();
  }
}

class WordAddState extends State {
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Item",
          style: GoogleFonts.caveat(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 35,
              letterSpacing: 1,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            buildWordField(),
            buildDescriptionField(),
            buildSaveButton()
          ],
        ),
      ),
    );
  }

  buildWordField() {
    return TextField(
      decoration: const InputDecoration(
          labelText: "Tittle",
          labelStyle: TextStyle(color: Colors.deepPurple),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple))),
      cursorColor: Colors.deepPurple,
      controller: txtName,
    );
  }

  buildDescriptionField() {
    return TextField(
      decoration: const InputDecoration(
          labelText: "Description",
          labelStyle: TextStyle(color: Colors.deepPurple),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple))),
      cursorColor: Colors.deepPurple,
      controller: txtDescription,
    );
  }

  buildSaveButton() {
    return ElevatedButton(
      child: Text(
        "Add",
        style: GoogleFonts.caveat(
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 23.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      onPressed: () {
        addWord();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Colors.deepPurple,
        ),
      ),
    );
  }

  void addWord() async {
    var result = await dbHelper
        .insert(Word(word: txtName.text, description: txtDescription.text));
    Navigator.pop(context, true);
  }
}
