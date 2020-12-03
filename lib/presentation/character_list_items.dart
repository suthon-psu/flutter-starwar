import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class CharacterListItemsPage extends StatefulWidget {
  String characterUrl;
  CharacterListItemsPage({Key key, this.characterUrl}) : super(key: key);

  @override
  _CharacterListItemsPageState createState() => _CharacterListItemsPageState();
}

class _CharacterListItemsPageState extends State<CharacterListItemsPage> {
  var character = {};

  @override
  void initState() {
    super.initState();
    getCharacter(widget.characterUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Text(character["name"] ?? " ");
  }

  Future getCharacter(url) async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        this.character = jsonResponse;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
