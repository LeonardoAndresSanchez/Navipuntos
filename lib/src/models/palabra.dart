class PalabraActividad {
  String idPalabraActividad;
  String idActividad;
  String palabra;
  String imagenAhorcado;
  PalabraActividad({this.idPalabraActividad, this.idActividad, this.palabra});

  PalabraActividad.fromJson(Map<String, dynamic> json) {
    idPalabraActividad = json['idPalabraActividad'];
    idActividad = json['idActividad'];
    palabra = json['palabra'];
    imagenAhorcado = json['imagenAhorcado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idPalabraActividad'] = this.idPalabraActividad;
    data['idActividad'] = this.idActividad;
    data['palabra'] = this.palabra;
    data['imagenAhorcado'] = this.imagenAhorcado;
    return data;
  }
}
