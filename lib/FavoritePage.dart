import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:good_morning_share/model/DatabaseHelper.dart';
import 'model/favoritos.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Favoritos> _favorito;

  @override
  void initState() {
    super.initState();
    _postApi();
  }

  _postApi() async {
    DatabaseHelper db = DatabaseHelper();

    db.getFavoritos().then((value) {
      this.setState(() {
        _favorito = value;
      });

      // print(value);
      // print(this._favorito);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        backgroundColor: Colors.green,
      ),
      body: listaFav(),
    );
  }

  listaFav() {
    // _postApi();

    if (this._favorito == null) {
      return emptyIds();
    }
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(this._favorito.length, (index) {
        return Center(
          child: Image.network(
              'https://picsum.photos/id/${this._favorito[index].id}/300/300'),
        );
      }),
    );
  }

  emptyIds() {
    return Scaffold(
      body: Center(
        child: Text('Não possui imagens favoritadas!'),
      ),
    );
  }
}
