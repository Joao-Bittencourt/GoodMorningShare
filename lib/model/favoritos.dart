class Favoritos {
  int id;
  String nome;

  Favoritos(this.id, this.nome);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{'id': id, 'nome': nome};
    return map;
  }

  Favoritos.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
  }

  @override
  String toString() {
    return "Favoritos => (id: $id, nome:$nome)";
  }
}
