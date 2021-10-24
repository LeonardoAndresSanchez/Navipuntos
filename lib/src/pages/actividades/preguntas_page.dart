import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:navi_puntos/src/utils/styles.dart';

class PreguntasPage extends StatefulWidget {
  @override
  _PreguntasPageState createState() => _PreguntasPageState();
}

class _PreguntasPageState extends State<PreguntasPage> {
  Color text = Colors.black;
  Color btn = Colors.white;
  Color text2 = Colors.black;
  Color btn2 = Colors.white;
  Color text3 = Colors.black;
  Color btn3 = Colors.white;
  Color textcorret = Colors.black;
  Color btncorret = Colors.white;

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
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Image.asset(
                'assets/producto.png',
                height: 310,
              ),
            ),
            Text(
              '¿Navius® es esfectivo contra cuál de estas malezas?',
              textAlign: TextAlign.center,
              style: TextStyle(
                  wordSpacing: 0.1,
                  letterSpacing: 0.2,
                  textBaseline: TextBaseline.alphabetic,
                  color: Colors.black,
                  height: 1.2,
                  fontSize: 25,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                width: double.infinity,
                height: 370,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(1)),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 400,
                        height: 48,
                        child: RaisedButton(
                          elevation: 5,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                          color: btn2,
                          onPressed: () {
                            setState(() {
                              btn2 = Colors.red;
                              text2 = Colors.white;
                              _dialogerror();
                            });
                          },
                          child: Text(
                            'Bicho y Dormidera',
                            textScaleFactor: 2.2,
                            style: TextStyle(
                              color: text2,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 400,
                        height: 48,
                        child: RaisedButton(
                          elevation: 5,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                          color: btn3,
                          onPressed: () {
                            setState(() {
                              btn3 = Colors.red;
                              text3 = Colors.white;
                              _dialogerror();
                            });
                          },
                          child: Text(
                            'Algodoncillo',
                            textScaleFactor: 2.2,
                            style: TextStyle(
                              color: text3,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 400,
                        height: 48,
                        child: RaisedButton(
                          elevation: 5,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                          color: btn,
                          onPressed: () {
                            setState(() {
                              btn = Colors.red;
                              text = Colors.white;
                              _dialogerror();
                            });
                          },
                          child: Text(
                            'Mortiño',
                            textScaleFactor: 2.2,
                            style: TextStyle(
                              color: text,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 400,
                        height: 48,
                        child: RaisedButton(
                          elevation: 5,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                          color: btncorret,
                          onPressed: () {
                            setState(() {
                              btncorret = Colors.green;
                              textcorret = Colors.white;
                              _dialog();
                            });
                          },
                          child: Text(
                            'Todas las anteriores',
                            textScaleFactor: 2.2,
                            style: TextStyle(
                              color: textcorret,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
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
