import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:librarybooklocator/singinup/pages/book.dart';
import 'package:http/http.dart' as http;
import 'package:librarybooklocator/singinup/pages/homepage.dart';
import 'package:librarybooklocator/singinup/network_utils/ipaddress.dart';
import 'package:librarybooklocator/singinup/model/map.dart';

class SearchBook extends SearchDelegate {
  List<Book> boo;

  SearchBook(this.boo);

  bool isLoading = true;

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
        Navigator.pushReplacement(
            context, new MaterialPageRoute(builder: (context) => HomePage()));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    final suggestionList = query.isEmpty
        ? boo
        : boo
            .where((element) =>
                element.bookName.toString().toLowerCase().startsWith(query) ||
                element.authorName.toString().toLowerCase().startsWith(query))
            .toList();

    return query.isEmpty
        ? Center(
            child: Image.asset("assets/images/searchbook.png",
                width: MediaQuery.of(context).size.width * 1.5,
                height: MediaQuery.of(context).size.height * 1.5))
        : suggestionList.isEmpty
            ? Center(child: Text("Book not Found"))
            : ListView.builder(
                itemCount: suggestionList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                        title: Text(
                            "Book Name: ${suggestionList[index].bookName}"),
                        subtitle: Text(
                            "Author Name: ${suggestionList[index].authorName}"),
                        trailing: Text(
                            "Pieces: ${suggestionList[index].bookQuantity}"),
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      BookDetailPage(suggestionList[index])));
                        }),
                  );
                });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

//    only added this
    return query.isEmpty
        ? Center(
            child: Image.asset("assets/images/searchbook.png",
                width: MediaQuery.of(context).size.width * 1.5,
                height: MediaQuery.of(context).size.height * 1.5))
        : buildResults(context);

//              return Center(
//                child: Text("Search Book"),
//              );
//            return buildResults(context);

//     final suggestionList = query.isEmpty
//         ? boo
//         : boo
//         .where((element) =>
//         element.bookName.toString().toLowerCase().startsWith(query))
//         .toList();
//
//     return suggestionList==null ? LinearProgressIndicator() : suggestionList.isEmpty ? Center(child: Text("Book not Found")) : ListView.builder(
//         itemCount: suggestionList.length,
//         itemBuilder: (context, index) {
//           return Card(
//             child: ListTile(
//                 title: Text("Book Name: ${suggestionList[index].bookName}"),
//                 subtitle: Text("Author Name: ${suggestionList[index].authorName}"),
//                 trailing: Text("Pieces: ${suggestionList[index].bookQuantity}"),
//                 onTap: () {
//                   Navigator.push(context,
//                       new MaterialPageRoute(builder: (context) =>
//                           BookDetailPage(suggestionList[index]))
//                   );
//                 }
//             ),
//           );
//         });
  }
}

class BookDetailPage extends StatelessWidget {
  final Book book;

  BookDetailPage(this.book);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          )
        ],
        elevation: 0.0,
        backgroundColor: Color(0XFFF59C16),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Book Location",
              style: TextStyle(fontFamily: "Ropa", fontSize: 25.0),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0XFFF59C16),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Flexible(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40)),
              ),
              child: SingleChildScrollView(
                  child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 70,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "\t\t\tBook Name : ",
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            book.bookName,
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "\t\t\tAuthor Name : ",
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          book.authorName,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "\t\t\tShelf : ",
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          book.shelfNo,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "\t\t\tRow : ",
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          book.rowNo,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "\t\t\tColumn  : ",
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          book.columnNo,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
            ),
          )
        ],
      ),
//      add the map for shelf here
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => NextPage()));
        },
        backgroundColor: Color(0XFFF59C16),
        child: new Icon(
          Icons.map,
          color: Colors.white,
        ),
      ),
    );
  }
}

class NextPage extends StatefulWidget {
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {

  bool isLoading=false;

  String url = "http://${Server.ipAddress}/LibraryBookLocator/public/api/maps";

//  String url = "http://${Server.ipAddress}/public/api/rules";

  Future<List<Maps>> fetchMap() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Maps> maps = parseRequestMaps(response.body);
        return maps;
      } else {
        throw Exception("error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  List<Maps> parseRequestMaps(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    {
      return parsed
          .map<Maps>((json) => Maps.fromJson(json))
          .toList();
    }
  }

  List<Maps> maps = List();

  @override
  void initState() {
    super.initState();
    isLoading = true;
    fetchMap().then((mapsFromServer) {
      setState(() {
        isLoading = false;
        maps = mapsFromServer;
      });
    });
  }

  Future<void> _getData() async {
    setState(() {
      fetchMap();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shelf Map",
          style: TextStyle(fontFamily: "Ropa", fontSize: 25.0),
        ),
        centerTitle: true,
        backgroundColor: Color(0XFFF59C16),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          )
        ],
      ),
      backgroundColor: Colors.grey,
        body: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : RefreshIndicator(
          onRefresh: _getData,
          child: maps.isEmpty ? Center(child: Text("No map found")) : ListView.builder (
            itemCount: maps == null ? 0 : maps.length,
            itemBuilder: (BuildContext context, index) {
              return SingleChildScrollView(
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Image.network(maps[index].mapImage,
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.9),
                    ],
                  ),
                ),
              );

            },
          ),
        )

    );
  }
}




//==============================ORIGINAL CODE START=================================================
//class BookDetailPage extends StatelessWidget {
//  final Book book;
//
//  BookDetailPage(this.book);
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          backgroundColor: Color(0XFFF59C16),
//          centerTitle: true,
//          title: Row(
//            mainAxisSize: MainAxisSize.min,
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Text(
//                "Shelf No:${book.shelfNo}",
//                style: TextStyle(fontFamily: "Ropa", fontSize: 25.0),
//              ),
//            ],
//          ),
//        ),
//        backgroundColor: Colors.grey,
//        body: SingleChildScrollView(
//          child: Center(
//            child: Row(
//              children: <Widget>[
//                GestureDetector(
//                  onTap: () {
//                    Navigator.push(
//                        context,
//                        new MaterialPageRoute(
//                            builder: (context) => NextPage(book: book)));
//                  },
//                  child: Image.network(book.shelfImage,
//                      width: MediaQuery.of(context).size.width * 1,
//                      height: MediaQuery.of(context).size.height * 0.9),
//                ),
//              ],
//            ),
//          ),
//        ));
//  }
//}
//
//class NextPage extends StatelessWidget {
//  final Book book;
//
//  NextPage({this.book});
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(
//          "BookName: ${book.bookName}",
//          style: TextStyle(fontFamily: "Ropa", fontSize: 25.0),
//        ),
//        centerTitle: true,
//        backgroundColor: Color(0XFFF59C16),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.home),
//            onPressed: () {
//              Navigator.push(
//                  context, MaterialPageRoute(builder: (context) => HomePage()));
//            },
//          )
//        ],
//      ),
//      backgroundColor: Colors.grey,
//      body: SingleChildScrollView(
//        child: Center(
//          child: Row(
//            children: <Widget>[
//              Image.network(book.bookImage,
//                  width: MediaQuery.of(context).size.width * 1,
//                  height: MediaQuery.of(context).size.height * 0.9),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
//=============================ORIGINAL CODE END==============================================
