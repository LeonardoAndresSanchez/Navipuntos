class RespuestaPregunta {
  String idRespuesta;
  String idPregunta;
  String respuestaPregunta;
  String correcta;

  RespuestaPregunta(
      {this.idRespuesta,
      this.idPregunta,
      this.respuestaPregunta,
      this.correcta});

  RespuestaPregunta.fromJson(Map<String, dynamic> json) {
    idRespuesta = json['idRespuesta'];
    idPregunta = json['idPregunta'];
    respuestaPregunta = json['respuestaPregunta'];
    correcta = json['correcta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['idRespuesta'] = this.idRespuesta;
    data['idPregunta'] = this.idPregunta;
    data['respuestaPregunta'] = this.respuestaPregunta;
    data['correcta'] = this.correcta;
    return data;
  }
}
