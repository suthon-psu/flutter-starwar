import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class FilmDetailPage extends StatefulWidget {
  String filmUrl;
  FilmDetailPage({Key key, this.filmUrl}) : super(key: key);

  @override
  _FilmDetailPageState createState() => _FilmDetailPageState();
}

class _FilmDetailPageState extends State<FilmDetailPage> {
  var film = {};

  @override
  void initState() {
    super.initState();
    getFilm(widget.filmUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(film["title"] ?? "......"),
      ),
      body: Text("Film Detail"),
    );
  }

  Future getFilm(url) async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        this.film = jsonResponse;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
