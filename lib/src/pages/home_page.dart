import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:navi_puntos/src/providers/menu_providers.dart';
import 'package:navi_puntos/src/utils/icon_string_utild.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes'),
      ),
      body: _lista(),
    );
  }

  Widget _lista() {
    return FutureBuilder(
      future: menuProvider.cargarData(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        return ListView(children: _listaItems(snapshot.data, context));
      },
    );
  }

  List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];
    /* if (data == null) {
      return [];
    } */

    data.forEach((opt) {
      final widgetTemp = ListTile(
        title: Text(opt['texto']),
        leading: getIcon(opt['icon']),
        trailing: Icon(
          Icons.arrow_right,
          color: HexColor('#107ec1'),
        ),
        onTap: () {
          Navigator.pushNamed(context, opt['ruta']);
        },
      );

      opciones
        ..add(widgetTemp)
        ..add(Divider(
          height: 2,
          color: Colors.grey,
        ));
    });
    return opciones;
  }
}
