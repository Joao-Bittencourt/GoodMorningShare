// Pagina quando clica para abrir
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/DatabaseHelper.dart';
import 'model/favoritos.dart';

class GalleryPage extends StatelessWidget {
  int id;
  String url;

  GalleryPage(this.url, this.id);

  //@ToDo ver como passar como variavel unica
  String serviceUrl = 'https://goodmorningshareapi.herokuapp.com';

  _postApi(String url, int id) async {
    Favoritos existFav;
    DatabaseHelper db = DatabaseHelper();

    db.getFavorito(id).then((value) {
      Favoritos _existFav = Favoritos(value.id, value.url);
      existFav = _existFav;

      if (value.id != null) {
        db.deleteFavorito(value.id);
      }
    });

    if (existFav == null) {
      Favoritos a = Favoritos(id, url);
      db.insertFavorito(a);
    }
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
