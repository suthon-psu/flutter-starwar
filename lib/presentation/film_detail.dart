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
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          //https://starwars-visualguide.com/assets/img/films/4.jpg
          AspectRatio(
            aspectRatio: 4 / 3,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://starwars-visualguide.com/assets/img/films/${film["id"]}.jpg"),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Container(
            height: 50,
            color: Colors.amber[600],
            child: Center(child: Text('Director : ${film['director']}')),
          ),
          Container(
            height: 300,
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(film["characters"].length, (index) {
                return Center(
                  child: Text(
                    '${film["characters"][index]}',
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  Future getFilm(url) async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        this.film = jsonResponse;
        this.film["id"] = getIdFromFilmUrl(url);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  String getIdFromFilmUrl(url) {
    final id = url.split("http://swapi.dev/api/films/")[1];
    return id.split('/')[0];
  }
}
