import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:librarybooklocator/singinup/network_utils/ipaddress.dart';
import 'package:librarybooklocator/singinup/pages/profile_user.dart';
import 'package:librarybooklocator/singinup/pages/book.dart';
import 'package:librarybooklocator/singinup/pages/requesetbook.dart';
import 'package:librarybooklocator/singinup/search_book/search_book.dart';
import 'package:librarybooklocator/singinup/pages/rule_page.dart';
import 'package:librarybooklocator/singinup/pages/update_page.dart';
import 'modal.dart';

class HomePage extends StatefulWidget {
  HomePage() : super();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //<================================Get DATA FUNCTION START=================================================>//
  bool isLoading = false;

  String url1 =
      "http://${Server.ipAddress}/LibraryBookLocator/public/api/books";

//  String url1 =
//      "http://${Server.ipAddress}/public/api/books";

  Future<List<Book>> fetchBook() async {
    try {
      final response = await http.get(url1);
      if (response.statusCode == 200) {
        List<Book> book = parseRequestBooks(response.body);
        return book;
      } else {
        failed();
        throw Exception("error");
      }
    } catch (e) {
      failed();
      throw Exception(e.toString());
    }
  }

  void failed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Could not load "),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<Book> parseRequestBooks(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    {
      return parsed.map<Book>((json) => Book.fromJson(json)).toList();
    }
  }

  List<Book> book = List();

  @override
  void initState() {
    super.initState();
    isLoading = true;
    fetchBook().then((booksFromServer) {
      setState(() {
        isLoading = false;
        book = booksFromServer;
      });
    });
  }

//<=====================================Get DATA FUNCTION END====================================================>//

  @override
  Widget build(BuildContext context) {
    Modal modal = new Modal();

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
//<=====================================APP BAR START====================================================>//

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Library Book Locator',style: TextStyle(
            fontSize: 30.0, fontFamily: "Ropa",
          ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0XFFF59C16),
        elevation: 0,
      ),


//<========================================APP BAR END===============================================>//


//<========================================BODY START=================================================>//

    backgroundColor: isLoading ? Colors.white : Color(0XFFF59C16),
    body:  isLoading ?  Center(
      child: CircularProgressIndicator(),
    ):  Column(
      children: <Widget>[
       SizedBox(
         height: 30,
       ),
       Flexible(
           child:  Card(
             elevation: 5,
             shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.only(
              topRight: Radius.circular(40),
                     topLeft: Radius.circular(40)
                 ),
             ),

             child: Container(
                 padding: EdgeInsets.all(30.0),
                 child: GridView.count(
                   crossAxisCount: 2,
                   children: <Widget>[

                     Card(
                       margin: EdgeInsets.all(8.0),
                        elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                    ),

                       child: InkWell(
                         onTap: () {
                           showSearch(
                               context: context, delegate: SearchBook(book));
                         },
                         child: Center(
                           child: Column(
                             mainAxisSize: MainAxisSize.min,
                             children: <Widget>[
                               IconButton(
                                   iconSize: 60,
                                   alignment: Alignment.topCenter,
                                   icon: Icon(Icons.search)),
                               Text(
                                 'Search',
                                 style: new TextStyle(fontSize: 17.0),
                               )
                             ],
                           ),
                         ),
                       ),
                     ),
                     Card(
                       elevation: 5,
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(30)
                       ),

                       margin: EdgeInsets.all(8.0),
                       child: InkWell(
                         onTap: () {
                           Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new UpdatePage()));
                         },
                         child: Center(
                           child: Column(
                             mainAxisSize: MainAxisSize.min,
                             children: <Widget>[
                               IconButton(
                                   iconSize: 60,
                                   alignment: Alignment.topCenter,
                                   icon: Icon(
                                       Icons.update
                                   )),
                               Text(
                                 'Announcement',
                                 style: new TextStyle(fontSize: 17.0),
                               )
                             ],
                           ),
                         ),
                       ),
                     ),
                     Card(
                       elevation: 5,
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(30)
                       ),

                       margin: EdgeInsets.all(8.0),
                       child: InkWell(
                         onTap: () {
                           Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new RulePage()));
                         },
                         child: Center(
                           child: Column(
                             mainAxisSize: MainAxisSize.min,
                             children: <Widget>[
                               IconButton(
                                   iconSize: 60,
                                   alignment: Alignment.topCenter,
                                   icon: Icon(
                                       Icons.grid_on
                                   )),
                               Text(
                                 'Rule',
                                 style: new TextStyle(fontSize: 17.0),
                               )
                             ],
                           ),
                         ),
                       ),
                     ),
                     Card(
                       elevation: 5,
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(30)
                       ),

                       margin: EdgeInsets.all(8.0),
                       child: InkWell(
                         onTap: () {
                           Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new RequestBook()));
                         },
                         child: Center(
                           child: Column(
                             mainAxisSize: MainAxisSize.min,
                             children: <Widget>[
                               IconButton(
                                   iconSize: 60,
                                   alignment: Alignment.topCenter,
                                   icon: Icon(
                                       Icons.library_books
                                   )
                               ),
                               Text(
                                 'Request Book',
                                 style: new TextStyle(fontSize: 17.0),
                               )
                             ],
                           ),
                         ),
                       ),
                     ),
                   ],
                 )
             ),
           ),
       ),
      ],
    ),

//<========================================BODY END=================================================>//



//<========================================FLOATING BUTTON START=================================================>//
      floatingActionButton: new FloatingActionButton(
        onPressed: () => modal.mainBottomSheet(context),
        backgroundColor: Color(0XFFF59C16),
        child: new Icon(
          Icons.open_in_new,
          color: Colors.white,
        ),
      ),
//<========================================FLOATING BUTTON END=================================================>//
    );
  }
}
