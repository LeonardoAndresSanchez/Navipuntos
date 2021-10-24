import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:navi_puntos/src/utils/styles.dart';

class IntroSlider extends StatefulWidget {
  IntroSlider({Key key}) : super(key: key);

  @override
  _IntroSliderState createState() => _IntroSliderState();
}

class _IntroSliderState extends State<IntroSlider> {
  @override
  final int _numPages = 5;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.blue[300],
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: Color(0xFF3594DD),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 37.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Image.asset(
                      'assets/navi_marcaR.png',
                      width: size.width * 0.55,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Image.asset('assets/navi_logo_blanco.png',
                        width: size.width * 0.20),
                  ),
                ]),
              ),
              Container(
                height: size.height * 0.80,
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: size.height * 0.05),
                          Center(
                            child: Image.asset('assets/navi_marcaR.png'),
                          ),
                          SizedBox(height: size.height * 0.05),
                          Center(
                            child: Image(
                              image: AssetImage(
                                'assets/intro_face1.png',
                              ),
                              height: size.height * 0.35,
                            ),
                          ),
                          SizedBox(height: size.height * 0.04),
                          Center(
                            child: Text(
                              '¡Tu registro ha sido exitoso!',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: size.height * 0.05),
                          Center(
                            child: Image(
                              image: AssetImage(
                                'assets/intro_face2.png',
                              ),
                              height: size.height * 0.35,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Center(
                            child: Text(
                              'DIVERSIÓN',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Center(
                            child: Text(
                              'Cada semana llegará un juego para acumular puntos y reclamar premios.',
                              textAlign: TextAlign.center,
                              style: kSubtitleStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: size.height * 0.05),
                          Center(
                            child: Image(
                              image: AssetImage(
                                'assets/intro_face3.png',
                              ),
                              height: size.height * 0.35,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Center(
                            child: Text(
                              'PREMIOS',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Center(
                            child: Text(
                              'Los puntos acumulados podrán ser canjeados por premios del catálogo.',
                              textAlign: TextAlign.center,
                              style: kSubtitleStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: size.height * 0.05),
                          Center(
                            child: Image(
                              image: AssetImage(
                                'assets/intro_face4.png',
                              ),
                              height: size.height * 0.35,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Center(
                            child: Text(
                              'JUEGOS',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Center(
                            child: Text(
                              'Son 22 juegos en total que se deben completar para participar en el premio mayor de un televisor.',
                              textAlign: TextAlign.center,
                              style: kSubtitleStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: size.height * 0.05),
                          Center(
                            child: Image(
                              image: AssetImage(
                                'assets/intro_face5.png',
                              ),
                              height: size.height * 0.35,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Center(
                            child: Text(
                              'DIVERSIÓN',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Center(
                            child: Text(
                              'ENTRETENIMIENTO',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Center(
                            child: Text(
                              'PREMIOS',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 60.0,
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('inicio'),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'EMPECEMOS',
                      style: TextStyle(
                        color: HexColor('#107ec1'),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}
