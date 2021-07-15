import 'package:flutter/material.dart';
import 'package:memomemo/database/memo.dart';
import 'package:memomemo/screens/edit.dart';
import 'package:memomemo/database/db.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5, top: 40, bottom: 20),
            child: Text(
              '메모메모',
              style: TextStyle(fontSize: 36, color: Colors.blue),
            ),
          ),
          Expanded(
            child: memoBuilder(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => EditPage()));
        },
        tooltip: '메모를 추가하려면 클릭하세요',
        label: Text('메모 추가'),
        icon: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<List<Memo>> loadMemo() async {
    DBHelper dbHelper = DBHelper();
    return await dbHelper.memos();
  }

  Widget memoBuilder() {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<List<Memo>> snap) {
        if (snap.data.isEmpty) {
          return Container(
            alignment: Alignment.center,
            child: Text('지금 바로 "메모 추가" 버튼을 눌러 새로운 메모를 추가해보세요!'),
          );
        }
        return ListView.builder(
          itemCount: snap.data.length,
          itemBuilder: (context, index) {
            Memo memo = snap.data[index];
            return Column(
              children: <Widget>[
                Text(memo.title),
                Text(memo.text),
                Text(memo.editTime),
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteMemo(memo.id);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    }),
              ],
            );
          },
        );
      },
      future: loadMemo(),
    );
  }

  deleteMemo(String id) {
    DBHelper dbHelper = DBHelper();
    dbHelper.deleteMemo(id);
  }
}
