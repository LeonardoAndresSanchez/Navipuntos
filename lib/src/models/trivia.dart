class Trivia {
  String idImagenActividad;
  String idActividad;
  String pista;
  String trivia;
  String respuesta;
  String imagenRespuesta;

  Trivia(
      {this.idImagenActividad,
      this.idActividad,
      this.pista,
      this.trivia,
      this.respuesta,
      this.imagenRespuesta});

  Trivia.fromJson(Map<String, dynamic> json) {
    idImagenActividad = json['idImagenActividad'];
    idActividad = json['idActividad'];
    pista = json['pista'];
    trivia = json['trivia'];
    respuesta = json['respuesta'];
    imagenRespuesta = json['imagenRespuesta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['idImagenActividad'] = this.idImagenActividad;
    data['idActividad'] = this.idActividad;
    data['pista'] = this.pista;
    data['trivia'] = this.trivia;
    data['respuesta'] = this.respuesta;
    data['imagenRespuesta'] = this.imagenRespuesta;
    return data;
  }
}
