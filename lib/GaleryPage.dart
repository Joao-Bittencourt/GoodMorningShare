// Pagina quando clica para abrir
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/DatabaseHelper.dart';
import 'model/favoritos.dart';

// ignore: must_be_immutable
class GalleryPage extends StatelessWidget {
  int id;
  String url;

  GalleryPage(this.url, this.id);

  String serviceUrl = 'https://goodmorningshareapi.herokuapp.com';

  _postApi(String url, int id) async {
    DatabaseHelper db = DatabaseHelper();

    db.getFavorito(id).then((value) {
      if (value != null) {
        db.deleteFavorito(value.id);
      }

      if (value == null) {
        Favoritos a = Favoritos(id, url);
        db.insertFavorito(a);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Good Morning share detail'),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            tooltip: 'Search',
            onPressed: () {
              _postApi(url, id);
            },
          ),
        ],
      ),
      backgroundColor: Colors.green[300],
      body: Center(
        child: Image.network(url),
      ),
    );
  }
}
