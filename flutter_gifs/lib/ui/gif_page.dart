import 'package:flutter/material.dart';
import 'package:share/share.dart';

class GifPage extends StatelessWidget {
  final Map _gifData;

  GifPage(this._gifData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      backgroundColor: Colors.black,
      body: getBody(),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      title: Text(_gifData["title"]),
      backgroundColor: Colors.black,
      actions: <Widget>[getButtonShare()],
    );
  }

  Center getBody() {
    return Center(
      child: Image.network(_gifData["images"]["fixed_height"]["url"]),
    );
  }

  IconButton getButtonShare() {
    return IconButton(
      icon: Icon(Icons.share),
      onPressed: () {
        Share.share(_gifData["images"]["fixed_height"]["url"]);
      },
    );
  }
}
