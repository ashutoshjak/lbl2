import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:librarybooklocator/singinup/network_utils/ipaddress.dart';
import 'package:librarybooklocator/singinup/pages/constants.dart';
import 'package:librarybooklocator/singinup/network_utils/api.dart';
import 'package:librarybooklocator/singinup/pages/profile_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../welcome.dart';
import 'package:librarybooklocator/singinup/pages/book.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
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
//  AutoCompleteTextField searchTextField;
//  GlobalKey<AutoCompleteTextFieldState<Book>> key = new GlobalKey();
//
//  static List<Book> books = new List<Book>();
//
//  bool loading = true;
//
//  void getBooks() async {
//    String url = "http://10.0.2.2/LibraryBookLocator/public/api/books";
////    192.168.100.7
//    try {
//      final response = await http.get(url);
//      if (response.statusCode == 200) {
//        books = loadBooks(response.body);
//        setState(() {
//          loading = false;
//        });
//      } else {
//        failed();
//      }
//    } catch (e) {
//      failed();
//    }
////    await http
////        .get(
////      url,
////    )
////        .then((response) {
////      if (response.statusCode == 200) {
////        books = loadBooks(response.body);
////        setState(() {
////          loading = false;
////        });
////      } else {
////        failed();
////      }
////    });
//  }

//  static List<Book> loadBooks(String jsonString) {
//    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
//    return parsed.map<Book>((json) => Book.fromJson(json)).toList();
//  }
//
//  void failed() {
////    var context;
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        // return object of type Dialog
//        return AlertDialog(
//          title: new Text("Could not find book "),
//          actions: <Widget>[
//            // usually buttons at the bottom of the dialog
//            new FlatButton(
//              child: new Text("Close"),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    getBooks();
//    super.initState();
//  }
//
//  Widget row(Book book) {
//    return Row(
//
//      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//      children: <Widget>[
//        SizedBox(
//          height: 50.0,
//        ),
//
//        SizedBox(
//          width: 2.0,
//        ),
//
//
//        Expanded(
//          child:Text(
//            book.bookName,
//            style: TextStyle(fontWeight: FontWeight.bold ,),
//          ),
//        ),
//
//
//        Expanded(
//          child: Text(
//            book.authorName,
//
//          ),
//        ),
//
//        SizedBox(
//          height: 50.0,
//        ),
//
//        SizedBox(
//          width: 2.0,
//        ),
//
//
//      ],
//    );
//  }

//above this another method

  bool isLoading = false;

  String url1 = "http://${Server.ipAddress}/LibraryBookLocator/public/api/books";

// 10.0.2.2
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

  @override
  Widget build(BuildContext context) {
    Modal modal = new Modal();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'LibraryBookLocator',
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: <Widget>[
//          FlatButton.icon(
//            icon: Icon(
//              Icons.person,
//              color: Colors.white,
//            ),
//            label: Text(
//              'logout',
//              style: TextStyle(color: Colors.white),
//            ),
//            onPressed: () {
//              logout();
//            },
//          ),

         IconButton(
           icon: Icon(Icons.person),
           onPressed: (){
             Navigator.push(context, MaterialPageRoute(
                 builder: (context)=>UserProfile()
             ));
           },
         )
        ],
      ),
      backgroundColor: Colors.grey,
//      body: SingleChildScrollView(
//        child: Container(
//          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
//          child: Column(
//            children: <Widget>[
//              SizedBox(height: 20.0),
//              new Padding(
//                padding: const EdgeInsets.all(20.0),
//                child: new Text(
//                  'Search Book',
//                  style: TextStyle(fontSize: 20, color: Colors.brown),
//                  textAlign: TextAlign.center,
//                ),
//              ),
//              loading
//                  ? Center(
//                child: CircularProgressIndicator(),
//              )
//                  : searchTextField = AutoCompleteTextField<Book>(
//                key: key,
//                clearOnSubmit: false,
//                //   controller: ,
//                suggestions: books,
//                style: TextStyle(color: Colors.black, fontSize: 16.0),
//                decoration:
//                textInputDecoration.copyWith(hintText: 'Book Name'),
//                itemFilter: (item, query) {
//                  return item.bookName
//                      .toLowerCase()
//                      .startsWith(query.toLowerCase());
//                },
//                itemSorter: (a, b) {
//                  return a.bookName.compareTo(b.bookName);
//                },
//
//                itemSubmitted: (item) {
//                  setState(() {
//                    searchTextField.textField.controller.text =
//                        item.bookName;
//                  });
//                },
//                itemBuilder: (context, item) {
//                  return row(item);
//                },
//              ),
//              SizedBox(height: 20.0),
//              SizedBox(
//                width: 100.0,
//                height: 50.0,
//
//
//                child: RaisedButton(
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(50.0),
//                  ),
////                  onPressed: () {
////                    Navigator.push(context, MaterialPageRoute(
////                      builder: (context)=>HomePage()
////                    ));
////
////                  },
//                  color: Colors.brown,
//                  child: Text(
//                    'Search',
//                    style: TextStyle(color: Colors.white,fontSize: 18.0),
//                  ),
//                ),
//              ),
//            ],
//          ),
//
//        ),
//      ),

// above this old body method

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new Text(
                  'Search Book',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : InkWell(
                      onTap: () {
                        showSearch(
                            context: context, delegate: SearchBook(book));
                      },
                      child: Card(
                        child: Row(
                          children: <Widget>[
//              SizedBox(height: 100,),
                            Row(
                              children: <Widget>[
                                InkWell(
                                  child: IconButton(
                                    icon: Icon(Icons.search),
                                    onPressed: () {
                                      showSearch(
                                          context: context,
                                          delegate: SearchBook(book));
                                    },
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showSearch(
                                        context: context,
                                        delegate: SearchBook(book));
                                  },
                                  child: Text('Click here to search',
                                      textAlign: TextAlign.center),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
              SizedBox(
//                width: 100.0,
                height: 50.0,
              ),
              new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new Text(
                  'Information',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RulePage()));
                    },
                    child: Container(
                      color: Colors.grey,
                      height: 60,
                      width: 120,
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage("assets/images/rule.jpg"),
                              height: 50,
//                              width: 100,
                              fit: BoxFit.fill,
                            ),
//                            Padding(padding: EdgeInsets.all(10.0),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdatePage()));
                    },
                    child: Container(
                      color: Colors.grey,
                      height: 60,
                      width: 120,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage("assets/images/update.jpg"),
                              height: 50,
//                              width: 100,
                              fit: BoxFit.fill,
                            ),
//                            Padding(padding: EdgeInsets.all(10.0),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),

      floatingActionButton: new FloatingActionButton(
        onPressed: () => modal.mainBottomSheet(context),
        backgroundColor: Colors.black,
        child: new Icon(
          Icons.open_in_new,
          color: Colors.white,
        ),
      ),
    );
  }

//  void logout() async {
//    var res = await Network().getData('/logout');
//    var body = json.decode(res.body);
//    if (body['success']) {
//      SharedPreferences localStorage = await SharedPreferences.getInstance();
//      localStorage.remove('user');
//      localStorage.remove('token');
//      Navigator.pushReplacement(
//          context, MaterialPageRoute(builder: (context) => Welcome()));
//    }
//  }
}
