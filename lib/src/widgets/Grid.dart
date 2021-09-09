import 'dart:math';

import 'package:flutter/material.dart';
import 'GridButton.dart';

class Grid extends StatelessWidget {
  var numbers = [];
  var size;
  Function clickGrid;
  static int opt;

  Grid(this.numbers, this.size, this.clickGrid);

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    var height = size.height;

    return Container(
      // margin: EdgeInsets.all(3.0),
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: new BorderRadius.circular(8.0),
      ),
      height: height * 0.50,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 0.2,
          crossAxisSpacing: 0.2,
        ),
        itemCount: numbers.length,
        itemBuilder: (context, index) {
          return numbers[index] != 0
              ? GridButton("${numbers[index]}", () {
                  clickGrid(index);
                }, opt)
              : SizedBox.shrink();
        },
      ),
    );
  }
}
