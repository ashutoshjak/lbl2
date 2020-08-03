
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                leading: Icon(Icons.library_books),
                title: Text('Request Book'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestBook()));
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