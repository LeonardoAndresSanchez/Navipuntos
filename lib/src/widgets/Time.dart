import 'package:flutter/material.dart';

class Time extends StatelessWidget {
  int secondsPassed;

  Time(this.secondsPassed);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Text(
        "Intentos: $secondsPassed/3",
        style: TextStyle(
          fontSize: 18,
          decoration: TextDecoration.none,
          color: Colors.blue,
        ),
      ),
    );
  }
}
