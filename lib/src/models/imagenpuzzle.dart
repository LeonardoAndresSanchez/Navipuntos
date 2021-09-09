class ImagenPuzzle {
  String idImagenPuzzle;
  String idActividad;
  String tipoPuzzle;
  String rutaImagen;

  ImagenPuzzle(
      {this.idImagenPuzzle,
      this.idActividad,
      this.tipoPuzzle,
      this.rutaImagen});

  ImagenPuzzle.fromJson(Map<String, dynamic> json) {
    idImagenPuzzle = json['idImagenPuzzle'];
    idActividad = json['idActividad'];
    tipoPuzzle = json['tipoPuzzle'];
    rutaImagen = json['rutaImagen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['idImagenPuzzle'] = this.idImagenPuzzle;
    data['idActividad'] = this.idActividad;
    data['tipoPuzzle'] = this.tipoPuzzle;
    data['rutaImagen'] = this.rutaImagen;
    return data;
  }
}
