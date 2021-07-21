import 'package:flutter/material.dart';
import 'package:memomemo/database/db.dart';
import 'package:memomemo/database/memo.dart';

class EditPage extends StatefulWidget {
  EditPage({Key key, this.id}) : super(key: key);
  final String id;

  @override
  State<StatefulWidget> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  BuildContext _context;
  Memo memo = new Memo();
  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              updateMemo(widget.id);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            buildMemo(widget.id),
          ],
        ),
      ),
    );
  }

  void updateMemo(String id) {
    DBHelper sd = DBHelper();
    var fido = Memo(
      id: id,
      title: memo.title,
      text: memo.text,
      editTime: DateTime.now().toString(),
    );
    print("Edit memo :  " + fido.toString());
    sd.updateMemo(fido);
    Navigator.pop(_context);
  }

  Future<Memo> selectMemo(String id) async {
    DBHelper db = new DBHelper();
    return await db.selectMemo(id);
  }

  FutureBuilder buildMemo(String id) {
    return FutureBuilder(
      future: selectMemo(id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          memo = snapshot.data;
          return Container(
            child: Column(
              children: [
                TextField(
                  controller: TextEditingController(text: snapshot.data.title),
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
                  controller: TextEditingController(text: snapshot.data.text),
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
          );
        } else {
          return Container();
        }
      },
    );
  }
}
