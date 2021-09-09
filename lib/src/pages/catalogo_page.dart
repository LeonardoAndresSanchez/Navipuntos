import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:navi_puntos/src/animations/animations.dart';
import 'package:navi_puntos/src/models/catalogo.dart';
import 'package:navi_puntos/src/pages/inicio_page.dart';
import 'package:navi_puntos/src/utils/constantes.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CatalogoPage extends StatefulWidget {
  CatalogoPage({Key key}) : super(key: key);

  @override
  _CatalogoPageState createState() => _CatalogoPageState();
}

class _CatalogoPageState extends State<CatalogoPage> {
  List<Catalogo> listaCatalogo = new List();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Container(
            padding: EdgeInsets.all(4.0),
            margin: EdgeInsets.fromLTRB(0, 0, 155.0, 0),
            child: Image.asset('assets/navi_logo_blanco.png'),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 25.0),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: size.height * 0.22,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        'assets/catalogo.png',
                        height: size.height * 0.13,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Catálogo de premios',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      topLeft: Radius.circular(5)),
                ),
                child: _crearLista3(),
              ))
            ],
          ),
        ),
      ),
    );
  }

  _showDialog(int index) {
    return showGeneralDialog(
      barrierColor: Colors.black38,
      context: context,
      barrierLabel: '',
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 350),
      transitionBuilder: (context, _animation, _secondaryAnimation, _child) {
        return Animations.fromTop(_animation, _secondaryAnimation, _child);
      },
      pageBuilder: (_animation, _secondaryAnimation, _child) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 0,
          // backgroundColor: Colors.transparent,
          child: dialogContent(context, index),
        );
      },
    );
  }

  dialogContent(BuildContext context, int index) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            height: size.height * 0.70,
            // width: size.width * 0.60,
            // margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: HexColor('#EDEDED'),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5.0,
                    offset: Offset(0.0, 5.0),
                  )
                ]),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6.0,
                            offset: Offset(0.0, 2.0),
                          )
                        ]),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: AutoSizeText(
                            listaCatalogo[index].nombrePremio,
                            // presetFontSizes: [15, 13, 11],
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: size.height * 0.025,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Image(
                          height: size.height * 0.24,
                          image: NetworkImage(Constantes.urlServer +
                              listaCatalogo[index].imagenPremio),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Row(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    Text(listaCatalogo[index].stock,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 30,
                                        )),
                                    Text('UNIDADES',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text('Valor en puntos',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                )),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: HexColor('#2aa737')),
                                  child: RaisedButton(
                                    color: Colors.transparent,
                                    elevation: 0,
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 5, right: 5),
                                          child: Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                        ),
                                        Text(
                                          listaCatalogo[index].totalPuntoPremio,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: size.height * 0.025,
                                              height: size.width * 0.002,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Align(
                    alignment: Alignment.center,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minWidth: 300.0,
                      height: 45.0,
                      onPressed: () {
                        redimirPremio(index);
                        Fluttertoast.showToast(
                            // /almacenamiento/0/assets/imagen1.jpg
                            msg: "CANJEO EXITOSO",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.grey,
                            textColor: Colors.black,
                            fontSize: 16.0);
                        Timer(Duration(milliseconds: 200), () {
                          Navigator.popAndPushNamed(context, 'inicio');
                        });
                      },
                      color: Colors.lightBlue,
                      child: Text(
                        'REDIMIR',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(1.5),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.blue)),
                        minWidth: 300.0,
                        height: 45.0,
                        onPressed: () => Navigator.pop(context),
                        child: Text('CANCELAR',
                            style: TextStyle(
                                color: HexColor('#107ec1'),
                                fontWeight: FontWeight.w700,
                                fontSize: 20)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _cargarCatalogo() async {
    String url = Constantes.urlServer + "consultaCatalogo";
    Response response = await Dio().get(url);
    // print(response);

    List listJsonDecode = jsonDecode(response.toString());
    if (this.mounted) {
      setState(() {
        listaCatalogo = listJsonDecode
            .map((mapCatalogo) => new Catalogo.fromJson(mapCatalogo))
            .toList();
      });
    }

    return listaCatalogo;
  }

  _crearLista3() {
    final size = MediaQuery.of(context).size;
    _cargarCatalogo();
    return GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: List.generate(listaCatalogo.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 4),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                // fit: StackFit.expand,
                children: [
                  Center(
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 15,
                        ),
                        child: Image(
                          image: NetworkImage(Constantes.urlServer +
                              listaCatalogo[index].imagenPremio),
                          height: size.height * 0.10,
                        )),
                  ),
                  SizedBox(
                    height: size.height * 0.001,
                  ),
                  Center(
                    child: AutoSizeText(
                      listaCatalogo[index].nombrePremio,
                      // presetFontSizes: [15, 13, 11],
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: size.height * 0.015,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: HexColor('#2aa737')),
                        child: RaisedButton(
                          color: HexColor('#2aa737'),
                          elevation: 0,
                          onPressed: () {
                            _showDialog(index);
                          },
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                Text(
                                  listaCatalogo[index].totalPuntoPremio,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: size.height * 0.015,
                                      color: Colors.white),
                                )
                              ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }

  redimirPremio(int index) async {
    print("STOCK ANTES: " + listaCatalogo[index].stock);
    int restaPuntos = int.parse(InicioPage.listaPuntos[0]["puntos"]) -
        int.parse(listaCatalogo[index].totalPuntoPremio);

    int stockActual = int.parse(listaCatalogo[index].stock);
    listaCatalogo[index].stock = (stockActual - 1).toString();

    print("STOCK DESPUES: " + listaCatalogo[index].stock);

    insertarUsuarioPremio(listaCatalogo[index].idCatalogoPremio);
    actualizarPuntosUsuario(restaPuntos);
    actualizarStock(listaCatalogo[index].stock);
  }

  void insertarUsuarioPremio(String idPremio) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'idUsuario';
    final value = prefs.getInt(key) ?? 0;

    String url = Constantes.urlServer + "insertarUsuarioPremio";
    var response = await http.post(url, body: {
      'idUsuario': value.toString(),
      'idPremio': idPremio.toString(),
    });

    List respuestaJson = jsonDecode(response.body);
    print(respuestaJson[0]["respuestaInsercion"]);
    if (respuestaJson[0]["respuestaInsercion"] == 'ok') {
      Navigator.of(context).pop();
    }
  }

  void actualizarPuntosUsuario(int restaPuntos) {
    String url = Constantes.urlServer + "registro";
    /*var response = await http.post(url, body: {
      'validacion': 'factura',
      'almacenFactura': widget.almacen,
      'image': base64Image,
      'fechaFactura': widget.fecha,
      'idUsuario': value.toString(),
      'cedulaUsuario': InicioPage.listaUser[0].cedulaUsuario
    });*/
  }

  void actualizarStock(String stockFinal) {
    String url = Constantes.urlServer + "registro";
    /*var response = await http.post(url, body: {
      'validacion': 'factura',
      'almacenFactura': widget.almacen,
      'image': base64Image,
      'fechaFactura': widget.fecha,
      'idUsuario': value.toString(),
      'cedulaUsuario': InicioPage.listaUser[0].cedulaUsuario
    });*/
  }
}
