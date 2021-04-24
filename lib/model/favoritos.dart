class Favoritos {
  int id;
  String url;

  Favoritos(this.id, this.url);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{'id': id, 'url': url};
    return map;
  }

  Favoritos.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    url = map['url'];
  }

  @override
  String toString() {
    return "Favoritos => (id: $id, url:$url)";
  }
}

// void _loadFavoriteImages() async {
//   final response = await http.get(this.serviceUrl + '/imagens/listar');

//   if (response.statusCode == 200) {
//     final json = jsonDecode(response.body);
//     List<String> _favoriteId = [];

//     for (var image in json) {
//       _favoriteId.add(image['id'].toString());
//     }
//     setState(() {
//       loading = false;
//       favoriteId = _favoriteId;
//     });
//   } else {
//     setState(() {
//       loading = false;
//       favoriteId = [];
//     });
//   }
// }
