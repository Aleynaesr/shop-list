class Word {
   int id;
   String word;
   String description;

  Word({this.word,this.description});
  Word.withId({this.id, this.word, this.description});

  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic>();
    map["word"] = word;
    map["description"] = description;
    if (id!=null) {
      map["id"] = id;
    }
 return map;
  }
 Word.fromObject(dynamic o){
    this.id = o["id"];
    this.word= o["word"];
    this.description= o["description"];
 }

}
