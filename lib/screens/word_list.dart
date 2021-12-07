import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/db_helper.dart';
import 'package:sqflite_demo/models/word.dart';
import 'package:sqflite_demo/screens/word_add.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WordList extends StatefulWidget {
  const WordList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WordListState();
  }
}

class _WordListState extends State {
  var dbHelper = DbHelper();

  List<Word> words;
  int wordCount = 0;


  void getfwords() async{
    SharedPreferences prefs = await SharedPreferences.getInstance()  ;

  }


  @override
  void initState() {
    getWords();

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Text(
            "ShopList",
            style: GoogleFonts.caveat(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 35,
                letterSpacing: 1,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          leading: const Padding(
            padding: EdgeInsets.all(2.0),
            child: Icon(
              Icons.shopping_cart,
              size: 35.0,
            ),
          ),
          backgroundColor: Colors.deepPurple,
          bottom: const TabBar(
            indicatorColor: Colors.deepPurpleAccent,
            automaticIndicatorColorAdjustment: false,
            labelColor: Colors.deepPurple,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7), topRight: Radius.circular(7)),
                color: Colors.white),
            tabs: [
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.article_rounded),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            goToWordAdd();
          },
          child: const Icon(Icons.add),
          tooltip: "Add New Item",
          splashColor: Colors.white,
          backgroundColor: Colors.deepPurple,
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: wordCount,
              itemBuilder: (BuildContext context, int position) {
                return Card(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: ListTile(
                            title: SelectableText(
                              words[position].word,
                              cursorColor: Colors.purple,
                              showCursor: false,
                              toolbarOptions: const ToolbarOptions(
                                  copy: true,
                                  selectAll: true,
                                  cut: false,
                                  paste: false),
                              style: GoogleFonts.caveat(
                                textStyle: const TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            subtitle: SelectableText(
                              words[position].description,
                              cursorColor: Colors.purple,
                              showCursor: false,
                              toolbarOptions: const ToolbarOptions(
                                  copy: true,
                                  selectAll: true,
                                  cut: false,
                                  paste: false),
                              style: GoogleFonts.caveat(
                                textStyle: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        color: Colors.blueGrey,
                        icon: const Icon(Icons.delete),
                        tooltip: 'Delete Item',
                        onPressed: () {
                          goToDelete(words[position]);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void goToWordAdd() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const WordAdd()));
    if (result != null) {
      if (result) {
        getWords();
      }
    }
  }

  void getWords() {
    var wordsFuture = dbHelper.getWords();
    wordsFuture.then((data) {
      setState(() {
        words = data;
        wordCount = data.length;
      });
    });
  }

  void goToDelete(Word word) async {
    await dbHelper.delete(word.id);
    getWords();
  }




}
