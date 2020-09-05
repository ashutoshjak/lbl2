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
        backgroundColor: Color(0XFFF59C16),
        elevation: 0,
        title: Text('Profile',style: TextStyle(fontSize: 25,fontFamily: "Ropa",),),
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
                 child: Column(
                   children: <Widget>[
                     SizedBox(
                       height: 100,
                     ),
                     Text('Name: $name',
                           style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 20
                           ),
                         ),
                         SizedBox(
                           height: 20.0,
                         ),
                         Text('User Id: $userid',
                           style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 20
                           ),
                         ),
                         SizedBox(
                           height: 20.0,
                         ),
                         Text('Email: $email',
                           style: TextStyle(
                               fontWeight: FontWeight.bold,fontSize: 20
                           ),
                         ),
                         SizedBox(
                           height: 20.0,
                         ),
                         Center(
                           child: SizedBox(
                             width: 100.0,
                             height: 50.0,
                             child: RaisedButton(
                               elevation: 10,
                               onPressed: (){
                                 logout();
                               },
                               color: Color(0XFFF59C16),
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(50.0),
                               ),
                               child: Text('Logout',style: TextStyle(
                                   color: Colors.white,fontSize: 18
                               ),),

                             ),
                           ),
                         ),


                   ],
                 ),
               ),
             ),
           )

          ],
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

