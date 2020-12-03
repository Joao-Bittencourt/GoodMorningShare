class Favoritos {
  int id;
  String name;

  Favoritos(this.id, this.name);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{'id': id, 'nome': name};
    return map;
  }

  Favoritos.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['nome'];
  }
}
