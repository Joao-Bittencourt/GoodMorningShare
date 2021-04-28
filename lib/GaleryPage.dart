import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
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

  _onImageSaveButtonPressed(String url) async {
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(url);
      print(url);
      print(imageId);
      if (imageId == null) {
        return;
      }
      // Below is a method of obtaining saved image information.
      var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);
    } on PlatformException catch (error) {
      print(error);
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
            tooltip: 'Favoritar',
            onPressed: () {
              _postApi(url, id);
            },
          ),
          IconButton(
            icon: Icon(Icons.download_sharp),
            tooltip: 'Download',
            onPressed: () {
              _onImageSaveButtonPressed(url);
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
