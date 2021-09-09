import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:navi_puntos/src/pages/inicio_page.dart';
import 'package:navi_puntos/src/utils/constantes.dart';
import 'package:navi_puntos/src/widgets/Grid.dart';
import 'package:navi_puntos/src/widgets/GridButton.dart';
import 'package:navi_puntos/src/widgets/Menu.dart';
import 'package:http/http.dart' as http;
import 'package:navi_puntos/src/widgets/MyTitle.dart';

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
  static int contadorIntentos = 1;
}

class _BoardState extends State<Board> {
  var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  int move = 0;

  static const duration = const Duration(seconds: 1);
  int secondsPassed = 0;
  bool isActive = false;
  Timer timer;
  @override
  void initState() {
    super.initState();
    numbers.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        startTime();
      });
    }

    return SafeArea(
      child: Container(
        height: size.height,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: MyTitle(size),
            ),
            Grid(numbers, size, clickGrid),
            Menu(reset, move, Board.contadorIntentos, size),
            Image.asset(
              'assets/corteva.png',
              height: size.height * 0.045,
            ),
          ],
        ),
      ),
    );
  }

  void clickGrid(index) {
    if (secondsPassed == 0) {
      isActive = true;
    }
    if (index - 1 >= 0 && numbers[index - 1] == 0 && index % 4 != 0 ||
        index + 1 < 16 && numbers[index + 1] == 0 && (index + 1) % 4 != 0 ||
        (index - 4 >= 0 && numbers[index - 4] == 0) ||
        (index + 4 < 16 && numbers[index + 4] == 0)) {
      setState(() {
        move++;
        numbers[numbers.indexOf(0)] = numbers[index];
        numbers[index] = 0;
      });
    }
    checkWin();
  }

  void startTime() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  void reset() {
    setState(() {
      Board.contadorIntentos++;
      if (Board.contadorIntentos <= 3) {
        numbers.shuffle();
        move = 0;
        secondsPassed = 0;
        isActive = false;
        print(Board.contadorIntentos);
      } else {
        // Board.contadorIntentos = 3;
        _insertarRegistro(Board.contadorIntentos);
      }
    });
  }

  bool isSorted(List list) {
    int prev = list.first;
    for (var i = 1; i < list.length - 1; i++) {
      int next = list[i];
      if (prev > next) return false;
      prev = next;
    }
    return true;
  }

  void checkWin() {
    if (isSorted(numbers)) {
      isActive = false;
      _dialog();
    }
  }

  void _dialog() {
    showDialog(
        barrierColor: Colors.black26,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              decoration: BoxDecoration(
                color: HexColor('#107ec1'),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 550,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/dialog_win.png'),
                      SizedBox(
                        width: 220.0,
                        child: RaisedButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          onPressed: () {
                            Navigator.of(context).pushNamed('inicio');
                          },
                          child: Text(
                            "Ok",
                            style: TextStyle(
                                color: HexColor('#107ec1'),
                                fontWeight: FontWeight.w600),
                          ),
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  _dialogerror() {
    showDialog(
        barrierColor: Colors.black26,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              decoration: BoxDecoration(
                color: HexColor('#107ec1'),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 550,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/dialog_lose2.png'),
                      SizedBox(
                        width: 220.0,
                        child: RaisedButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          onPressed: () {
                            Navigator.of(context).pushNamed('inicio');
                          },
                          child: Text(
                            "Ok",
                            style: TextStyle(
                                color: HexColor('#107ec1'),
                                fontWeight: FontWeight.w600),
                          ),
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void _insertarRegistro(int intentos) async {
    Board.contadorIntentos = 0;
    String puntos;
    String estado;
    if (intentos == 1) {
      puntos = "1000";
      estado = "Completado";
    } else if (intentos == 2) {
      puntos = "500";
      estado = "Completado";
    } else if (intentos == 3) {
      puntos = "250";
      estado = "Completado";
    } else {
      puntos = "0";
      estado = "No Completado";
    }
    String url = Constantes.urlServer + "registroActividadFinalizada";
    var response = await http.post(url, body: {
      'idUsuarioActividad': InicioPage.idUsuarioActividad,
      'estado': estado,
      'puntos': puntos,
    });
    int suma =
        int.parse(InicioPage.listaPuntos[0]["puntos"]) + int.parse(puntos);
    InicioPage.listaPuntos[0]["puntos"] = suma.toString();
    List respuestaJson = jsonDecode(response.body);
    if (respuestaJson[0]["respuestaInsercion"] == "ok") {
      //GridButton.banderaImagenes = false;
      if (puntos == "0") {
        _dialogerror();
      } else {
        _dialog();
      }
    }
  }
}
