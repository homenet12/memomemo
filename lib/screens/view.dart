import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memomemo/database/db.dart';
import 'package:memomemo/database/memo.dart';
import 'package:memomemo/screens/home.dart';

import 'edit.dart';

class ViewPage extends StatefulWidget {
  ViewPage({Key key, this.id}) : super(key: key);
  final String id;

  @override
  State<StatefulWidget> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditPage(id: widget.id)))
                  .then((value) => setState(() {}));
            },
          )
        ],
      ),
      body: Container(
        child: buildMemo(),
      ),
    );
  }

  Future<Memo> selectMemo(String id) async {
    DBHelper db = new DBHelper();
    return await db.selectMemo(id);
  }

  buildMemo() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("View memo :  " + snapshot.data.toString());
          return Column(
            children: <Widget>[
              Container(
                child: Text(snapshot.data.title),
              ),
              Container(
                height: 300, //길이를 줘야함.
                child: SingleChildScrollView(
                    child: Text(snapshot.data.text,
                        style: TextStyle(fontSize: 10))),
              ),
            ],
          );
        } else {
          return Container(
            child: Text("데이터 없음"),
          );
        }
      },
      future: selectMemo(widget.id),
    );
  }
}
