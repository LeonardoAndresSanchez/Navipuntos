import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class BienvenidoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HexColor('#107ec1'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Center(
          child: ListView(
            children: [
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 30),
                child: Image.asset(
                  'assets/texto_bienvenido.png',
                  height: size.height * 0.10,
                ),
              ),
              Divider(
                color: Colors.transparent,
                height: size.height * 0.10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Image.asset('assets/intro_face1.png',
                    height: size.height * 0.4),
              ),
              Divider(
                color: Colors.transparent,
                height: size.height * 0.10,
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 50,
                  right: 50,
                ),
                height: size.height * 0.06,
                child: RaisedButton(
                  color: Colors.white,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(12.0)),
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed('inicio');
                  },
                  child: Text(
                    'CONTINUAR',
                    textScaleFactor: 1.3,
                    style: TextStyle(
                      color: HexColor('#107ec1'),
                      fontSize: 18.0,
                      height: 1.5,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
