import 'package:flutter/material.dart';

class Progresso extends StatelessWidget {
  const Progresso({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Loading'),
          )
        ],
      ),
    );
  }
}