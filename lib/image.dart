import 'dart:io';

import 'package:flutter/material.dart';

//画像を表示するのに必要
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';

//iosで画像投稿するにはios/Runner/imfo.plistに以下を追記。
//  <key>NSPhotoLibraryUsageDescription</key>
//	<string>Image is used as a poroduct image.</string>
//	<key>NSCameraUsageDescription</key>
//	<string>Image is used as a poroduct image.</string>

class ImageInput extends StatefulWidget {
//  final Function setImage;
//  final Product product;
//
//  ImageInput(this.setImage, this.product);

  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {

  //選んだ写真が格納される場所
  File _imageFile;

//  //写真を追加するボタンを押したときの処理
  void _getImage(BuildContext context, ImageSource source) {
    //写真の横幅を決めている
    ImagePicker.pickImage(source: source, maxWidth: 400.0).then((File image) {
      setState(() {

        //写真を代入
        _imageFile = image;
      });

      //他でも使える形式に変更している。
     // widget.setImage(image);
      Navigator.pop(context);
    });
  }


//写真を追加するボタンを押されたとき呼ばれる処理。使う写真を
  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(children: [
              Text(
                'Pick an Image',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text('Use Camera'),
                onPressed: () {

                  //カメラが起動する
                  _getImage(context, ImageSource.camera);
                },
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text('Use Gallery'),
                onPressed: () {

                  //ギャラリーが表示される
                  _getImage(context, ImageSource.gallery);
                },
              )
            ]),
          );
        });
  }
//
//  @override
  Widget build(BuildContext context) {
    //枠線、アイコン、テキストの色
    final buttonColor = Theme.of(context).accentColor;

    return Column(
      children: <Widget>[
        OutlineButton(
          //枠線
          borderSide: BorderSide(
            color: buttonColor,
            width: 2.0,
          ),
          onPressed: () {

            //写真をギャラリーから選ぶかカメラで今とるかの選択画面を表示
            _openImagePicker(context);
          },
          child: Row(
            //中心に配置
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Icon(
                Icons.camera_alt,
                color: buttonColor,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                'Add Image',
                style: TextStyle(color: buttonColor),
              )
            ],
          ),
        ),

        //写真をfirebaseに保存する処理
        _imageFile == null? Text('写真選択して'):enableUpload(),

//        //画像を投稿している
//        _imageFile == null
//
//        //写真が選択されていないときの処理。textを表示している
//            ? Text('Please pick an image.')
//
//        //写真が選択されているときの処理。写真を表示している
//            : Image.file(
//          _imageFile,
//
//          //画面に写真の大きさを合わせる処理。写真サイズをトリミングする
//          fit: BoxFit.cover,
//
//          //写真の縦の長さ
//          height: 300.0,
//
//          //写真の横幅とデバイスの横幅を等しくする処理
//          width: MediaQuery.of(context).size.width,
//          alignment: Alignment.topCenter,
//        )
      ],
    );
  }

  //画像表示してfirebaseに保存。
  Widget enableUpload(){
    return Container(
      child: Column(
        children: <Widget>[
          Image.file(_imageFile, height: 300.0, width: 300.0),
          RaisedButton(
            elevation:  7.0,
            child:Text('upload'),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: (){
              final StorageReference firebaseStorageRef =
                  FirebaseStorage.instance.ref().child('myimage.jpeg');
              final StorageUploadTask task = firebaseStorageRef.putFile(_imageFile);
            },
          )
        ]
      )
    );

  }




}
