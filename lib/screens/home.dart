import 'package:flutter/material.dart';
import 'edit.dart';

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
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                  child: Text('메모메모',
                      style: TextStyle(fontSize: 36, color: Colors.blue)))
            ],
          ),
          ...loadMemo(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => EditPage()));
        },
        tooltip: '노트를 추가하려면 클릭하세요',
        label: Text('메모 추가'),
        icon: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> loadMemo() {
    List<Widget> memoList = [];
    memoList.add(Container(
      color: Colors.purpleAccent,
      height: 200,
    ));
    memoList.add(Container(
      color: Colors.redAccent,
      height: 200,
    ));

    return memoList;
  }
}
