import 'dart:convert';
// import 'package:good_morning_share/model/favoritos.dart';
import 'package:flutter/material.dart';
import 'package:good_morning_share/model/DatabaseHelper.dart';

import 'main.dart';
import 'model/favoritos.dart';

class FavoritePage extends StatelessWidget {
  List<Favoritos> Favorito;
  _postApi() async {
    DatabaseHelper db = DatabaseHelper();

    List<Favoritos> Favorito = List<Favoritos>();

    Favoritos f = Favoritos(100, "na");
    Favoritos f1 = Favoritos(10, "na1");
    Favoritos f2 = Favoritos(101, "na2");
    Favoritos f3 = Favoritos(11, "na3");
    // db.create(f);
    // db.dogs().then((lista) {
    //   this.Favorito = lista;
    // });
    // print(Favorito.cast());
    Favorito.add(f);
    Favorito.add(f1);
    Favorito.add(f2);
    Favorito.add(f3);
    print(Favorito[1].nome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        backgroundColor: Colors.green,
      ),
      // body: listaFav(),
      body: ImagesGalery(),
    );
  }

  listaFav() {
    _postApi();

    return MaterialApp(
      home: Scaffold(
        body: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 4,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(100, (index) {
            return Center(
              child: Image.network(
                  'https://picsum.photos/id/${Favorito[index].id}/300/300'),
            );
          }),
        ),
      ),
    );
  }
}
