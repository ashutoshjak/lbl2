import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:librarybooklocator/singinup/loginpage.dart';
import 'package:librarybooklocator/singinup/pages/constants.dart';
import 'package:librarybooklocator/singinup/network_utils/api.dart';
import 'package:librarybooklocator/singinup/pages/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var email;
  var password;
  String error='';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 1,
        title: Text('Sigup'),
      ),
      backgroundColor: Colors.brown[200],
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
       child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Provide email';
                  }
                },
                onSaved: (input) => email = input,
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                validator: (input) {
                  if (input.length < 6) {
                    return 'Please long password ';
                  }
                },
                onSaved: (input) => password = input,
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _register();
                  }
                },
                color: Colors.brown[300],
                child: Text(
                  'Signup',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                error,
                style: TextStyle(color: Colors.red,fontSize: 14.0),
              ),
            ],
          ),
        ),
      )
    );
  }

  void _register()async{
    setState(() {
      _isLoading = true;
    });
    var data = {
      'email' : email,
      'password': password,

    };

    var res = await Network().authData(data, '/register');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => HomePage()
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}