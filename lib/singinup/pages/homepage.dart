import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:librarybooklocator/singinup/pages/constants.dart';
import 'package:librarybooklocator/singinup/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../welcome.dart';
import 'modal.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Modal modal = new Modal();

    return Scaffold(
       resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('LibraryBookLocator'),
          backgroundColor: Colors.brown[400],
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person,color: Colors.white,),
              label: Text('logout',style: TextStyle(color: Colors.white),),
              onPressed: () {
                logout();
              },
            ),
          ],
        ),
      backgroundColor: Colors.brown[100],

      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            new Padding(padding: const EdgeInsets.all(20.0),
              child: new Text('Search Book',style: TextStyle(fontSize: 20,color: Colors.brown),textAlign: TextAlign.center,),),
              TextField(
                decoration: textInputDecoration.copyWith(hintText: 'Book Name'),
              ),
            SizedBox(height: 20.0),
            RaisedButton(
              onPressed: (){},
              color: Colors.brown[300],
              child: Text('Search',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: ()=> modal.mainBottomSheet(context),
          backgroundColor: Colors.brown[400],
          child: new Icon(Icons.open_in_new,color: Colors.white,),
      ),
    );
  }

  void logout() async{
    var res = await Network().getData('/logout');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>Welcome()));
    }
  }
}


