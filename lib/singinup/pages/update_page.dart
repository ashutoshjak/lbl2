import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:librarybooklocator/singinup/model/upate.dart';
import 'dart:convert';

import 'package:librarybooklocator/singinup/network_utils/ipaddress.dart';



class UpdatePage extends StatefulWidget {
  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {

  bool isLoading=false;

  String url = "http://${Server.ipAddress}/LibraryBookLocator/public/api/updates";


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
        title: Text('Update'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ) ,
        backgroundColor: Colors.grey,
        body: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : RefreshIndicator(
          onRefresh: _getData,
          child: ListView.builder (
            itemCount: update == null ? 0 : update.length,
            itemBuilder: (BuildContext context, index) {
              return Card(
                color: Colors.grey,
                child: ListTile(
                  title: Text("•  ${update[index].update}"),


                ),
              );
            },
          ),
        )
    );
  }
}
