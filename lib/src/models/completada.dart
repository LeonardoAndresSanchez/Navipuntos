class ActividadCompletada {
  String idActividad;
  String estado;

  ActividadCompletada({
    this.idActividad,
    this.estado,
  });

  ActividadCompletada.fromJson(Map<String, dynamic> json) {
    idActividad = json['idActividad'];
    estado = json['estado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idActividad'] = this.idActividad;
    data['estado'] = this.estado;

    return data;
  }
}
