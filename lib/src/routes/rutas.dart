import 'package:flutter/material.dart';
import 'package:navi_puntos/src/pages/actividades_page.dart';
import 'package:navi_puntos/src/pages/bienvenido_page.dart';
import 'package:navi_puntos/src/pages/catalogo_page.dart';
import 'package:navi_puntos/src/pages/factura_page.dart';
import 'package:navi_puntos/src/pages/foto_factura_page.dart';
import 'package:navi_puntos/src/pages/foto_qr_page.dart';
import 'package:navi_puntos/src/pages/home_page.dart';
import 'package:navi_puntos/src/pages/inicio_page.dart';
import 'package:navi_puntos/src/pages/intro_juegos_ahorcado.dart';
import 'package:navi_puntos/src/pages/intro_juegos_adivinanza.dart';
import 'package:navi_puntos/src/pages/intro_juegos_preguntas.dart';
import 'package:navi_puntos/src/pages/intro_juegos_puzzle.dart';
import 'package:navi_puntos/src/pages/intro_juegos_ruleta.dart';
import 'package:navi_puntos/src/pages/intro_slider.dart';
import 'package:navi_puntos/src/pages/login_page.dart';
import 'package:navi_puntos/src/pages/perfil_page.dart';
import 'package:navi_puntos/src/pages/preguntas2_page.dart';
import 'package:navi_puntos/src/pages/preguntas_page.dart';
import 'package:navi_puntos/src/pages/puzzle2_page.dart';
import 'package:navi_puntos/src/pages/puzzle_ahorcado_page.dart';
import 'package:navi_puntos/src/pages/puzzle_page.dart';
import 'package:navi_puntos/src/pages/registro_page.dart';
import 'package:navi_puntos/src/pages/splash_Page.dart';
import 'package:navi_puntos/src/pages/terminos_page.dart';

Map<String, WidgetBuilder> getApplicationRoute() {
  return <String, WidgetBuilder>{
    '/': (contex) => SplashScreen(),
    'registro': (context) => RegistroPage(),
    'perfil': (context) => PerfilPage(),
    'login': (context) => Loginpage(),
    'inicio': (context) => InicioPage(),
    'intro': (context) => IntroSlider(),
    'bienvenido': (context) => BienvenidoPage(),
    'catalogo': (context) => CatalogoPage(),
    //rutas Factura
    'factura': (context) => FacturaPage(),
    'fotoFactura': (context) => FotoFacturaPage(),
    'fotoQR': (context) => FotoQrPage(),
    //rutas a los instructivos de las Dinamicas
    'introJuegosAhorcado': (context) => IntroJuegosAhorcado(),
    'introJuegosAdivinanza': (context) => IntroJuegosAdivinanza(),
    'introJuegosPreguntas': (context) => IntroJuegosPreguntas(),
    'introJuegosPuzzle': (context) => IntroJuegosPuzzle(),
    'introJuegosRuleta': (context) => IntroJuegosRuleta(),
    //ruta de Las Dinamicas
    'actividades': (context) => ActividadesPage(),
    'preguntas': (context) => PreguntasPage(),
    'preguntas2': (context) => PreguntasPage2(),
    'puzzle': (context) => PuzzlePage(),
    'puzzle2': (context) => Puzzle2Page(),
    'Ahorcado': (context) => PuzzleAhorcadoPage(),
    //ruta Terminos y condiciones
    'terminos': (context) => TerminosPage(),
  };
}
