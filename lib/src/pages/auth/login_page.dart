import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:navi_puntos/src/models/user.dart';
import 'package:navi_puntos/src/pages/home/inicio_page.dart';
import 'package:navi_puntos/src/splash/splash_Page.dart';
import 'package:navi_puntos/src/utils/constantes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Loginpage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  String _nombre = '';
  String _email = '';
  String _psw1 = '';
  String _cel = '';
  String _psw2 = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        children: <Widget>[
          SafeArea(
            child: Container(
              height: size.height * 0.001,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                'assets/navi_logo.png',
                height: size.height * 0.05,
              ),
            ],
          ),

          Center(
            child: Image.asset(
              'assets/navi_face.png',
              height: size.height * 0.27,
            ),
          ),
          Divider(
            color: Colors.transparent,
            height: size.height * 0.05,
          ),
          _crearEmail(),
          Divider(
            color: Colors.transparent,
          ),
          _crearPassword(),
          Divider(
            color: Colors.transparent,
            height: size.height * 0.03,
          ),
          // _crearPersona(),
          _crearRegistro(),
          _olvidoPassword(),
          _registro(),
        ],
      ),
    );
  }
/*   Widget _crearPersona() {
    return ListTile(
      title: Text('Nombre es : $_nombre'),
      subtitle: Text('Email: $_email + $_cel'),
      trailing: Text('contraseña es: $_psw1 = $_psw2'),
    );
  } */

  Widget _crearEmail() {
    return TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          //counter: Text('letras ${_nombre.length}'),
          hintText: 'Correo electrónico',
          labelText: 'Correo electrónico',
          hintStyle: TextStyle(fontWeight: FontWeight.w600),
          labelStyle: TextStyle(fontWeight: FontWeight.w600),
          suffixIcon: Icon(Icons.alternate_email),
          icon: Icon(
            Icons.email,
            color: Colors.green[300],
          ),
        ),
        onChanged: (valor) => setState(() {
              _email = valor;
            }));
  }

  Widget _crearPassword() {
    return TextField(
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          hintStyle: TextStyle(fontWeight: FontWeight.w600),
          labelStyle: TextStyle(fontWeight: FontWeight.w600),
          //counter: Text('letras ${_nombre.length}'),
          hintText: 'Contraseña',
          labelText: 'Contraseña',
          suffixIcon: Icon(Icons.lock_open),
          icon: Icon(
            Icons.lock,
            color: Colors.green[300],
          ),
        ),
        onChanged: (valor) => setState(() {
              _psw1 = valor;
            }));
  }

  Widget _crearRegistro() {
    return RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0)),
      child: Text(
        'INGRESAR',
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
      ),
      elevation: 5.0,
      color: HexColor('#107ec1'),
      padding: EdgeInsets.all(12),
      onPressed: () {
        _validarLogin();
      },
    );
  }

  Widget _registro() {
    return Center(
      child: Container(
        child: RaisedButton(
          child: Text(
            'REGISTRARSE',
            style: TextStyle(
                fontSize: 18,
                color: HexColor('#107ec1'),
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          color: Colors.transparent,
          elevation: 0,
          onPressed: () {
            Navigator.of(context).pushNamed('registro');
          },
        ),
        color: Colors.transparent,
      ),
    );
  }

  Widget _olvidoPassword() {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 10),
        child: RaisedButton(
          child: Text(
            'OLVIDÉ MI CONTRASEÑA',
            style: TextStyle(
              color: HexColor('#107ec1'),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            _supportWsp();
          },
          color: Colors.transparent,
          elevation: 0,
        ),
        color: Colors.transparent,
      ),
    );
  }

  Future<void> _validarLogin() async {
    String url = Constantes.urlServer +
        "consultaLogin?emailUsuario=$_email&passwordUsuario=$_psw1";
    Response response = await Dio().get(url);
    List respuestaJson = jsonDecode(response.toString());

    if (respuestaJson[0]["respuestaLogin"] == 'acceso') {
      _guardarDatos(respuestaJson[0]["idUsuario"]);
      final prefs = await SharedPreferences.getInstance();
      final key = 'idUsuario';
      final value = prefs.getInt(key) ?? 0;
      String url =
          Constantes.urlServer + "validarPuntos?idUsuario=" + value.toString();
      Response response = await Dio().get(url);
      InicioPage.listaPuntos = jsonDecode(response.toString());

      url = Constantes.urlServer +
          "consultaInfoUsuario?idUsuario=" +
          value.toString();
      response = await Dio().get(url);

      List listJsonDecode = jsonDecode(response.toString());
      InicioPage.listaUser =
          listJsonDecode.map((mapUser) => new User.fromJson(mapUser)).toList();
      // print(response);

      Navigator.of(context).popAndPushNamed('bienvenido');
    } else {
      Fluttertoast.showToast(
          msg: "La usuario/contraseña incorrectos",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }

  void _guardarDatos(String idUsuario) async {
    SplashScreen.prefs = await SharedPreferences.getInstance();
    final key = 'idUsuario';
    final value = int.parse(idUsuario);
    SplashScreen.prefs.setInt(key, value);

    final key1 = "testImage";
    final value1 = "";
    SplashScreen.prefs.setString(key1, value1);
    InicioPage.imagenPerfil = SplashScreen.prefs.getString("testImage");

    print('GUARDADO********* $value');
  }

  _supportWsp() async {
    int phone = 573136153296;
    String message = "Hola, Tengo un problema, olvide mi contraseña!";
    String url() {
      if (Platform.isAndroid) {
        // add the [https]
        return "https://wa.me/573136153296/?text=${Uri.parse(message)}"; // new line
      } else {
        // add the [https]
        return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }
}
