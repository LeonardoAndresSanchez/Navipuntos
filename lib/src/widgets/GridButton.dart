import 'dart:math';

import 'package:flutter/material.dart';
import 'package:navi_puntos/src/models/imagenpuzzle.dart';
import 'package:navi_puntos/src/pages/inicio_page.dart';
import 'package:navi_puntos/src/utils/constantes.dart';

class GridButton extends StatefulWidget {
  Function click;
  String text;
  int opt;

  GridButton(this.text, this.click, this.opt);

  @override
  _GridButtonState createState() => _GridButtonState();
  static var arregloTemp = [];
  static int banderaImagenes = 0;
  static List<ImagenPuzzle> arreglo = InicioPage.listaPuzzle;
}

class _GridButtonState extends State<GridButton> {
  String tipo;
  int opt;

  String rutaImg;
  @override
  void initState() {
    // widget.opt = 3;
    if (widget.opt == 0) {
      tipo = "puzzle1";
    } else if (widget.opt == 1) {
      tipo = 'puzzle2';
    } else {
      tipo = 'puzzle3';
    }
    // opt = 2;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RaisedButton(
          padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
          elevation: 1,
          child: _cargarImagenPuzzle(context, widget.text),
          splashColor: Colors.lightBlue,
          highlightColor: Colors.blueAccent,
          color: Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(2.0),
          ),
          onPressed: widget.click,
        ),
      ],
    );
  }

  Widget _cargarImagenPuzzle(context, String text) {
    final size = MediaQuery.of(context).size;
    Widget widget;
    switch (tipo) {
      case "puzzle1":
        if (InicioPage.listaPuzzle[int.parse(text) - 1].tipoPuzzle ==
            "puzzle1") {
          widget = Image(
            image: NetworkImage(Constantes.urlServer +
                InicioPage.listaPuzzle[int.parse(text) - 1].rutaImagen),
            height: size.height * 0.10,
            fit: BoxFit.cover,
          );
        }
        break;
      case "puzzle2":
        if (int.parse(text) - 1 <= 14) {
          if (InicioPage.listaPuzzle[int.parse(text) - 1 + 15].tipoPuzzle ==
              "puzzle2") {
            widget = Image(
              image: NetworkImage(Constantes.urlServer +
                  InicioPage.listaPuzzle[int.parse(text) - 1 + 15].rutaImagen),
              height: size.height * 0.10,
              fit: BoxFit.cover,
            );
          }
        }

        break;
      case 'puzzle3':
        if (int.parse(text) - 1 <= 14) {
          if (InicioPage.listaPuzzle[int.parse(text) - 1 + 30].tipoPuzzle ==
              "puzzle3") {
            widget = Image(
              image: NetworkImage(Constantes.urlServer +
                  InicioPage.listaPuzzle[int.parse(text) - 1 + 30].rutaImagen),
              height: size.height * 0.10,
              fit: BoxFit.cover,
            );
          }
        }

        break;
      default:
    }
    return widget;
  }
}
