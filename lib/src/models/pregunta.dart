class PreguntaSeleccionMultiple {
  String idPregunta;
  String idActividad;
  String pregunta;

  PreguntaSeleccionMultiple({this.idPregunta, this.idActividad, this.pregunta});

  PreguntaSeleccionMultiple.fromJson(Map<String, dynamic> json) {
    idPregunta = json['idPregunta'];
    idActividad = json['idActividad'];
    pregunta = json['pregunta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['idPregunta'] = this.idPregunta;
    data['idActividad'] = this.idActividad;
    data['pregunta'] = this.pregunta;
    return data;
  }
}
