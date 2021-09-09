import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:collection/collection.dart';
import 'package:lottie/lottie.dart';
import 'package:navi_puntos/src/pages/inicio_page.dart';
import 'package:navi_puntos/src/utils/constantes.dart';
import 'package:http/http.dart' as http;

class PuzzleAhorcadoPage extends StatefulWidget {
  @override
  _PuzzleAhorcadoPageState createState() => _PuzzleAhorcadoPageState();
}

@override
bool bandera = false;
bool validacionIncorrectas = false;
bool valiarDialog = false;
BuildContext contexto;
int opt;
String imagenAhorcado;

class _PuzzleAhorcadoPageState extends State<PuzzleAhorcadoPage> {
  @override
  void initState() {
    super.initState();
    final _random = new Random();
    opt = _random.nextInt(5);
    // opt = 6;
    imagenAhorcado = InicioPage.listaAhorcado[opt].imagenAhorcado;
    // print(imagenAhorcado);
    valiarDialog = false;
    validacionIncorrectas = false;
    bandera = false;
  }

  String cosa;
  List<String> letras, letrasAzar, letrasRandom, letrasPalabraBuena;

  List<String> listaLetrasEncontradas = [];

  Color colorLetras = Colors.white;
  List listaEncontradas = [];
  List listaRecuperarLetras = [];
  var abecedario = ['abcdefghijklmñopwrstuwxtyz'];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    contexto = context;
    if (!valiarDialog) {
      return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () => Navigator.of(context).pushNamed('inicio'),
            ),
            centerTitle: true,
            title: Image.asset(
              'assets/navi_logo_blanco.png',
              height: size.height * 0.05,
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Center(
                    child: FadeInImage(
                      height: size.height * 0.40,
                      image: NetworkImage(
                        Constantes.urlServer + imagenAhorcado,
                      ),
                      placeholder: AssetImage('assets/carga.gif'),
                    ),
                  ),
                ),
              ),
              Container(
                  height: size.height * 0.13,
                  padding: EdgeInsets.all(2),
                  color: Colors.grey[300],
                  child: Center(
                    child: _letra(),
                  )),
              Expanded(
                child: Container(
                    height: size.height * 0.20,
                    color: HexColor('#107ec1'),
                    child: Center(
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          child: Center(
                            child: _letras(),
                          )),
                    )),
              )
            ],
          ));
    } else {
      _dialog();
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            'assets/navi_logo_blanco.png',
            height: size.height * 0.05,
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Center(
                  child: Image.asset(
                    'assets/carga.gif',
                    height: 300,
                  ),
                ),
              ),
            ),
            Container(
                height: 100,
                padding: EdgeInsets.all(1.5),
                color: Colors.grey[300],
                child: Center(
                  child: Text(''),
                )),
            Expanded(
              child: Container(
                  height: 200,
                  color: HexColor('#107ec1'),
                  child: Center(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Text(''),
                    ),
                  )),
            )
          ],
        ),
      );
    }
  }

  _letra() {
    for (var i = 0; i < InicioPage.listaAhorcado.length; i++) {
      cosa = InicioPage.listaAhorcado[opt].palabra.toString();
      letrasPalabraBuena = cosa.split('');
    }
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: letrasPalabraBuena
            .map(
              (item) => Padding(
                padding: const EdgeInsets.all(2),
                child: Container(
                  height: 41,
                  width: 41,
                  //height: letras.length * 0.10,
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: _textoLetrasPalabra(item, listaEncontradas),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  _letras() {
    letrasPalabraBuena = letrasPalabraBuena.toSet().toList();
    if (!bandera) {
      for (var i = 0; i < 16; i++) {
        letrasAzar = abecedario[0].split('');
        final _random = new Random();
        int opt = _random.nextInt(16);

        if (letrasPalabraBuena.length < 16) {
          letrasPalabraBuena.add(letrasAzar[opt].toString());

          letrasPalabraBuena.shuffle();
        }
      }
      listaRecuperarLetras = letrasPalabraBuena;
      return Wrap(
        alignment: WrapAlignment.center,
        children: letrasPalabraBuena
            .map(
              (item) => Padding(
                padding: const EdgeInsets.all(2.5),
                child: InkWell(
                  onTap: () {
                    _validarLetra(item, letrasPalabraBuena);
                    setState(() {
                      bandera = true;
                    });
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        item,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      );
    } else {
      return Wrap(
        alignment: WrapAlignment.center,
        children: listaRecuperarLetras
            .map(
              (item) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: InkWell(
                  onTap: () {
                    _validarLetra(item, listaRecuperarLetras);
                    setState(() {
                      bandera = true;
                    });
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    //height: letras.length * 0.10,
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        item,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      );
    }
  }

  _validarLetra(String letraBuscar, List palabras) {
    for (var x = 0; x < palabras.length; x++) {
      if (letraBuscar == palabras[x]) {
        listaEncontradas.add(palabras[x]);
        x = palabras.length + 1;
      }
    }

    return listaEncontradas;
  }

  Widget _textoLetrasPalabra(String item, List listaLetrasBuscadas) {
    for (var i = 0; i < listaLetrasBuscadas.length; i++) {
      if (item == listaLetrasBuscadas[i]) {
        listaLetrasEncontradas.add(item);
        if (i + 1 == listaLetrasBuscadas.length) {
          finalizarJuego(listaLetrasEncontradas);
        }
        colorLetras = Colors.black;
        return Container(
          height: 45,
          width: 45,
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: HexColor('#2AA737'),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              item,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      }
    }
    print(listaLetrasEncontradas.toSet().toList());
  }

  finalizarJuego(List listaLetrasEncontradas) {
    if (listaLetrasEncontradas.toSet().toList().length ==
        letrasPalabraBuena.toSet().toList().length) {
      valiarDialog = true;
      _insertarRegistro();

      Future.delayed(Duration.zero, () async {
        build(context);
      });
      // await _dialog(contexto);
    }
  }

  void _insertarRegistro() async {
    String url = Constantes.urlServer + "registroActividadFinalizada";
    var response = await http.post(url, body: {
      'idUsuarioActividad': InicioPage.idUsuarioActividad,
      'estado': "Completado",
      'puntos': "1000",
    });
    int suma = int.parse(InicioPage.listaPuntos[0]["puntos"]) + 1000;
    InicioPage.listaPuntos[0]["puntos"] = suma.toString();
    List respuestaJson = jsonDecode(response.body);
    if (respuestaJson[0]["respuestaInsercion"] == "ok") {
      //_dialog();
    }
  }

  _dialog() {
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
                            //Navigator.of(context).pop();
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
}
