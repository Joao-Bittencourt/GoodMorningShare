import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:good_morning_share/FavoritePage.dart';
import 'package:http/http.dart' as http;
import 'model/DatabaseHelper.dart';
import 'model/favoritos.dart';

class GoodMorningShareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('Good Morning share'),
            backgroundColor: Colors.green,
          ),
          body: ImagesGalery(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FavoritePage();
              }));
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.star),
          ),
        ));
  }
}

//classe principal que carrega e monta as imagens
class ImagesGalery extends StatefulWidget {
  @override
  _ImagesGaleryState createState() => _ImagesGaleryState();
}

// Pagina quando clica para abrir
class GalleryPage extends StatelessWidget {
  final String id;
  List<String> _favoriteId = new List();
  GalleryPage(this.id);
  Favoritos existFav;

  //@ToDo ver como passar como variavel unica
  final String serviceUrl = 'https://goodmorningshareapi.herokuapp.com';

  _postApi([int id]) async {
    DatabaseHelper db = DatabaseHelper();
    db.getFavorito(id).then((value) {
      this.existFav = value;
      // print(value);
    });
    // print(existFav);
    // print(this.existFav);

    if (this.existFav != null) {
      db.deleteFavorito(this.existFav.id);
    }

    if (this.existFav == null) {
      Favoritos a = Favoritos(id, 'imagem $id');
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
              _favoriteId.add(this.id);
              _postApi(int.tryParse(this.id));
            },
          ),
        ],
      ),
      backgroundColor: Colors.green,
      body: Center(
        // child: Image.network('https://picsum.photos/id/${id}/600/600'),
        child: Image.network(
            '$id'),
      ),
    );
  }
}

//Pagina principal que mota as imagens
class _ImagesGaleryState extends State<ImagesGalery> {
  bool loading;
  List<String> ids;
  List<String> favoriteId;

  //@ToDo ver como passar como variavel unica
  final String serviceUrl = 'https://goodmorningshareapi.herokuapp.com';

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
    final response =
        await http.get(this.serviceUrl+'/imagens/listar');
    final json = jsonDecode(response.body);
    List<String> _ids = [];

    for (var image in json) {
      _ids.add(image['url'].toString());
    }
    setState(() {
      loading = false;
      ids = _ids;
    });
  }

  void _loadFavoriteImages() async {
    final response =
        await http.get(this.serviceUrl+'/imagens/listar');

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<String> _favoriteId = [];

      for (var image in json) {
       
        _favoriteId.add(image['url'].toString());
      }
      setState(() {
        loading = false;
        favoriteId = _favoriteId;
      });
    } else {
      setState(() {
        loading = false;
        favoriteId = [];
      });
    }
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
        child: Image.network(
            
            '${ids[index]}'),
      ),
      itemCount: ids.length,
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: GoodMorningShareApp(),
  ));
}
