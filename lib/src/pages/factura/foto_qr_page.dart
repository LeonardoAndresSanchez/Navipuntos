import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brily_qr_reader/brily_qr_reader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:navi_puntos/src/pages/factura/foto_factura_page.dart';
import 'package:navi_puntos/src/utils/constantes.dart';

class FotoQrPage extends StatefulWidget {
  final String nombre;
  final String fecha;
  final String email;
  final String cel;
  final String almacen;

  const FotoQrPage(
      {Key key, this.nombre, this.fecha, this.email, this.cel, this.almacen})
      : super(key: key);
  @override
  _FotoQrPageState createState() => _FotoQrPageState();
}

class _FotoQrPageState extends State<FotoQrPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FotoFacturaPage fotoFactura = new FotoFacturaPage(
      almacen: "almacen",
    );

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro Factura'),
        automaticallyImplyLeading: false,
        centerTitle: true,
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
                  'Escanear QR',
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
            child: Image.asset(
              'assets/bg_qr.png',
              height: size.height * 0.60,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: size.height * 0.015,
          ),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            minWidth: 350.0,
            height: 50.0,
            onPressed: () async {
              String results = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScanView(),
                ),
              );

              if (results != null) {
                setState(() {
                  _scanQR(results);
                });
              }
            },
            color: HexColor('#107ec1'),
            child: Text(
              'ESCANEAR QR',
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
            onPressed: () => Navigator.of(context).pushNamed('fotoFactura'),
            child: Text('SIGUIENTE',
                style: TextStyle(
                    color: HexColor('#107ec1'),
                    fontWeight: FontWeight.w700,
                    fontSize: 20)),
          ),
        ],
      ),
    );
  }

  _scanQR(String codigo) async {
    String url = Constantes.urlServer + "validarQr?qrCode=" + codigo;
    Response response = await Dio().get(url);
    List respuestaJson = jsonDecode(response.toString());

    if (respuestaJson[0]["respuestaQr"] == 'siExiste') {
      print("PUEDE ESCANEAR LA FACTURA");
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => FotoFacturaPage()));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => FotoFacturaPage(
                    nombre: widget.nombre,
                    fecha: widget.fecha,
                    email: widget.email,
                    cel: widget.cel,
                    almacen: widget.almacen,
                  )));
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
  }
}
