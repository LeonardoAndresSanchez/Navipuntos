import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:navi_puntos/src/pages/home/inicio_page.dart';
import 'package:navi_puntos/src/utils/constantes.dart';

class Puzzle2Page extends StatefulWidget {
  @override
  _Puzzle2PageState createState() => _Puzzle2PageState();
  static int contadorIntentos = 1;
}

class _Puzzle2PageState extends State<Puzzle2Page> {
  var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  String _opcionSelecionada = '1';
  String _respuesta = '12';
  String _obtnerRespuesta;
  int opt;
  String tipoTrivia;
  String rutaPista, rutaTrivia, rutaRespuesta, respuesta;
  TextEditingController controlador = TextEditingController();

  @override
  void initState() {
    final _random = new Random();
    opt = _random.nextInt(4);
    rutaTrivia = InicioPage.listaTrivia[opt].trivia;
    rutaRespuesta = InicioPage.listaTrivia[opt].imagenRespuesta;
    rutaPista = InicioPage.listaTrivia[opt].pista;
    respuesta = InicioPage.listaTrivia[opt].respuesta;
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
      body: ListView(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image(
                    image: NetworkImage(Constantes.urlServer + rutaTrivia),
                    height: size.height * 0.20,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  width: double.infinity,
                  height: size.height * 0.40,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(2)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image(
                      image: NetworkImage(Constantes.urlServer + rutaPista),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image:
                            NetworkImage(Constantes.urlServer + rutaRespuesta),
                        height: size.height * 0.09,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 8),
                        child: Container(
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: //_crearDropDown(),
                                Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: _crearinput(),
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                MaterialButton(
                  height: 40,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(13.0)),
                  child: Text(
                    'Validar Respuesta',
                    //textScaleFactor: 1.0,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  elevation: 5.0,
                  color: HexColor('#107ec1'),
                  textColor: Colors.grey[350],
                  padding: EdgeInsets.all(15),
                  onPressed: () {
                    _validarRespuesta();
                  },
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _dialog() {
    showDialog(
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
                        child: MaterialButton(
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

  void _dialogerror() {
    showDialog(
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
                      Image.asset('assets/dialog_lose.png'),
                      SizedBox(
                        width: 220.0,
                        child: MaterialButton(
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

  _crearinput() {
    TextEditingController controlador = TextEditingController();
    return TextField(
        selectionWidthStyle: BoxWidthStyle.max,
        cursorColor: Colors.grey[300],
        keyboardType: TextInputType.phone,
        textAlign: TextAlign.center,
        textInputAction: TextInputAction.send,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: Colors.grey[300]),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 0, color: Colors.grey[300]),
          ),
          contentPadding: EdgeInsets.all(8),
          hintStyle: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
          hintText: '0',
        ),
        onChanged: (valor) => setState(() {
              _obtnerRespuesta = valor;
              print(valor);
            }));
  }

  void _insertarRegistro(String respuesta) async {
    String puntos;
    String estado;
    if (respuesta == "correcto") {
      puntos = "1000";
      estado = "Completado";
    } else if (respuesta == "incorrecto") {
      puntos = "0";
      estado = "No Completado";
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
      if (respuesta == "correcto") {
        final duration = new Duration(seconds: 2);
        new Timer(duration, () {
          _dialog();
        });
      } else if (respuesta == "incorrecto") {
        final duration = new Duration(seconds: 2);
        new Timer(duration, () {
          _dialogerror();
        });
      }
    }
  }

  void _validarRespuesta() {
    if (_obtnerRespuesta == respuesta.toString()) {
      _insertarRegistro("correcto");
    } else {
      _insertarRegistro("incorrecto");
    }
  }
}
