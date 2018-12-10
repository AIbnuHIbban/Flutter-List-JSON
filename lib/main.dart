import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main(){
  runApp(new MaterialApp(
    title: 'List Json',
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List dataJSON;

  Future<String> ambilData() async {
    http.Response hasil = await http.get(
      Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"), headers: {
        "Accept": "application/json"
      }
    );

    this.setState((){
      dataJSON = json.decode(hasil.body);
    });
    
  }

  @override
    void initState() {
      this.ambilData();
    }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
       appBar: new AppBar(title: new Text("List JSON")),
       
       body: new ListView.builder(
         itemCount: dataJSON == null ? 0 : dataJSON.length,
         itemBuilder: (context, i){
           return new Container(
             padding: EdgeInsets.all(10),
             child: Card(
               child: Container(
                 padding: EdgeInsets.all(10),
                 child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(dataJSON[i]['title'], style: TextStyle(fontSize: 20,color: Colors.blue),),
                      new Text(dataJSON[i]['body'])
                    ],
                  ),
               )
             )
           );
         },
       ),
    );
  }
}