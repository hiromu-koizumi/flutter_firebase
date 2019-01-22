
import 'package:flutter/material.dart';
import 'package:flutter_cosco/image.dart';
import 'package:flutter_cosco/timeline.dart';

//firebaseに保存されるテキスト。const再代入不可な変数。const変数が指す先のメモリ領域も変更不可

void main() async {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Storage Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {
//
    return MaterialApp (

      //画面遷移ルート
    routes: {
    '/timeline': (BuildContext context) => LoadImage()

    },

      home: ListView(
        //children: children,
          children: <Widget>[
          ImageInput(),
      ]
      ),
    );
  }


}
