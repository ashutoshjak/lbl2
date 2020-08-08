class Book{
  int id;
  // ignore: non_constant_identifier_names
  String book_name;
  // ignore: non_constant_identifier_names
  String author_name;


  Book({
    this.id,
    // ignore: non_constant_identifier_names
    this.book_name,
    // ignore: non_constant_identifier_names
    this.author_name,
  });

  factory Book.fromJson(Map<String,dynamic> parsedJson){
    return Book(
      id:parsedJson["id"],
      book_name: parsedJson["book_name"] as String,
      author_name: parsedJson["author_name"] as String,
    );
  }

}