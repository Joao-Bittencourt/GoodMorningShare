import 'package:flutter/material.dart';
import 'package:good_morning_share/model/DatabaseHelper.dart';
import 'GaleryPage.dart';
import 'model/favoritos.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Favoritos> _favorito;

  @override
  void initState() {
    _postFavApi();
    super.initState();
  }

  _postFavApi() async {
    DatabaseHelper db = DatabaseHelper();

    db.getFavoritos().then((value) {
      this.setState(() {
        _favorito = value;
      });
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
    if (this._favorito == null) {
      return emptyIds();
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => GalleryPage(
                  this._favorito[index].url, this._favorito[index].id),
            ),
          );
        },
        child: Image.network('${this._favorito[index].url}'),
      ),
      itemCount: this._favorito.length,
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
