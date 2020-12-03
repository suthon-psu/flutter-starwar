import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class CharacterListItemsWidget extends StatefulWidget {
  String characterUrl;
  CharacterListItemsWidget({Key key, this.characterUrl}) : super(key: key);

  @override
  _CharacterListItemsWidgetState createState() =>
      _CharacterListItemsWidgetState();
}

class _CharacterListItemsWidgetState extends State<CharacterListItemsWidget> {
  var character = {};

  @override
  void initState() {
    super.initState();
    getCharacter(widget.characterUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://starwars-visualguide.com/assets/img/characters/${character['id']}.jpg"),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Text(
          character['name'] ?? " ",
        ),
      ),
    );
  }

  Future getCharacter(url) async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        this.character = jsonResponse;
        this.character["id"] = getIdFromCharacterUrl(url);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  String getIdFromCharacterUrl(url) {
    final id = url.split("http://swapi.dev/api/people/")[1];
    return id.split('/')[0];
  }
}
