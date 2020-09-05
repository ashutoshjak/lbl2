
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:librarybooklocator/singinup/pages/profile_user.dart';
import 'package:librarybooklocator/singinup/pages/requesetbook.dart';

import 'homepage.dart';

class Modal {
  mainBottomSheet(BuildContext context) {
    showModalBottomSheet(context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>UserProfile()));
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Exit'),
                onTap: (){SystemNavigator.pop();
                },
              )
            ],
          );
        }
    );
  }
}