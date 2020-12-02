import 'package:flutter/material.dart';
import 'package:pupademo/config/routes.dart';
import 'package:pupademo/presentation/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: MyHomePage(title: 'Star war films'),
        routes: _registerRoute());
  }

  //https://starwars-visualguide.com/assets/img/films/4.jpg
  //https://starwars-visualguide.com/assets/img/characters/1.jpg
  Map<String, WidgetBuilder> _registerRoute() {
    return <String, WidgetBuilder>{
      AppRoutes.home: (context) => MyHomePage(title: 'Star war films'),
      '/test': (context) => MyHomePage(title: 'TEST Screen'),
    };
  }
}
