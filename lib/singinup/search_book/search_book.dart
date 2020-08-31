import 'package:flutter/material.dart';
import 'package:librarybooklocator/singinup/pages/book.dart';
import 'package:http/http.dart' as http;
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
          return ListTile(
              title: Text("Book Name: ${suggestionList[index].bookName}"),
              subtitle: Text("Author Name: ${suggestionList[index].authorName}"),
              trailing: Text("Piceces: ${suggestionList[index].bookQuantity}"),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) =>
                        BookDetailPage(suggestionList[index]))
                );
              }
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

        backgroundColor: Colors.brown[100],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                children: <Widget>[
//                  Center(
//                    child: Row(
//                      children: <Widget>[
//                        Padding(
//                          padding: const EdgeInsets.fromLTRB(
//                              95.0, 10.0, 0, 10.0),
//                          child: Text(
//                            'Author Name: ${book.authorName}', style: TextStyle(
//                              fontSize: 20.0,
//                              fontWeight: FontWeight.bold
//                          ),),
//                        ),
//
//
//                      ],
//                    ),
//                  ),

//                SizedBox(
//                  height: 100,
//                ),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                              new MaterialPageRoute(builder: (context) => NextPage(book: book)));
                        },
                        child: Image.network(book.shelfImage,width: 350,height: 700),
                      ),
                    ],
                  )

                ],
              ),
            ),
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
      backgroundColor: Colors.brown[100],
      body: Center(
        child: Row(
          children: <Widget>[
            Image.network(book.bookImage,width: 390,height: 800,),
          ],
        ),
      ),
    );
  }
}


