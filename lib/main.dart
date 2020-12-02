import 'package:flutter/material.dart';
import 'package:pupademo/config/routes.dart';
import 'package:pupademo/presentation/film_detail.dart';
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
      routes: _registerRoute(),
      onGenerateRoute: _registerRouteWithParameters,
    );
  }

  //https://starwars-visualguide.com/assets/img/films/4.jpg
  //https://starwars-visualguide.com/assets/img/characters/1.jpg
  Map<String, WidgetBuilder> _registerRoute() {
    return <String, WidgetBuilder>{
      AppRoutes.home: (context) => MyHomePage(title: 'Star war films'),
      AppRoutes.test: (context) => MyHomePage(title: 'TEST Screen'),
    };
  }

  Route _registerRouteWithParameters(RouteSettings settings) {
    if (settings.name == AppRoutes.film_detail) {
      final filmId = settings.arguments; // get parameter
      return MaterialPageRoute(builder: (context) {
        return FilmDetailPage(
          filmId: filmId,
        );
      });
    }
  }
}
