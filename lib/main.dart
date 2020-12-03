import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:good_morning_share/FavoritePage.dart';
import 'package:http/http.dart' as http;

import 'model/DatabaseHelper.dart';
import 'model/favoritos.dart';

void main() {
  runApp(GoodMorningShareApp());
}

class GoodMorningShareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('Good Morning share'),
            backgroundColor: Colors.green,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.star_rate),
                  tooltip: 'Search pagina inicial',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GalleryPage('100'),
                      ),
                    );
                  }),
            ],
          ),
          body: ImagesGalery(),
        ));
  }
}

class ImagesGalery extends StatefulWidget {
  @override
  _ImagesGaleryState createState() => _ImagesGaleryState();
}

class GalleryPage extends StatelessWidget {
  final String id;
  List<String> _favoriteId = new List();
  GalleryPage(this.id);
  _postApi() async {
    DatabaseHelper db = DatabaseHelper();

    List<Favoritos> Favorito = List<Favoritos>();

    Favoritos f = Favoritos(int.tryParse(this.id), this.id);
    db.insertFavorito(f);
    db.getFavoritos().then((lista) {
      print(lista);
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
              _favoriteId.add(this.id);
              _postApi();
              // favoriteId.add(int.tryParse(this.id), this.id);
            },
          ),
        ],
      ),
      backgroundColor: Colors.green,
      body: Center(
        child: Image.network('https://picsum.photos/id/${id}/600/600'),
      ),
    );
  }
}

class GalleryFavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // GalleryFavoritePage(this.favoriteId);
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('favorite Page'),
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.star),
              tooltip: 'Search',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GalleryFavoritePage(),
                  ),
                );
              },
            )
          ],
        ),
        backgroundColor: Colors.green,
        body: Center(
          child: Image.network('https://picsum.photos/id/100/600/600'),
        ),
      );
    }
  }
}

class _ImagesGaleryState extends State<ImagesGalery> {
  bool loading;
  List<String> ids;
  List<String> favoriteId;

  @override
  void initState() {
    loading = true;
    ids = [];
    favoriteId = [];

    _loadImagesId();

    _loadFavoriteImages();

    super.initState();
  }

  void _loadImagesId() async {
    final response = await http.get('https://picsum.photos/v2/list');
    final json = jsonDecode(response.body);
    List<String> _ids = [];

    for (var image in json) {
      _ids.add(image['id']);
    }
    setState(() {
      loading = false;
      ids = _ids;
    });
  }

  void _loadFavoriteImages() async {
    final response = await http.get('https://picsum.photos/v2/list');
    final json = jsonDecode(response.body);
    List<String> _favoriteId = [];

    for (var image in json) {
      _favoriteId.add(image['id']);
    }
    setState(() {
      loading = false;
      favoriteId = _favoriteId;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => GalleryPage(ids[index]),
            ),
          );
        },
        child: Image.network('https://picsum.photos/id/${ids[index]}/300/300'),
      ),
      itemCount: ids.length,
    );
  }
}
