import 'dart:convert';
// import 'package:good_morning_share/model/favoritos.dart';
import 'package:flutter/material.dart';
import 'package:good_morning_share/model/DatabaseHelper.dart';

import 'model/favoritos.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        backgroundColor: Colors.green,
      ),
      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     child: Text('Go back!'),
      //   ),
      // ),
      body: Center(
        child: Image.network('https://picsum.photos/id/100/600/600'),
      ),
    );
  }
}
