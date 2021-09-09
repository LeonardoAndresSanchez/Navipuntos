import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:navi_puntos/src/models/respuestaPregunta.dart';
import 'package:navi_puntos/src/pages/inicio_page.dart';
import 'package:navi_puntos/src/utils/constantes.dart';
import 'package:navi_puntos/src/utils/styles.dart';
import 'package:http/http.dart' as http;

class PreguntasPage2 extends StatefulWidget {
  @override
  PreguntasPageState2 createState() => PreguntasPageState2();
}

class PreguntasPageState2 extends State<PreguntasPage2> {
  Color text = Colors.black;
  Color btn = Colors.white;
  Color text2 = Colors.black;
  Color btn2 = Colors.white;
  Color text3 = Colors.black;
  Color btn3 = Colors.white;
  Color textcorret = Colors.black;
  Color btncorret = Colors.white;
  int opt;
  List<RespuestaPregunta> listaRespuestasTemp = new List();
  static List listaRespuestas = new List();
  bool bandera = false;

  @override
  void initState() {
    final _random = new Random();
    opt = _random.nextInt(9);
    // opt = 10;
    var idPregunta = InicioPage.listaPreguntas[opt].idPregunta;

    for (var i = 0; i < InicioPage.listaRespuestas.length; i++) {
      if (InicioPage.listaRespuestas[i].idPregunta == idPregunta) {
        listaRespuestasTemp.add(InicioPage.listaRespuestas[i]);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/navi_logo_blanco.png',
          height: size.height * 0.05,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pushNamed('inicio'),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
              child: Image(
                image: NetworkImage(Constantes.urlServer +
                    InicioPage.listaPreguntas[opt].pregunta),
                height: size.height * 0.40,
              ),
            ),
            SizedBox(
              height: size.height * 0.020,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                // height: 365,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 35, horizontal: 50),
                  child: _listaRespuestas(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                color: HexColor('#007FC8'),
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
                                color: HexColor('#007FC8'),
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

  void _dialogerror() {
    showDialog(
        barrierColor: Colors.black26,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              decoration: BoxDecoration(
                color: HexColor('#007FC8'),
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
                      Image.asset('assets/dialog_lose.png'),
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
                                color: HexColor('#007FC8'),
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

  void _validarRespuesta(int index) {
    PreguntasPageState2.listaRespuestas.clear();
    if (listaRespuestasTemp[index].correcta == "1") {
      setState(() {
        PreguntasPageState2.listaRespuestas.add("respuestaCorrecta");
        PreguntasPageState2.listaRespuestas.add(index);
        // btncorret = Colors.green;
        textcorret = Colors.white;
      });
      _insertarRegistro("correcto");
    } else {
      setState(() {
        PreguntasPageState2.listaRespuestas.add("respuestaIncorrecta");
        PreguntasPageState2.listaRespuestas.add(index);
        // btncorret = Colors.red;
        textcorret = Colors.white;
      });
      _insertarRegistro("incorrecto");
    }
  }

  void _insertarRegistro(String validacion) async {
    String estado;
    String puntos;
    if (validacion == "correcto") {
      estado = "Completado";
      puntos = "1000";
    } else {
      estado = "No Completado";
      puntos = "0";
    }
    int suma =
        int.parse(InicioPage.listaPuntos[0]["puntos"]) + int.parse(puntos);
    InicioPage.listaPuntos[0]["puntos"] = suma.toString();
    String url = Constantes.urlServer + "registroActividadFinalizada";
    var response = await http.post(url, body: {
      'idUsuarioActividad': InicioPage.idUsuarioActividad,
      'estado': estado,
      'puntos': puntos,
    });
    List respuestaJson = jsonDecode(response.body);
    if (respuestaJson[0]["respuestaInsercion"] == "ok") {
      if (validacion == "correcto") {
        _dialog();
      } else {
        _dialogerror();
      }
    }
  }

  _listaRespuestas() {
    final size = MediaQuery.of(context).size;
    Widget algo = null;

    if (PreguntasPageState2.listaRespuestas.length > 0) {
      algo = Center(
        child: ListView.builder(
          itemCount: listaRespuestasTemp.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: size.width * 0.27,
                height: size.height * 0.069,
                child: RaisedButton(
                  elevation: 0,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(12.0)),
                  color: listaRespuestasTemp[
                                      PreguntasPageState2.listaRespuestas[1]]
                                  .correcta ==
                              "1" &&
                          PreguntasPageState2.listaRespuestas[1] == index
                      ? Colors.green
                      : listaRespuestasTemp[PreguntasPageState2
                                          .listaRespuestas[1]]
                                      .correcta ==
                                  "0" &&
                              PreguntasPageState2.listaRespuestas[1] == index
                          ? Colors.red
                          : Colors.white,
                  onPressed: () {
                    _validarRespuesta(index);
                  },
                  child: Text(
                    '${listaRespuestasTemp[index].respuestaPregunta}',
                    textScaleFactor: 1.2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: listaRespuestasTemp[PreguntasPageState2
                                          .listaRespuestas[1]]
                                      .correcta ==
                                  "1" &&
                              PreguntasPageState2.listaRespuestas[1] == index
                          ? Colors.white
                          : listaRespuestasTemp[PreguntasPageState2
                                              .listaRespuestas[1]]
                                          .correcta ==
                                      "0" &&
                                  PreguntasPageState2.listaRespuestas[1] ==
                                      index
                              ? Colors.white
                              : Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    } else {
      algo = ListView.builder(
        itemCount: listaRespuestasTemp.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: size.width * 0.27,
              height: size.height * 0.069,
              child: RaisedButton(
                elevation: 0,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(12.0)),
                color: Colors.white,
                onPressed: () {
                  _validarRespuesta(index);
                },
                child: Text(
                  '${listaRespuestasTemp[index].respuestaPregunta}',
                  textScaleFactor: 1.2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textcorret,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return algo;
  }
}
