import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class IntroJuegosAhorcado extends StatefulWidget {
  IntroJuegosAhorcado({Key key}) : super(key: key);

  @override
  _IntroJuegosAhorcadoState createState() => _IntroJuegosAhorcadoState();
}

class _IntroJuegosAhorcadoState extends State<IntroJuegosAhorcado> {
  @override
  final int _numPages = 1;
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
    final size = MediaQuery.of(context).size;

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: size.height * 0.010,
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
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          padding: EdgeInsets.only(top: 50),
          color: HexColor('#107ec1'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: size.height * 0.80,
                decoration: new BoxDecoration(
                  color: HexColor('#107ec1'),
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/intro_juegos5.png',
                    ),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: <Widget>[
                    // Padding(
                    //   padding: EdgeInsets.all(40.0),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: <Widget>[
                    //       SizedBox(height: size.height * 0.03),
                    //       Center(
                    //         child: Text(
                    //           '¿Cómo jugar?',
                    //           style: kTitleStyle2,
                    //           textAlign: TextAlign.center,
                    //         ),
                    //       ),
                    //       SizedBox(height: size.height * 0.03),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Container(
                    //     decoration: new BoxDecoration(
                    //       color: HexColor('#107ec1'),
                    //       image: DecorationImage(
                    //         image: AssetImage(
                    //           'assets/intro_juegos5.png',
                    //         ),
                    //         fit: BoxFit.fill,
                    //       ),
                    //     ),
                    // child: Center(
                    //   child: Image(
                    //     image: AssetImage(
                    //       'assets/intro_juegos5.png',
                    //     ),
                    //     height: size.height * 1,
                    //   ),
                    // ),
                    // ),
                    // ),
                    //     ],
                    //   ),
                    // ),
                    // Image(
                    //   image: AssetImage(
                    //     'assets/intro_juegos5.png',
                    //   ),
                    //   height: size.height * 0.60,
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.all(40.0),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: <Widget>[
                    //       SizedBox(height: size.height * 0.03),
                    //       Center(
                    //         child: Text(
                    //           '¿Cómo jugar?',
                    //           style: kTitleStyle2,
                    //           textAlign: TextAlign.center,
                    //         ),
                    //       ),
                    //       SizedBox(height: size.height * 0.03),
                    //       Center(
                    //         child: Image(
                    //           image: AssetImage(
                    //             'assets/intro_juegos6.png',
                    //           ),
                    //           height: size.height * 0.65,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: _buildPageIndicator(),
              // ),
            ],
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: size.height * 0.07,
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('Ahorcado');
                },
                // onTap: () => Navigator.of(context).pushNamed('actividades'),

                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'EMPECEMOS',
                      style: TextStyle(
                        color: Colors.blue,
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
