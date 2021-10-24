import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:navi_puntos/src/models/imagenpuzzle.dart';
import 'package:navi_puntos/src/models/palabra.dart';
import 'package:navi_puntos/src/models/pregunta.dart';
import 'package:navi_puntos/src/models/respuestaPregunta.dart';
import 'package:navi_puntos/src/models/trivia.dart';
import 'package:navi_puntos/src/models/user.dart';
import 'package:navi_puntos/src/pages/actividades/preguntas2_page.dart';
import 'package:navi_puntos/src/splash/splash_Page.dart';
import 'package:navi_puntos/src/utils/constantes.dart';
import 'package:navi_puntos/src/utils/styles.dart';
import 'package:navi_puntos/src/animations/animations.dart';
import 'package:navi_puntos/src/widgets/GridButton.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class InicioPage extends StatefulWidget {
  static List<PalabraActividad> listaAhorcado = new List();
  static List<ImagenPuzzle> listaPuzzle = new List();
  static List<Trivia> listaTrivia = new List();
  static List<PreguntaSeleccionMultiple> listaPreguntas = new List();
  static List<RespuestaPregunta> listaRespuestas = new List();
  static List listJsonDecode = new List();
  static List listJsonDecodeFinalizadas = new List();
  static List listaPuntos = new List();
  static String idUsuarioActividad;
  static List<User> listaUser;
  static String imagenPerfil = "";
  static SharedPreferences prefs;
  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  @override
  void initState() {
    _cargarListaActividades();
    _cargarListaActividadesFinalizadas();
    // _consultarPuntos();
    // _consultarDatosGardados();
    // textoPuntos();
  }

  var opciones = [
    'Actividad: 1',
    'Actividad: 2',
    'Actividad: 3',
    'Actividad: 4',
    'Actividad: 5'
  ];

  var _position = 15.0;
  File foto;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(this.context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/navi_logo_blanco.png',
          height: size.height * 0.05,
        ),
        actions: <Widget>[
          Container(
            // width: 35,
            margin: EdgeInsets.only(right: 2.0),
            child: IconButton(
              icon: Image.asset('assets/notificacion.png'),
              onPressed: () {
                _mostarAlertCustom();
              },
            ),
          ),
        ],
      ),
      drawer: Padding(
        padding: const EdgeInsets.only(top: 99),
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 50),
                    child: DrawerHeader(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Container(
                        height: size.height * 0.15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FadeInImage(
                                  placeholder:
                                      AssetImage('assets/jar-loading.gif'),
                                  image: AssetImage('assets/signal.png'),
                                  width: 35.0,
                                ),
                                Text('100%'),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                _mostrarFoto(),
                                Expanded(
                                  child: Text(
                                      InicioPage.listaUser[0].nombreUsuario),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FadeInImage(
                                  placeholder:
                                      AssetImage('assets/jar-loading.gif'),
                                  image: AssetImage('assets/star_point.png'),
                                  width: 35.0,
                                ),
                                textoPuntos(),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                      leading:
                          Image.asset('assets/icon_perfil1.png', width: 30.0),
                      title: Text('Actividades de Juego',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          )),
                      // onTap: () => Navigator.of(this.context).pushNamed('inicio'),
                      onTap: () {
                        Navigator.of(this.context).pop();
                        _cargarListaActividades();
                      }
                      // onTap: () => _juegoAleatorio(),
                      ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  ListTile(
                    leading:
                        Image.asset('assets/icon_perfil2.png', width: 30.0),
                    title: Text('Catálogo de Premios',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        )),
                    onTap: () =>
                        Navigator.of(this.context).pushNamed('catalogo'),
                  ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  ListTile(
                    leading:
                        Image.asset('assets/icon_perfil4.png', width: 30.0),
                    title: Text('Registra tu factura',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        )),
                    onTap: () =>
                        Navigator.of(this.context).pushNamed('factura'),
                  ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  ListTile(
                    leading:
                        Image.asset('assets/icon_perfil6.png', width: 30.0),
                    title: Text('Mensajes',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        )),
                    onTap: () => _mostarAlertCustom(),
                    // onTap: () => Navigator.of(this.context).pushNamed('preguntas2'),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading:
                            Image.asset('assets/terminos.png', width: 30.0),
                        title: Text('Términos y condiciones',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            )),
                        onTap: () =>
                            Navigator.of(this.context).pushNamed('terminos'),
                        // onTap: () => Navigator.of(this.context).pushNamed('inicioPage'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: size.height * 0.90,
            child: Image.asset(
              'assets/background_inicio2.png',
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            child: Image.asset('assets/header_actividades.png'),
            top: -1,
            left: -1,
            right: -1,
          ),
          Positioned(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 200,
                  height: size.height * 0.07,
                  padding: const EdgeInsets.all(3.0),
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      'ACTIVA',

                      style: kButtons,
                      textAlign: TextAlign.center,

                      // textScaleFactor: 1.5,
                    ),
                    elevation: 2.0,
                    color: Colors.grey[350],
                    onPressed: () {
                      _onButtomPressed();
                    },
                  ),
                ),
                Container(
                  width: 200,
                  height: size.height * 0.07,
                  padding: const EdgeInsets.all(3.0),
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      'COMPLETADA',
                      style: kButtons,
                      textAlign: TextAlign.center,
                      //textScaleFactor: 1.8,
                    ),
                    elevation: 2.0,
                    //color: Colors.grey[400],
                    color: Colors.grey[350],
                    onPressed: () {
                      _onButtomPressed2();
                    },
                  ),
                ),
              ],
            ),
            bottom: _position,
          )
        ],
      ),
    );
  }

  void _onButtomPressed() {
    final size = MediaQuery.of(this.context).size;

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black26,
        context: this.context,
        builder: (context) {
          return Container(
            width: size.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25), topLeft: Radius.circular(25)),
            ),
            child: _lista(),
          );
        });
  }

  Widget _lista() {
    return ListView(
        padding: const EdgeInsets.all(8),
        children: [Column(children: _crearLista())]);
  }

  List<Widget> _crearLista() {
    List<Widget> lista = new List();
    for (var i = 0; i < InicioPage.listJsonDecode.length; i++) {
      if (InicioPage.listJsonDecode[i]["idTipoActividad"] == "1") {
        lista.add(
          ListTile(
            //title: Text('Ahorcado'),
            title: Text('Ruleta'),
            subtitle: Text('Actividad: sin completar'),
            leading: Icon(
              Icons.content_paste,
              color: HexColor('#2aa737'),
            ),
            trailing: Icon(
              Icons.star,
              color: Colors.grey[600],
            ),
            onTap: () {
              InicioPage.idUsuarioActividad =
                  InicioPage.listJsonDecode[i]["idUsuarioActividad"];

              //Navigator.of(this.context).pushNamed('introJuegosAhorcado');
              Navigator.of(this.context).pushNamed('introJuegosRuleta');

              // Navigator.of(this.context).pushNamed('actividades');

              // _juego(item);
            },
          ),
        );
      } else if (InicioPage.listJsonDecode[i]["idTipoActividad"] == "2") {
        lista.add(
          ListTile(
            title: Text('Puzzle'),
            subtitle: Text('Actividad: sin completar'),
            leading: Icon(
              Icons.content_paste,
              color: HexColor('#2aa737'),
            ),
            trailing: Icon(
              Icons.star,
              color: Colors.grey[600],
            ),
            onTap: () {
              InicioPage.idUsuarioActividad =
                  InicioPage.listJsonDecode[i]["idUsuarioActividad"];
              Navigator.of(this.context).pushNamed('introJuegosPuzzle');
              // _juego(item);
            },
          ),
        );
      } else if (InicioPage.listJsonDecode[i]["idTipoActividad"] == "3") {
        lista.add(
          ListTile(
            title: Text('Adivinanza'),
            subtitle: Text('Actividad: sin completar'),
            leading: Icon(
              Icons.content_paste,
              color: HexColor('#2aa737'),
            ),
            trailing: Icon(
              Icons.star,
              color: Colors.grey[600],
            ),
            onTap: () {
              InicioPage.idUsuarioActividad =
                  InicioPage.listJsonDecode[i]["idUsuarioActividad"];
              Navigator.of(this.context).pushNamed('introJuegosAdivinanza');
              // _juego(item);
            },
          ),
        );
      } else if (InicioPage.listJsonDecode[i]["idTipoActividad"] == "4") {
        lista.add(
          ListTile(
            // title: Text('Preguntas'),
            title: Text('Ruleta'),
            subtitle: Text('Actividad: sin completar'),
            leading: Icon(
              Icons.content_paste,
              color: HexColor('#2aa737'),
            ),
            trailing: Icon(
              Icons.star,
              color: Colors.grey[600],
            ),
            onTap: () {
              InicioPage.idUsuarioActividad =
                  InicioPage.listJsonDecode[i]["idUsuarioActividad"];
              PreguntasPageState2.listaRespuestas.clear();
              // Navigator.of(this.context).pushNamed('preguntas2');
              Navigator.of(this.context).pushNamed('introJuegosRuleta');

              // Navigator.of(this.context).pushNamed('actividades');

              // _juego(item);
            },
          ),
        );
      }

      lista.add(Divider(
        height: 2,
        color: Colors.grey,
      ));
    }
    return lista;
  }

  void _onButtomPressed2() {
    final size = MediaQuery.of(this.context).size;

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black26,
        context: this.context,
        builder: (context) {
          return Container(
            width: size.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
              ),
            ),
            child: _lista2(),
          );
        });
  }

  Widget _lista2() {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: _crearLista2(),
    );
  }

  List<Widget> _crearLista2() {
    List<Widget> lista = new List();
    for (var i = 0; i < InicioPage.listJsonDecodeFinalizadas.length; i++) {
      if (InicioPage.listJsonDecodeFinalizadas[i]["idTipoActividad"] == "1") {
        lista.add(
          ListTile(
            // title: Text('Ahorcado'),
            title: Text('Ruleta'),

            subtitle: Text('Completada'),
            leading: Icon(
              Icons.content_paste,
              color: HexColor('#2aa737'),
            ),
            trailing: Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onTap: () {},
          ),
        );
      } else if (InicioPage.listJsonDecodeFinalizadas[i]["idTipoActividad"] ==
          "2") {
        lista.add(
          ListTile(
            title: Text('Puzzle'),
            subtitle: Text('Completada'),
            leading: Icon(
              Icons.content_paste,
              color: HexColor('#2aa737'),
            ),
            trailing: Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onTap: () {},
          ),
        );
      } else if (InicioPage.listJsonDecodeFinalizadas[i]["idTipoActividad"] ==
          "3") {
        lista.add(
          ListTile(
            title: Text('Adivinanza'),
            subtitle: Text('Completada'),
            leading: Icon(
              Icons.content_paste,
              color: HexColor('#2aa737'),
            ),
            trailing: Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onTap: () {},
          ),
        );
      } else if (InicioPage.listJsonDecodeFinalizadas[i]["idTipoActividad"] ==
          "4") {
        lista.add(
          ListTile(
            // title: Text('Preguntas'),
            title: Text('Ruleta'),

            subtitle: Text('Completada'),
            leading: Icon(
              Icons.content_paste,
              color: HexColor('#2aa737'),
            ),
            trailing: Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onTap: () {},
          ),
        );
      }

      lista.add(Divider(
        height: 2,
        color: Colors.grey,
      ));
    }
    return lista;
  }

  _mostarAlertCustom() {
    return showGeneralDialog(
      barrierColor: Colors.black38,
      context: this.context,
      barrierLabel: '',
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 350),
      transitionBuilder: (context, _animation, _secondaryAnimation, _child) {
        return Animations.fromTop(_animation, _secondaryAnimation, _child);
      },
      pageBuilder: (_animation, _secondaryAnimation, _child) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: dialogContent(this.context));
      },
    );
  }

  dialogContent(BuildContext context) {
    final size = MediaQuery.of(this.context).size;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 80,
            bottom: 16,
            right: 16,
            left: 16,
          ),
          margin: EdgeInsets.only(
            top: 35,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                )
              ]),
          child: ListView(children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'MENSAJES',
                  style: kTextStyle1,
                ),
                SizedBox(
                  height: size.height * 0.010,
                ),
                Text(
                  'Actividades pendientes: ' +
                      InicioPage.listJsonDecode.length.toString(),
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: size.height * 0.002,
                ),
                Column(
                  children: _crearLista(),
                ),
              ],
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FlatButton(
              child: Text(
                'Ok',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: () => Navigator.of(this.context).pop(),
              color: HexColor('#107ec1'),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 16,
          right: 16,
          child: CircleAvatar(
            backgroundColor: HexColor('#107ec1'),
            child: Lottie.asset('assets/message-loading.json'),
            radius: 50,
          ),
        ),
      ],
    );
  }

  void _cargarListaActividadesFinalizadas() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'idUsuario';
    final value = prefs.getInt(key) ?? 0;
    String url = Constantes.urlServer +
        "consultaActividadesDiariasFinalizadas?idUsuario=" +
        value.toString();
    Response response = await Dio().get(url);
    // print(response);

    InicioPage.listJsonDecodeFinalizadas = jsonDecode(response.toString());
  }

  Widget textoPuntos() {
    // _consultarPuntos();
    return Text(InicioPage.listaPuntos[0]["puntos"]);
  }

  /* _consultarPuntos() async {
        String url = Constantes.urlServer +
            "validarPuntos?idUsuario=" +
            InicioPage.listaUser[0].idUsuario;
        Response response = await Dio().get(url);
        // print(response);
        InicioPage.listaPuntos = jsonDecode(response.toString());
      }
    }*/

  _cargarListaActividades() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'idUsuario';
    final value = prefs.getInt(key) ?? 0;
    String url = Constantes.urlServer +
        "consultaActividadesDiarias?idUsuario=" +
        value.toString();
    Response response = await Dio().get(url);
    print(response);

    InicioPage.listJsonDecode = jsonDecode(response.toString());
    for (var i = 0; i < InicioPage.listJsonDecode.length; i++) {
      String url = Constantes.urlServer +
          "consultaActividades?idActividad=" +
          InicioPage.listJsonDecode[i]["idActividad"] +
          "&idTipoActividad=" +
          InicioPage.listJsonDecode[i]["idTipoActividad"];
      Response response = await Dio().get(url);
      List listJsonDecodeActividad = jsonDecode(response.toString());
      if (InicioPage.listJsonDecode[i]["idTipoActividad"] == "1") {
        InicioPage.listaAhorcado = listJsonDecodeActividad
            .map((mapAhorcado) => new PalabraActividad.fromJson(mapAhorcado))
            .toList();
        print("llego aqui**** " + listJsonDecodeActividad.toString());
      } else if (InicioPage.listJsonDecode[i]["idTipoActividad"] == "2") {
        InicioPage.listaPuzzle = listJsonDecodeActividad
            .map((mapPuzzle) => new ImagenPuzzle.fromJson(mapPuzzle))
            .toList();
      } else if (InicioPage.listJsonDecode[i]["idTipoActividad"] == "3") {
        InicioPage.listaTrivia = listJsonDecodeActividad
            .map((mapTrivia) => new Trivia.fromJson(mapTrivia))
            .toList();
      } else if (InicioPage.listJsonDecode[i]["idTipoActividad"] == "4") {
        InicioPage.listaPreguntas = listJsonDecodeActividad
            .map((mapPreguntas) =>
                new PreguntaSeleccionMultiple.fromJson(mapPreguntas))
            .toList();

        String url = Constantes.urlServer + "consultaRespuestas";
        Response response = await Dio().get(url);
        List listJsonDecodeRespuestaPregunta = jsonDecode(response.toString());
        InicioPage.listaRespuestas = listJsonDecodeRespuestaPregunta
            .map((mapRespuestas) =>
                new RespuestaPregunta.fromJson(mapRespuestas))
            .toList();
      }
    }

    print("ASDASD");
  }

  _mostrarFoto() {
    final key = 'testImage';
    return GestureDetector(
        child: Stack(
          children: [
            CircleAvatar(
              backgroundColor: HexColor('#107ec1'),
              radius: 55,
              backgroundImage: InicioPage.imagenPerfil == ""
                  ? AssetImage('assets/user.png')
                  : FileImage(
                      File(InicioPage.imagenPerfil),
                    ),
              // Image.asset(foto?.path ?? 'assets/user.png',
              //     width: 100, fit: BoxFit.cover),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                radius: 18,
                child: Icon(
                  Icons.add_a_photo,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          print('tap');
          _seleccionarFoto();
        });
  }

  _seleccionarFoto() async {
    foto = await ImagePicker.pickImage(source: ImageSource.gallery);

    Directory directorioFoto = await getApplicationDocumentsDirectory();
    final String path = directorioFoto.path;

    String fileName = basename(foto.path);
    final File localImage = await foto.copy('$path/$fileName');

    SplashScreen.prefs = await SharedPreferences.getInstance();
    SplashScreen.prefs.setString('testImage', localImage.path);
    InicioPage.imagenPerfil = SplashScreen.prefs.getString("testImage");

    if (foto != null) {
      //limpieza
    }
    setState(() {});
  }

  // Future _consultarDatosGardados() async {
  //   SplashScreen.prefs =
  //       await SharedPreferences.getInstance().then((value) => null);
  //   InicioPage.prefs =
  //       await SharedPreferences.getInstance().then((value) => null);
  // }
}
