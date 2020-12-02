import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class FilmDetailPage extends StatefulWidget {
  int filmId;
  FilmDetailPage({Key key, this.filmId}) : super(key: key);

  @override
  _FilmDetailPageState createState() => _FilmDetailPageState();
}

class _FilmDetailPageState extends State<FilmDetailPage> {
  var film = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TITLE"),
      ),
      body: Text("Film Detail"),
    );
  }

  Future getFilm(id) async {
    var url = 'https://swapi.dev/api/films';

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        this.film = jsonResponse["results"];
        print(this.film);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
