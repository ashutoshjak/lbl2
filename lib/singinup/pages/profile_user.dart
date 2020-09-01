import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:librarybooklocator/singinup/welcome.dart';
import 'package:librarybooklocator/singinup/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('Profile'),
      ),
      backgroundColor: Colors.grey,
      body:Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Card(
                color: Colors.brown[100],
                elevation: 10,
                child: Column(
                  children: <Widget>[
                    Text('Name: $name',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text('User Id: $userid',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text('Email: $email',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,fontSize: 25
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: RaisedButton(
                        elevation: 10,
                        onPressed: (){
                          logout();
                        },
                        color: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)),),
                        child: Text('Logout',style: TextStyle(
                            color: Colors.white,fontSize: 18
                        ),),

                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
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

