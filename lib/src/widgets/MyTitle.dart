import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  var size;

  MyTitle(this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.07,
      padding: EdgeInsets.all(10.0),
      child: Text(
        "Rompecabezas",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: size.height * 0.030,
            color: Colors.green,
            decoration: TextDecoration.none),
      ),
    );
  }
}
