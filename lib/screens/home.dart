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
            child: Container(
              child: Text(
                '메모메모',
                style: TextStyle(fontSize: 36, color: Colors.blue),
              ),
              alignment: Alignment.centerLeft,
            ),
          ),
          Expanded(
            child: memoBuilder(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditPage(new Memo())));
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
        if (snap.data == null) {
          return Container(
            alignment: Alignment.center,
            child: Text('지금 바로 "메모 추가" 버튼을 눌러 새로운 메모를 추가해보세요!'),
          );
        }
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: snap.data.length,
          itemBuilder: (context, index) {
            Memo memo = snap.data[index];
            print(memo.toString());
            return InkWell(
              onTap: () {
                print("onTap!");
              },
              onLongPress: () {
                print("onLongPress!");
                setState(() {
                  deleteMemo(memo.id);
                });
              },
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(230, 230, 230, 1),
                  border: Border.all(color: Colors.blue[200], width: 1),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.lightBlue, blurRadius: 3)
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.album),
                      title: Text(memo.title),
                      subtitle: Text(memo.text),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          child: const Text('수정'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPage(memo),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          child: const Text('삭제'),
                          onPressed: () {
                            deleteMemo(memo.id);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
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
