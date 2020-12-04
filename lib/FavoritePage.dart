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

    Favoritos f = Favoritos(null, "na");
    db.create(f);
    db.dogs().then((lista) {
      this.Favorito = lista;
    });
    print(Favorito.cast());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        backgroundColor: Colors.green,
      ),
      body: ImagesGalery(),
    );
  }

  listaFav() {
    _postApi();

    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://picsum.photos/id/${Favorito[index].nome}/600/600'),
          ),
          title: Text(Favorito[index].nome,
              style: TextStyle(fontSize: 20.0, color: Colors.black)),
          subtitle: Text(Favorito[index].nome),
        );
      },
    );
  }
}
