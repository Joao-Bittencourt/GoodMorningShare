import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import 'GaleryPage.dart';

//classe principal que carrega e monta as imagens
class ImagesGalery extends StatefulWidget {
  @override
  _ImagesGaleryState createState() => _ImagesGaleryState();
}

//Pagina principal que monta as imagens
class _ImagesGaleryState extends State<ImagesGalery> {
  bool loading;
  List<String> urls;
  List<int> ids;

  //@ToDo ver como passar como variavel unica
  String serviceUrl = 'https://goodmorningshareapi.herokuapp.com';

  @override
  void initState() {
    loading = true;
    urls = [];
    ids = [];

    _loadImagesId();

    super.initState();
  }

  void _loadImagesId() async {
    final response = await http.get(this.serviceUrl + '/imagens/listar');
    final json = jsonDecode(response.body);
    List<String> _urls = [];
    List<int> _ids = [];

    for (var image in json) {
      _urls.add(image['url'].toString());
      _ids.add(image['id']);
    }
    setState(() {
      loading = false;
      urls = _urls;
      ids = _ids;
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
              builder: (context) => GalleryPage(urls[index], ids[index]),
            ),
          );
        },
        child: Image.network('${urls[index]}'),
      ),
      itemCount: urls.length,
    );
  }
}
