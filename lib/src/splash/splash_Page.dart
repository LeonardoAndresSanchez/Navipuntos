import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:navi_puntos/src/models/user.dart';
import 'package:navi_puntos/src/pages/home/inicio_page.dart';
import 'package:navi_puntos/src/utils/constantes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreen extends StatefulWidget {
  static SharedPreferences prefs;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String rutaImgCambio;
  bool visible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rutaImgCambio = 'assets/corteva.png';
    visible = true;
    _validarSesion();
    Timer(Duration(seconds: 3), () {
      setState(() {
        visible = !visible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: size.height * 0.07,
                      ),
                      Center(
                        child: Image.asset(
                          'assets/corteva.png',
                          height: size.height * 0.063,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.30,
                      ),
                      Center(
                        child: Stack(
                          children: [
                            Center(
                              child: AnimatedOpacity(
                                // If the widget is visible, animate to 0.0 (invisible).
                                // If the widget is hidden, animate to 1.0 (fully visible).
                                opacity: visible ? 1.0 : 0.0,
                                duration: Duration(milliseconds: 1000),
                                // The green box must be a child of the AnimatedOpacity widget.
                                child: Image.asset('assets/neviHervicida.png',
                                    height: size.height * 0.12),
                              ),
                            ),
                            Center(
                              child: AnimatedOpacity(
                                // If the widget is visible, animate to 0.0 (invisible).
                                // If the widget is hidden, animate to 1.0 (fully visible).
                                opacity: !visible ? 1.0 : 0.0,
                                duration: Duration(milliseconds: 1700),
                                // The green box must be a child of the AnimatedOpacity widget.
                                child: Image.asset(
                                  'assets/naviPuntos.png',
                                  height: size.height * 0.15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.10,
                      ),
                      Center(child: CircularProgressIndicator()),
                      // Lottie.asset(
                      //   'assets/loading-spinner.json',
                      //   height: size.height * 0.05,
                      // ),
                      SizedBox(
                        height: size.height * 0.07,
                      ),
                      Center(
                        child: Image.asset('assets/superGanaderia.png',
                            height: size.height * 0.13),
                      ),
                      // Image.asset(
                      //   'assets/naviPuntos.png',
                      //   height: size.height * 0.15,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _validarSesion() async {
    SplashScreen.prefs = await SharedPreferences.getInstance();
    final key = 'idUsuario';
    final value = SplashScreen.prefs.getInt(key) ?? 0;

    print('LEIDO: $value');
    if (value != 0) {
      InicioPage.imagenPerfil = SplashScreen.prefs.getString("testImage");
      String url =
          Constantes.urlServer + "validarSesion?idUsuario=" + value.toString();
      Response response = await Dio().get(url);

      List listaSesionValidada = jsonDecode(response.toString());

      if (listaSesionValidada[0]["respuestaLogin"] == "sesionIniciada") {
        SplashScreen.prefs = await SharedPreferences.getInstance();
        final key = 'idUsuario';
        final value = SplashScreen.prefs.getInt(key) ?? 0;
        String url = Constantes.urlServer +
            "validarPuntos?idUsuario=" +
            value.toString();
        Response response = await Dio().get(url);
        // print(response);
        InicioPage.listaPuntos = jsonDecode(response.toString());

        url = Constantes.urlServer +
            "consultaInfoUsuario?idUsuario=" +
            value.toString();
        response = await Dio().get(url);

        List listJsonDecode = jsonDecode(response.toString());
        InicioPage.listaUser = listJsonDecode
            .map((mapUser) => new User.fromJson(mapUser))
            .toList();

        Timer(Duration(seconds: 5),
            () => Navigator.of(context).pushNamed('inicio'));
      } else {
        Timer(Duration(seconds: 5),
            () => Navigator.of(context).popAndPushNamed('login'));
      }
    } else {
      Timer(Duration(seconds: 5),
          () => Navigator.of(context).popAndPushNamed('login'));
    }
  }
}
