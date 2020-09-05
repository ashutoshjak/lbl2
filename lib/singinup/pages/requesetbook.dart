//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:librarybooklocator/singinup/network_utils/ipaddress.dart';
import 'package:librarybooklocator/singinup/pages/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:librarybooklocator/singinup/pages/homepage.dart';

class RequestBook extends StatefulWidget {

  @override
  _RequestBookState createState() => _RequestBookState();
}

class _RequestBookState extends State<RequestBook> {
//  TextEditingController _book_name = new TextEditingController();
//  TextEditingController _author_name = new TextEditingController();

  final _book_name = TextEditingController();
  final _author_name = TextEditingController();

  String name;
  String userid;
  String email;
  @override
  void initState(){
    _loadUserData();
    super.initState();
  }
  _loadUserData() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));

    if(user != null) {
      setState(() {
        name = user['user_name'];
        userid = user['user_id'];
        email = user['email'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Text(''),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>HomePage()
              ));
            }
          )
        ],

        title: Text('Request Book',style: TextStyle(
          fontSize: 25.0, fontFamily: "Ropa",
        ),),
        centerTitle: true,
        backgroundColor: Color(0XFFF59C16),
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
                    topLeft: Radius.circular(40)
                ),
              ),

              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 50.0),
                    TextField(
                      controller: _book_name,
                      decoration: textInputDecoration.copyWith(hintText: 'Book Name'),
                    ),
                    SizedBox(height: 30.0),
                    TextField(
                      controller: _author_name,
                      decoration: textInputDecoration.copyWith(hintText: 'Author Name'),
                    ),
                    SizedBox(height: 30.0),
                    SizedBox(
                      width: 100.0,
                      height: 50.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        onPressed: addData,
                        color: Color(0XFFF59C16),
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white,fontSize: 18.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }

  void addData() async {
    String url = "http://${Server.ipAddress}/LibraryBookLocator/public/api/requestbook";
    await http
        .post(url,
            headers: {'Accept': 'application/json'},
            body: ({
              "book_name": _book_name.text,
              "author_name": _author_name.text,
              "user_id": userid,
            }))
        .then((response) {
      if (response.statusCode == 201) {
        success();
      } else {
        failed();
      }
    });
  }

  void success() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Submitted Sucessfully"),
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

  void failed() {
//    var context;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Could not add "),
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
}
