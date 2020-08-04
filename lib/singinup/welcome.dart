import 'package:flutter/material.dart';
import 'package:librarybooklocator/singinup/loginpage.dart';
import 'package:librarybooklocator/singinup/signup.dart';


class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Sign in/up'),
        backgroundColor: Colors.brown[400],
      ),
      backgroundColor: Colors.brown[200],
      body: Column(
        mainAxisAlignment:MainAxisAlignment.center ,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Padding(padding: const EdgeInsets.all(20.0),
            child: new Text('LibraryBookLocator',style: TextStyle(fontSize: 20,color: Colors.brown),textAlign: TextAlign.center,),),
            SizedBox(height: 20.0),

          RaisedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Login(),fullscreenDialog: true));
            },
            color: Colors.brown[300],
            child: Text('Signin',style: TextStyle(color: Colors.white),),

          ),
          RaisedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Register(),fullscreenDialog: true));
            },
            color: Colors.brown[300],
            child: Text('Signup',style: TextStyle(color: Colors.white),),

          )
        ],
      ),
    );
  }
}
