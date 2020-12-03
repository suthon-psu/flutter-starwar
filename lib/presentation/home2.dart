import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pupademo/config/routes.dart';

class MyHomePage2 extends StatelessWidget {
  MyHomePage2({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFilms(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var films = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
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
                          child:
                              Center(child: Text('${films[index]["title"]}'))),
                    ),
                  );
                }),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future getFilms() async {
    var url = 'https://swapi.dev/api/films';

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse["results"];
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
