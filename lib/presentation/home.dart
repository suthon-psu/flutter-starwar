import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pupademo/config/routes.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var films = [];

  @override
  void initState() {
    super.initState();
    getFilms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: films.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () => Navigator.of(context).pushNamed(
                  AppRoutes.film_detail,
                  arguments: films[index]["url"]),
              child: Container(
                height: 50,
                child: Card(
                    child: Center(child: Text('${films[index]["title"]}'))),
              ),
            );
          }),
    );
  }

  Future getFilms() async {
    var url = 'https://swapi.dev/api/films';

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        this.films = jsonResponse["results"];
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
