import 'package:flutter/material.dart';
import 'package:navi_puntos/src/pages/actividades/actividades_page.dart';
import 'package:navi_puntos/src/pages/intros/bienvenido_page.dart';
import 'package:navi_puntos/src/pages/catalogo/catalogo_page.dart';
import 'package:navi_puntos/src/pages/factura/factura_page.dart';
import 'package:navi_puntos/src/pages/factura/foto_factura_page.dart';
import 'package:navi_puntos/src/pages/factura/foto_qr_page.dart';
import 'package:navi_puntos/src/pages/home/home_page.dart';
import 'package:navi_puntos/src/pages/home/inicio_page.dart';
import 'package:navi_puntos/src/pages/intros/intro_juegos_ahorcado.dart';
import 'package:navi_puntos/src/pages/intros/intro_juegos_adivinanza.dart';
import 'package:navi_puntos/src/pages/intros/intro_juegos_preguntas.dart';
import 'package:navi_puntos/src/pages/intros/intro_juegos_puzzle.dart';
import 'package:navi_puntos/src/pages/intros/intro_juegos_ruleta.dart';
import 'package:navi_puntos/src/pages/intros/intro_slider.dart';
import 'package:navi_puntos/src/pages/auth/login_page.dart';
import 'package:navi_puntos/src/pages/auth/perfil_page.dart';
import 'package:navi_puntos/src/pages/actividades/preguntas2_page.dart';
import 'package:navi_puntos/src/pages/actividades/preguntas_page.dart';
import 'package:navi_puntos/src/pages/actividades/puzzle2_page.dart';
import 'package:navi_puntos/src/pages/actividades/puzzle_ahorcado_page.dart';
import 'package:navi_puntos/src/pages/actividades/puzzle_page.dart';
import 'package:navi_puntos/src/pages/auth/registro_page.dart';
import 'package:navi_puntos/src/splash/splash_Page.dart';
import 'package:navi_puntos/src/pages/terminos/terminos_page.dart';

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
