import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:navi_puntos/src/models/user.dart';
import 'package:navi_puntos/src/pages/inicio_page.dart';
import 'package:navi_puntos/src/utils/constantes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistroPage extends StatefulWidget {
  RegistroPage({Key key}) : super(key: key);

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  String _nombre = '';
  String _email = '';
  String _psw1 = '';
  String _psw2 = '';
  String _cel = '';
  String _identificacion = '';
  bool _bloquearCheck = false;
  static List<User> listaUser;
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();
  // @override
  // void dispose() {
  //   // Clean up the focus node when the Form is disposed.
  //   myFocusNode.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
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

            _crearInput(),
            Divider(
              color: Colors.transparent,
            ),
            _crearIdentificacion(),
            Divider(
              color: Colors.transparent,
            ),
            _crearEmail(),
            Divider(
              color: Colors.transparent,
            ),
            _crearTelefono(),
            Divider(
              color: Colors.transparent,
            ),
            _crearPassword(),
            Divider(
              color: Colors.transparent,
            ),
            _crearPassword2(),
            // Divider(
            //   color: Colors.transparent,
            // ),
            _crearCheck(),
            Divider(
              height: size.height * 0.005,
              color: Colors.transparent,
            ),
            _crearRegistro(),
          ],
        ),
      ),
    );
  }

  Widget _crearInput() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Nombre y Apellido',
        labelText: 'Nombre y Apellido',
        hintStyle: TextStyle(fontWeight: FontWeight.w600),
        labelStyle: TextStyle(fontWeight: FontWeight.w600),
        icon: Icon(
          Icons.account_circle,
          color: Colors.green[300],
        ),
      ),
      onChanged: (valor) {
        setState(() {
          _nombre = valor;
        });
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
      },
      focusNode: _focusNode1,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _focusNode1, _focusNode2);
      },
    );
  }

  Widget _crearIdentificacion() {
    return TextFormField(
      focusNode: _focusNode2,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _focusNode2, _focusNode3);
      },
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Número de identificación',
        labelText: 'Número de identificación',
        hintStyle: TextStyle(fontWeight: FontWeight.w600),
        labelStyle: TextStyle(fontWeight: FontWeight.w600),
        icon: Icon(
          Icons.credit_card,
          color: Colors.green[300],
        ),
      ),
      onChanged: (valor) {
        setState(() {
          _identificacion = valor;
        });
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
      },
    );
  }

  Widget _crearEmail() {
    return TextFormField(
      focusNode: _focusNode3,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _focusNode3, _focusNode4);
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
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
      onChanged: (valor) => setState(
        () {
          _email = valor;
        },
      ),
      validator: validateEmail,
    );
  }

  Widget _crearTelefono() {
    return TextFormField(
      focusNode: _focusNode4,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _focusNode4, _focusNode5);
      },
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        //counter: Text('letras ${_nombre.length}'),
        hintText: 'Celular',
        labelText: 'Celular',
        hintStyle: TextStyle(fontWeight: FontWeight.w600),
        labelStyle: TextStyle(fontWeight: FontWeight.w600),
        //suffixIcon: Icon(Icons.local_phone),
        icon: Icon(
          Icons.local_phone,
          color: Colors.green[300],
        ),
      ),
      onChanged: (valor) => setState(() {
        _cel = valor;
      }),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
      },
    );
  }

  Widget _crearPassword() {
    return TextFormField(
      focusNode: _focusNode5,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _focusNode5, _focusNode6);
      },
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        //counter: Text('letras ${_nombre.length}'),
        hintText: 'Contraseña',
        labelText: 'Contraseña',
        hintStyle: TextStyle(fontWeight: FontWeight.w600),
        labelStyle: TextStyle(fontWeight: FontWeight.w600),
        suffixIcon: Icon(Icons.lock_open),
        icon: Icon(
          Icons.lock,
          color: Colors.green[300],
        ),
      ),
      onChanged: (valor) => setState(() {
        _psw1 = valor;
      }),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        if (value.length < 6) {
          return 'Debe contener mas de 6 Caracteres';
        }
      },
    );
  }

  Widget _crearPassword2() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        //counter: Text('letras ${_nombre.length}'),
        hintText: 'Contraseña',
        labelText: 'Confirmar Contraseña',
        hintStyle: TextStyle(fontWeight: FontWeight.w600),
        labelStyle: TextStyle(fontWeight: FontWeight.w600),
        suffixIcon: Icon(Icons.lock_open),
        icon: Icon(
          Icons.lock,
          color: Colors.green[300],
        ),
      ),
      onChanged: (valor) => setState(() {
        _psw2 = valor;
      }),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        if (value != _psw1) {
          return 'las contraseñas no coinciden';
        }
      },
    );
  }

  Widget _crearCheck() {
    return CheckboxListTile(
      title: Text('He leído y acepto los términos y condiciones de uso'),
      value: _bloquearCheck,
      onChanged: (valor) {
        setState(() {
          _bloquearCheck = valor;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.green,
    );
  }

  Widget _crearRegistro() {
    return RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0)),
      child: Text(
        'REGISTRAR',
        // textScaleFactor: 1.5,
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
      ),
      elevation: 5.0,
      color: HexColor('#107ec1'),
      textColor: Colors.grey[300],
      padding: EdgeInsets.all(12),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          // Scaffold.of(context)
          //     .showSnackBar(SnackBar(content: Text('Processing Data')));
          _enviarRegistro();
        }
      },
    );
  }

  void _enviarRegistro() async {
    String bandera = 'usuario';

    String url = Constantes.urlServer + "registro";
    var response = await http.post(url, body: {
      'validacion': bandera,
      'cedulaUsuario': _identificacion,
      'nombreUsuario': _nombre,
      'telefonoUsuario': _cel,
      'emailUsuario': _email,
      'passwordUsuario': _psw1,
    });
    List respuestaJson = jsonDecode(response.body);
    print(respuestaJson[0]["respuestaInsercion"]);
    if (respuestaJson[0]["respuestaInsercion"] == 'yaExiste') {
      print("LA CÉDULA QUE INGRESÓ YA SE ENCUENTRA REGISTRADA");
    } else if (respuestaJson[0]["respuestaInsercion"] == 'ok') {
      String url = Constantes.urlServer +
          "consultaLogin?emailUsuario=$_email&passwordUsuario=$_psw1";
      Response response = await Dio().get(url);

      List listJsonDecode = jsonDecode(response.toString());
      InicioPage.listaUser =
          listJsonDecode.map((mapUser) => new User.fromJson(mapUser)).toList();

      List respuestaJson = jsonDecode(response.toString());
      final prefs = await SharedPreferences.getInstance();
      final key = 'idUsuario';
      final value = int.parse(respuestaJson[0]["idUsuario"]);
      prefs.setInt(key, value);
      // print('GUARDADO********* $value');
      url = Constantes.urlServer +
          "consultaInfoUsuario?idUsuario=" +
          value.toString();
      response = await Dio().get(url);

      listJsonDecode = jsonDecode(response.toString());
      InicioPage.listaUser =
          listJsonDecode.map((mapUser) => new User.fromJson(mapUser)).toList();

      url =
          Constantes.urlServer + "validarPuntos?idUsuario=" + value.toString();
      response = await Dio().get(url);

      InicioPage.listaPuntos = jsonDecode(response.toString());

      final duration = new Duration(seconds: 2);
      new Timer(duration, () {
        Navigator.of(context).popAndPushNamed('intro');
      });
    } else {}
    // List listJsonDecode = jsonDecode(response.toString());
    // listaUser =
    //     listJsonDecode.map((mapUser) => new User.fromJson(mapUser)).toList();
  }

  // validacion de email
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Ingrese un Correo electrónico Valido ';
    else
      return null;
  }

  // nextfocusfield
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
