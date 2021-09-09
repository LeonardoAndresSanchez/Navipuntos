class Catalogo {
  String idCatalogoPremio;
  String nombrePremio;
  String imagenPremio;
  String totalPuntoPremio;
  String stock;

  Catalogo(
      {this.idCatalogoPremio,
      this.nombrePremio,
      this.imagenPremio,
      this.totalPuntoPremio,
      this.stock});

  Catalogo.fromJson(Map<String, dynamic> json) {
    idCatalogoPremio = json['idCatalogoPremio'];
    nombrePremio = json['nombrePremio'];
    imagenPremio = json['imagenPremio'];
    totalPuntoPremio = json['totalPuntoPremio'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idCatalogoPremio'] = this.idCatalogoPremio;
    data['nombrePremio'] = this.nombrePremio;
    data['imagenPremio'] = this.imagenPremio;
    data['totalPuntoPremio'] = this.totalPuntoPremio;
    data['stock'] = this.stock;
    return data;
  }
}
