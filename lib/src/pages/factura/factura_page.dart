import 'package:flutter/material.dart';

import 'package:date_format/date_format.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:navi_puntos/src/pages/factura/foto_qr_page.dart';

class FacturaPage extends StatefulWidget {
  final String dato;
  final int dato1;

  FacturaPage({this.dato, this.dato1});

  @override
  _FacturaPageState createState() => _FacturaPageState();
}

class _FacturaPageState extends State<FacturaPage> {
  String _nombre = '';
  String _fecha = '';
  String _email = '';
  String _cel = '';
  String _almacen = '';

  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

  TextEditingController _inputFieldDateController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Container(
            padding: EdgeInsets.all(4.0),
            margin: EdgeInsets.fromLTRB(0, 0, 155.0, 0),
            child: Image.asset('assets/navi_logo_blanco.png'),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 22.0),
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/factura.png',
                height: size.height * 0.13,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                'Registro Factura',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            _crearNombre(),
            Divider(
              height: 1,
              color: Colors.transparent,
            ),
            Divider(
              color: Colors.transparent,
            ),
            _crearFecha(context),
            Divider(
              color: Colors.transparent,
            ),
            _crearEmail(),
            Divider(
              color: Colors.transparent,
            ),
            _crearTelefono(),
            Divider(
              color: Colors.transparent,
            ),
            _crearAlmacen(),
            Divider(
              height: size.height * 0.05,
              color: Colors.transparent,
            ),
            _crearRegistro(),
          ],
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      focusNode: _focusNode1,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _focusNode1, _focusNode2);
      },
      textInputAction: TextInputAction.next,
      // enabled: false,
      // initialValue: InicioPage.listaUser[0].nombreUsuario,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        hintText: 'Nombre y Apellido',
        labelText: 'Nombre y Apellido',
        icon: Icon(
          Icons.account_circle,
          color: HexColor('#2aa737'),
        ),
      ),
      onChanged: (valor) {
        setState(() {
          _nombre = valor;
        });
      },
      // ignore: missing_return
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
      },
    );
  }

  Widget _crearFecha(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: false,
      controller: _inputFieldDateController,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        hintText: 'AAAA-MM-DD',
        labelText: 'AAAA-MM-DD',
        suffixIcon: Icon(
          Icons.arrow_drop_down,
          color: Colors.blue[300],
        ),
        icon: Icon(
          Icons.calendar_today,
          color: HexColor('#2aa737'),
        ),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2018),
      lastDate: new DateTime(2025),
    );

    if (picked != null) {
      setState(() {
        _fecha = formatDate(picked, [yyyy, '-', mm, '-', dd, '-', hh, '-', nn]);
        _inputFieldDateController.text =
            formatDate(picked, [yyyy, '-', mm, '-', dd]);
      });
    }
  }

  Widget _crearEmail() {
    return TextFormField(
      focusNode: _focusNode2,
      // enabled: false,
      // initialValue: InicioPage.listaUser[0].emailUsuario,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _focusNode2, _focusNode3);
      },
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        labelText: 'Correo electrónico',
        icon: Icon(
          Icons.email,
          color: HexColor('#2aa737'),
        ),
      ),
      onChanged: (valor) => setState(
        () {
          _email = valor;
        },
      ),
      validator: validateEmail,
    );
  }

  Widget _crearTelefono() {
    return TextFormField(
      focusNode: _focusNode3,
      // enabled: false,
      // initialValue: InicioPage.listaUser[0].cedulaUsuario,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _focusNode3, _focusNode4);
      },
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        hintText: 'Celular',
        labelText: 'Celular',
        icon: Icon(
          Icons.local_phone,
          color: HexColor('#2aa737'),
        ),
      ),
      onChanged: (valor) => setState(() {
        _cel = valor;
      }),
      // ignore: missing_return
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
      },
    );
  }

  Widget _crearAlmacen() {
    return TextFormField(
      focusNode: _focusNode4,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        hintText: 'Almacén',
        labelText: 'Almacén',
        icon: Icon(
          Icons.home,
          color: HexColor('#2aa737'),
        ),
      ),
      onChanged: (valor) => setState(() {
        _almacen = valor;
      }),
      // ignore: missing_return
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
      },
    );
  }

  Widget _crearRegistro() {
    return MaterialButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15.0)),
      child: Text(
        'SIGUIENTE',
        textScaleFactor: 1.5,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.7,
        ),
      ),
      elevation: 5.0,
      color: HexColor('#107ec1'),
      textColor: Colors.grey[350],
      padding: EdgeInsets.all(15),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => FotoQrPage(
                      nombre: _nombre,
                      fecha: _fecha,
                      email: _email,
                      cel: _cel,
                      almacen: _almacen,
                    )));
      },
    );
  }

  // validacion de email
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Ingrese un Correo electrónico Valido ';
    else
      return null;
  }

  // nextfocusfield
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
