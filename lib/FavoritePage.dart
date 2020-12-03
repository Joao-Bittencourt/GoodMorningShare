import 'dart:convert';
// import 'package:good_morning_share/model/favoritos.dart';
import 'package:flutter/material.dart';
import 'package:good_morning_share/model/DatabaseHelper.dart';

import 'model/favoritos.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  DatabaseHelper db = DatabaseHelper();

  List<Favoritos> Favorito = List<Favoritos>();

  @override
  void initState() {
    super.initState();

    Favoritos f = Favoritos(1, 'id1');
    db.insertFavorito(f);
    db.getFavoritos().then((lista) {
      print(lista);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('atention'),
    );
  }
}
