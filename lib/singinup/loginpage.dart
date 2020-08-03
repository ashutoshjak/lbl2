import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:librarybooklocator/singinup//network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:librarybooklocator/singinup/pages/constants.dart';
import 'package:librarybooklocator/singinup/pages/homepage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var email;
  var password;
  String error = '';
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 1,
          title: Text('Sigin'),
        ),
        backgroundColor: Colors.brown[200],
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'Please enter email';
                    }
                  },
                  onSaved: (input) => email = input,
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (input) {
                    if (input.length < 6) {
                      return 'Please enter password upt0 6 characters';
                    }
                  },
                  onSaved: (input) => password = input,
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _login();
                    }
                  },
                  color: Colors.brown[300],
                  child: Text(
                    'Signin',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ));
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    var data = {'email': email, 'password': password};

    var res = await Network().authData(data, '/login');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = false;
    });
  }
}
