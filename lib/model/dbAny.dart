import 'package:sqflite/sqflite.dart';

import 'dart:async';

class dbAny {
  Database _db;

  initDb() async {
    _db = await openDatabase('favoritosdb.db', version: 1,
        onCreate: (Database db, int version) {
      db.execute(
          "CREATE TABLE FavoritosAny(id INTEGER PRIMARY KEY AUTOINCREMENT,nome TEXT);");
    });
  }

  insert(dbDeny deny) async {
    _db.insert("FavoritosAny", deny.toMap());
  }

  Future<List<dbDeny>> getAll() async {
    List<Map<String, dynamic>> resultado = await _db.query("FavoritosAny");
    return resultado.map((map) => dbDeny.fromMap(map));
  }
}

class dbDeny {
  int id;
  String name;

  dbDeny(this.name);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  dbDeny.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }

  @override
  String toString() {
    return "any => (name:$name)";
  }
}
