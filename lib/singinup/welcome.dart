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
//      appBar: AppBar(
//        automaticallyImplyLeading: false,
//        title: Text('Sign in/up'),
//        backgroundColor: Colors.brown[400],
//      ),
      backgroundColor: Color(0XFFF59C16),
      body: Column(
        mainAxisAlignment:MainAxisAlignment.center ,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.asset("assets/images/book.png"),
          new Padding(padding: const EdgeInsets.all(20.0),
            child: new Text('LibraryBookLocator',style: TextStyle(fontSize: 25,color: Colors.white),textAlign: TextAlign.center,),),
            SizedBox(height: 20.0),

          SizedBox(
            height: 50.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login(),fullscreenDialog: true));
              },
              color: Colors.white,
              child: Text('Get Started',style: TextStyle(color: Color(0XFFF59C16),fontSize: 20.0),),

            ),
          ),
        ],
      ),
    );
  }
}
