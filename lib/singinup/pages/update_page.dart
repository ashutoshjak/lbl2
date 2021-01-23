import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:librarybooklocator/singinup/model/upate.dart';
import 'dart:convert';

import 'package:librarybooklocator/singinup/network_utils/ipaddress.dart';
import 'package:librarybooklocator/singinup/pages/homepage.dart';



class UpdatePage extends StatefulWidget {
  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {

  bool isLoading=false;

  String url = "http://${Server.ipAddress}/LibraryBookLocator/public/api/updates";

//  String url = "http://${Server.ipAddress}/public/api/updates";


  Future<List<Update>> fetchUpdate() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Update> update = parseRequestUpdates(response.body);
        return update;
      } else {
        throw Exception("error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  List<Update> parseRequestUpdates(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    {
      return parsed
          .map<Update>((json) => Update.fromJson(json))
          .toList();
    }
  }

  List<Update> update = List();

  @override
  void initState() {
    super.initState();
    isLoading = true;
    fetchUpdate().then((updatesFromServer) {
      setState(() {
        isLoading = false;
        update = updatesFromServer;
      });
    });
  }

  Future<void> _getData() async {
    setState(() {
      fetchUpdate();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => HomePage()));
          },),

        title: Text('Announcement',style: TextStyle(
          fontSize: 25.0,fontFamily: "Ropa",
        ),),
        centerTitle: true,
        backgroundColor: Color(0XFFF59C16),
      ) ,
        backgroundColor: Colors.white,
        body: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : RefreshIndicator(
          onRefresh: _getData,
          child: update.isEmpty ? Center(child: Text("No update found")) : ListView.builder (
            itemCount: update == null ? 0 : update.length,
            itemBuilder: (BuildContext context, index) {
              return Column(
                children: <Widget>[
                  Card(
                    elevation: 5,
                    color: Colors.white,
                    child: ListTile(
                      title: Text("•  ${update[index].update}"),


                    ),
                  ),
                ],
              );
            },
          ),
        )
    );
  }
}
