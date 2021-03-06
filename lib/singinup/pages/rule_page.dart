import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:librarybooklocator/singinup/model/rule.dart';
import 'dart:convert';

import 'package:librarybooklocator/singinup/network_utils/ipaddress.dart';
import 'package:librarybooklocator/singinup/pages/homepage.dart';


class RulePage extends StatefulWidget {
  @override
  _RulePageState createState() => _RulePageState();
}

class _RulePageState extends State<RulePage> {

  bool isLoading=false;

  String url = "http://${Server.ipAddress}/LibraryBookLocator/public/api/rules";

//  String url = "http://${Server.ipAddress}/public/api/rules";

  Future<List<Rule>> fetchRule() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Rule> rule = parseRequestRules(response.body);
        return rule;
      } else {
        throw Exception("error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  List<Rule> parseRequestRules(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    {
      return parsed
          .map<Rule>((json) => Rule.fromJson(json))
          .toList();
    }
  }

  List<Rule> rule = List();

  @override
  void initState() {
    super.initState();
    isLoading = true;
    fetchRule().then((rulesFromServer) {
      setState(() {
        isLoading = false;
        rule = rulesFromServer;
      });
    });
  }

  Future<void> _getData() async {
    setState(() {
      fetchRule();
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
        title: Text('Rule',style: TextStyle(
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
          child: rule.isEmpty ? Center(child: Text("No rule found")) : ListView.builder (
            itemCount: rule == null ? 0 : rule.length,
            itemBuilder: (BuildContext context, index) {
              return Column(
                children: <Widget>[
                  Card(
                    elevation: 5,
                    color: Colors.white,
                    child: ListTile(
                        title: Text("•  ${rule[index].rule}"),


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
