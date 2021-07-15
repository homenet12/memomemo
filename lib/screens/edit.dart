import 'package:flutter/material.dart';

class EditPage extends StatelessWidget {
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
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
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
}
