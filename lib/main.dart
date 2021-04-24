import 'package:flutter/material.dart';
import 'FavoritePage.dart';
import 'ImagesGalery.dart';

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

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: GoodMorningShareApp(),
  ));
}
