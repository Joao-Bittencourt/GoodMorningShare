import 'dart:async';

import 'package:good_morning_share/model/favoritos.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:flutter/services.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

//usada para definir as colunas da tabeala
  String favoritosTable = 'favoritos_gms';
  String colId = 'id';
  String colUrl = 'url';

  //construtor nomeado para criar instância da classe
  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      // executado somente uma vez
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $favoritosTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$colUrl TEXT)');
  }

  Future<Database> initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "dbfavoritos_gms.db");

    var contatosDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return contatosDatabase;
  }

//Incluir um objeto contato no banco de dados
  Future<int> insertFavorito(Favoritos contato) async {
    Database db = await this.database;

    var resultado = await db.insert(favoritosTable, contato.toMap());

    return resultado;
  }

  Future create(Favoritos model) async {
    try {
      final Database db = await this.database;

      await db.insert(
        favoritosTable,
        model.toMap(),
      );
    } catch (ex) {
      print(ex);
      return;
    }
  }

//retorna um Favorito pelo id
  Future<Favoritos> getFavorito(int id) async {
    Database db = await this.database;

    List<Map> maps = await db.query(favoritosTable,
        columns: [colId, colUrl], where: "$colId = ?", whereArgs: [id]);

    if (maps.length > 0) {
      return Favoritos.fromMap(maps.first);
    } else {
      return null;
    }
  }

  //Atualizar o objeto Favoritos e salva no banco de dados
  Future<int> updateFavorito(Favoritos contato) async {
    var db = await this.database;

    var resultado = await db.update(favoritosTable, contato.toMap(),
        where: '$colId = ?', whereArgs: [contato.id]);

    return resultado;
  }

  //Deletar um objeto Favorito do banco de dados
  Future<int> deleteFavorito(int id) async {
    var db = await this.database;

    int resultado =
        await db.delete(favoritosTable, where: "$colId = ?", whereArgs: [id]);

    return resultado;
  }

  // Deleta todos os registro da tabela
  Future<int> deleteFavoritos() async {
    var db = await this.database;

    int resultado = await db.delete(favoritosTable, where: "1 = 1");

    return resultado;
  }

//retorna todos os ids das imagens registaradas
  Future<List<Favoritos>> getFavoritos() async {
    Database db = await this.database;
    var resultado = await db.query(favoritosTable);
    List<Favoritos> lista = resultado.isNotEmpty
        ? resultado.map((c) => Favoritos.fromMap(c)).toList()
        : [];

    return lista;
  }

//Obtem o número de objetos contato no banco de dados
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $favoritosTable');

    int resultado = Sqflite.firstIntValue(x);
    return resultado;
  }

  Future close() async {
    Database db = await this.database;
    db.close();
  }

  Future<List<Favoritos>> getAll() async {
    Database db = await this.database;
    List<Map<String, dynamic>> resultado = await db.query(favoritosTable);
    return resultado.map((map) => Favoritos.fromMap(map));
  }
}
