import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memomemo/database/db.dart';
import 'package:memomemo/database/memo.dart';

class ViewPage extends StatelessWidget {
  ViewPage({Key key, this.id}) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(snapshot.data.title),
                        ),
                        Container(
                          height: 500, //길이를 줘야함.
                          child: SingleChildScrollView(
                              child: Text(snapshot.data.text,
                                  style: TextStyle(fontSize: 100))),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    child: Text("데이터 없음"),
                  );
                }
              },
              future: selectMemo(id),
            )
          ],
        ),
      ),
    );
  }

  Future<Memo> selectMemo(String id) async {
    DBHelper db = new DBHelper();
    return await db.selectMemo(id);
  }
}
