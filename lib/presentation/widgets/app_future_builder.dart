import 'package:flutter/material.dart';

class AppFutureBuilder extends StatelessWidget {
  Future<dynamic> future;
  Widget Function(BuildContext, AsyncSnapshot<dynamic>) builder;

  AppFutureBuilder({Key key, this.future, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.hasData) {
      return builder(context, snapshot);
    } else {
      return CircularProgressIndicator();
    }
  }
}
