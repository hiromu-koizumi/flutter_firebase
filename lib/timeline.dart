import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'image.dart';

class LoadImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoadImageState();
  }
}

class LoadImageState extends State<LoadImage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("リスト画面"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
//              print("login");
//              showBasicDialog(context);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('posts').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (!snapshot.hasData) return const Text('Loading...');
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                padding: const EdgeInsets.only(top: 10.0),

                //投稿を表示する処理にデータを送っている
                itemBuilder: (context, index) => _buildListItem(context, snapshot.data.documents[index]),
              );
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            print("新規作成ボタンを押しました");
            Navigator.push(
              context,
              MaterialPageRoute(
                 // settings: const RouteSettings(name: "/new"),
                  //新規作成ボタンの修正
                  //builder: (BuildContext context) => InputForm(null)
              ),
            );
          }
      ),
    );
  }


  //投稿表示する処理
  Widget _buildListItem(BuildContext context, DocumentSnapshot document){
    return Card(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.android),
              //title: Text(document['comment']),
              //subtitle: Text(document['date'].toString().substring(0,10))
              ),
    ImageUrl(
    imageUrl: document['url'])

          ]
      ),
    );
  }

}


class ImageUrl extends StatelessWidget {
  final String imageUrl;
  ImageUrl({this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Image.network(
     imageUrl,
    );
  }
}