import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:memomemo/database/db.dart';
import 'package:memomemo/database/memo.dart';
import 'package:memomemo/screens/home.dart';

class EditPage extends StatelessWidget {
  EditPage({Key key, this.id}) : super(key: key);
  Memo memo = new Memo();
  final String id;

  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              saveDB();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: TextEditingController(text: memo.title),
              onChanged: (String title) {
                memo.title = title;
              },
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              //obscureText: true,
              decoration: InputDecoration(
                //border: OutlineInputBorder(),
                hintText: '메모의 제목을 적어주세요.',
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            TextField(
              controller: TextEditingController(text: memo.text),
              onChanged: (String text) {
                memo.text = text;
              },
              //obscureText: true,
              decoration: InputDecoration(
                //border: OutlineInputBorder(),
                hintText: '메모의 내용을 적어주세요.',
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveDB() async {
    DBHelper sd = DBHelper();

    String id = memo.id;
    if (id == null) {
      id = stringToSha512(DateTime.now().toString());
      var fido = Memo(
        id: id,
        title: memo.title,
        text: memo.text,
        createTime: DateTime.now().toString(),
        editTime: DateTime.now().toString(),
      );
      await sd.insertMemo(fido);
      return;
    }

    var fido = Memo(
      id: memo.id,
      title: memo.title,
      text: memo.text,
      editTime: DateTime.now().toString(),
    );
    await sd.updateMemo(fido);
  }

  String stringToSha512(String text) {
    var bytes = utf8.encode(text); // data being hashed
    var digest = sha512.convert(bytes);
    return digest.toString();
  }

  Future<Memo> selectMemo(String id) async {
    DBHelper db = new DBHelper();
    return await db.selectMemo(id);
  }
}
