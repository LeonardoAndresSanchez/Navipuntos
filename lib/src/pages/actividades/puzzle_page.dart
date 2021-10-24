import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navi_puntos/src/pages/actividades/board.dart';

/* main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(PuzzlePage());
} */

class PuzzlePage extends StatefulWidget {
  @override
  _PuzzlePageState createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pushNamed('inicio'),
        ),
        centerTitle: true,
        title: Image.asset(
          'assets/navi_logo_blanco.png',
          height: size.height * 0.05,
        ),
      ),
      body: ListView(
        children: [
          Board(),
        ],
      ),
    );
  }
}
