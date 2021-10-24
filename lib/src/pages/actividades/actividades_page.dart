import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:navi_puntos/src/pages/home/inicio_page.dart';

class ActividadesPage extends StatelessWidget {
  const ActividadesPage({Key key}) : super(key: key);

  static bool girar = false;
  static String zero = '0';
  @override
  Widget build(BuildContext context) {
    // bool girar = false;
    ActividadesPage.girar = false;
    return Scaffold(body: Roulette());
  }

  Widget buildNavigationButton({String text, Function onPressedFn}) {
    return MaterialButton(
      color: Color.fromRGBO(255, 255, 255, 0.3),
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      onPressed: onPressedFn,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 18.0),
      ),
    );
  }
}

class Roulette extends StatelessWidget {
  final StreamController _dividerController = StreamController<int>();

  final _wheelNotifier = StreamController<double>();

  dispose() {
    _dividerController.close();
    _wheelNotifier.close();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      //appBar: AppBar(backgroundColor: Colors.white, elevation: 0.0),
      backgroundColor: Colors.grey[200],
      body: ListView(
        //mainAxisSize: MainAxisSize.max,
        children: [
          SafeArea(
            child: SizedBox(
              height: size.height * 0.05,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Image.asset(
              'assets/actividades_titulo.png',
              height: size.height * 0.25,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                          color: HexColor('#107ec1'),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          child: Text(
                            "Girar",
                            textScaleFactor: 1.8,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            ActividadesPage.girar = true;
                            _wheelNotifier.sink.add(_generateRandomVelocity());
                            _juegoAleatorio(context);
                          }),
                    ),
                    StreamBuilder(
                      stream: _dividerController.stream,
                      builder: (context, snapshot) => snapshot.hasData
                          ? RouletteScore(snapshot.data)
                          : Container(),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Center(
                  child: Stack(
                    fit: StackFit.loose,
                    children: [
                      SpinningWheel(
                        Image.asset('assets/wheel.png'),
                        width: 410,
                        height: 410,
                        initialSpinAngle: _generateRandomAngle(),
                        spinResistance: 0.6,
                        canInteractWhileSpinning: false,
                        dividers: 12,
                        onUpdate: _dividerController.add,
                        onEnd: _dividerController.add,
                        secondaryImage: Image.asset(
                            'assets/roulette-center-300.png',
                            color: HexColor('#3C3C3B')),
                        secondaryImageHeight: size.height * 0.30,
                        secondaryImageWidth: size.width * 0.30,
                        shouldStartOrStop: _wheelNotifier.stream,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _juegoAleatorio(context) {
    bool validacion = false;
    final _random = new Random();
    int opt = _random.nextInt(5);
    //int opt = 1;
    print('aleatorio***' + opt.toString());
    for (int i = 0; i < InicioPage.listJsonDecode.length; i++) {
      if (InicioPage.listJsonDecode[i]["idTipoActividad"] == opt.toString()) {
        validacion = true;
        print("SI LO ENCONTRÓ");
        i = InicioPage.listJsonDecode.length + 1;
      } else {
        print("NO LO ENCONTRO");
        validacion = false;
      }
    }
    if (!validacion) {
      _juegoAleatorio(context);
    } else {
      switch (opt) {
        case 1:
          final duration = new Duration(seconds: 4);
          new Timer(duration, () {
            Navigator.of(context).pushNamed('introJuegosAhorcado');

            ActividadesPage.girar = false;
          });
          break;
        case 4:
          final duration = new Duration(seconds: 4);
          new Timer(duration, () {
            Navigator.of(context).pushNamed('introJuegosPreguntas');

            ActividadesPage.girar = false;
          });
          break;

        default:
          ActividadesPage.girar = false;
          _juegoAleatorio(context);
          break;
      }
    }
  }

  double _generateRandomVelocity() => (Random().nextDouble() * 6000) + 4000;

  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
}

// bool girar = false;
String tmp = '1000';
String tmp2 = '500';

class RouletteScore extends StatelessWidget {
  final int selected;

  final Map<int, String> labels = {
    1: '500',
    2: '800',
    3: '1000',
    4: '200',
    5: '300',
    6: '450',
    7: '500',
    8: '800',
    9: '1000',
    10: '200',
    11: '300',
    12: '450',
  };

  RouletteScore(this.selected);

  @override
  Widget build(BuildContext context) {
    String valor = labels[selected];
    print(valor);
    /*if (!ActividadesPage.girar) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 2,
            bottom: 2,
            right: 20,
            left: 20,
          ),
          child: Text(
            ActividadesPage.zero,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: HexColor('#2aa737'),
              fontSize: 35,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );*/
    //} else {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 2,
          bottom: 2,
          right: 20,
          left: 20,
        ),
        child: Text(
          valor,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: HexColor('#2aa737'),
            fontSize: 35,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
    //}
  }
}
