import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navi_puntos/src/pages/home/inicio_page.dart';
import 'package:navi_puntos/src/utils/constantes.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FotoFacturaPage extends StatefulWidget {
  final String nombre;
  final String fecha;
  final String email;
  final String cel;
  final String almacen;
  FotoFacturaPage(
      {Key key, this.nombre, this.fecha, this.email, this.cel, this.almacen})
      : super(key: key);

  @override
  _FotoFacturaPageState createState() => _FotoFacturaPageState();
}

class _FotoFacturaPageState extends State<FotoFacturaPage> {
  File foto;
  String fotoBase64 = "";
  var a;
  get resultado => null;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Registro Factura'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Foto Factura',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Image.asset(
                    'assets/navi_logo.png',
                    height: size.height * 0.05,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
            child: _validarImagen(context),
          ),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            minWidth: 350.0,
            height: 50.0,
            onPressed: () {
              _tomarFoto();
            },
            color: HexColor('#107ec1'),
            child: Text(
              'TOMAR FOTO',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            ),
          ),
          SizedBox(
            height: size.height * 0.015,
          ),
          MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: HexColor('#107ec1'), width: 1.5)),
            minWidth: 350.0,
            height: 50.0,
            onPressed: () {
              _enviarRegistro(context);
              probarFoto();
            },
            child: Text('FINALIZAR',
                style: TextStyle(
                    color: HexColor('#107ec1'),
                    fontWeight: FontWeight.w700,
                    fontSize: 20)),
          ),
        ],
      ),
    );
  }

  Future _tomarFoto() async {
    await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    ).then((image) {
      setState(() {
        foto = image;
      });
    });

    if (foto != null) {
      //limpieza
    }
  }

  probarFoto() async {
    List<int> imageBytes = foto.readAsBytesSync();

    String base64Image = base64Encode(imageBytes);
    fotoBase64 = base64Image;
    a = {"imagen": base64Image};
    return base64Image;
  }

  Widget _validarImagen(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (foto != null) {
      return Image.file(foto);
    } else {
      return Image.asset(
        "assets/bg_cam.png",
        height: size.height * 0.60,
        width: double.infinity,
      );
    }
  }

  void _enviarRegistro(context) async {
    File fotoTemp = foto;
    List<int> imageBytes = foto.readAsBytesSync();
    final prefs = await SharedPreferences.getInstance();
    final key = 'idUsuario';
    final value = prefs.getInt(key) ?? 0;

    String base64Image = base64Encode(imageBytes);
    // String url = Constantes.urlServer +
    //     "registro?email=${widget.zemail}&fecha_factura=${widget.fecha}&almacen=${widget.almacen}&fotoFactura=${fotoBase64}&id_usuario=${widget.nombre}&celular=${widget.cel}&validacion=$bandera";
    String url = Constantes.urlServer + "registro";
    var response = await http.post(url, body: {
      'validacion': 'factura',
      'almacenFactura': widget.almacen,
      'image': base64Image,
      'fechaFactura': widget.fecha,
      'idUsuario': value.toString(),
      'cedulaUsuario': InicioPage.listaUser[0].cedulaUsuario
    });

    List respuestaJson = jsonDecode(response.body);
    print(respuestaJson[0]["respuestaInsercion"]);
    if (respuestaJson[0]["respuestaInsercion"] == 'ok') {
      Fluttertoast.showToast(
          // /almacenamiento/0/assets/imagen1.jpg
          msg: "REGISTRO DE FACTURA EXITOSO",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 16.0);
      Timer(Duration(milliseconds: 200), () {
        Navigator.popAndPushNamed(context, 'inicio');
      });
    } else {
      Fluttertoast.showToast(
          // /almacenamiento/0/assets/imagen1.jpg
          msg: "NO PUEDE REGISTAR LA FACTURA",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 16.0);
    }
    // List listJsonDecode = jsonDecode(response.toString());
    // listaUser =
    //     listJsonDecode.map((mapUser) => new User.fromJson(mapUser)).toList();
  }
}
