import 'package:flutter/material.dart';
import 'package:librarybooklocator/singinup/pages/book.dart';
import 'package:http/http.dart' as http;
import 'package:librarybooklocator/singinup/pages/homepage.dart';
//import 'package:lbladmin/pages/addbook.dart';

class SearchBook extends SearchDelegate {

  List<Book> boo;

  SearchBook(this.boo);


  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text(""); //Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final suggestionList = query.isEmpty
        ? boo
        : boo
        .where((element) =>
        element.bookName.toString().toLowerCase().startsWith(query))
        .toList();

    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
                title: Text("Book Name: ${suggestionList[index].bookName}"),
                subtitle: Text("Author Name: ${suggestionList[index].authorName}"),
                trailing: Text("Pieces: ${suggestionList[index].bookQuantity}"),
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) =>
                          BookDetailPage(suggestionList[index]))
                  );
                }
            ),
          );
        });

  }
}

class BookDetailPage extends StatelessWidget {

  final Book book;

  BookDetailPage(this.book);

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFFF59C16),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Shelf No:${book.shelfNo}",style: TextStyle(fontFamily: "Ropa",fontSize: 25.0),),

          ],
        ),
      ),

        backgroundColor: Colors.grey,
        body: SingleChildScrollView(
          child: Center(
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => NextPage(book: book)));
                  },
                  child: Image.network(book.shelfImage,
                      width: MediaQuery.of(context).size.width*1,
                      height: MediaQuery.of(context).size.height*0.9
                  ),
                ),
              ],
            )
            ,
          ),
        )
    );
  }

}

class NextPage extends StatelessWidget {

  final Book book;

  NextPage({this.book});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BookName: ${book.bookName}",style: TextStyle(fontFamily: "Ropa",fontSize: 25.0),),
        centerTitle: true,
        backgroundColor: Color(0XFFF59C16),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context)=>HomePage()
              ));
            },
          )
        ],
      ),
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Center(
          child: Row(
            children: <Widget>[
              Image.network(book.bookImage,
                width: MediaQuery.of(context).size.width*1,
                height: MediaQuery.of(context).size.height*0.9
              ),
            ],
          ),
        ),
      ),
    );
  }
}


