class User {
  String idUsuario;
  String cedulaUsuario;
  String nombreUsuario;
  String telefonoUsuario;
  String emailUsuario;
  String passwordUsuario;
  String estadoSesionUsuario;

  User(
      {this.idUsuario,
      this.cedulaUsuario,
      this.nombreUsuario,
      this.telefonoUsuario,
      this.emailUsuario,
      this.passwordUsuario,
      this.estadoSesionUsuario});

  User.fromJson(Map<String, dynamic> json) {
    idUsuario = json['idUsuario'];
    cedulaUsuario = json['cedulaUsuario'];
    nombreUsuario = json['nombreUsuario'];
    telefonoUsuario = json['telefonoUsuario'];
    emailUsuario = json['emailUsuario'];
    passwordUsuario = json['passwordUsuario'];
    estadoSesionUsuario = json['estadoSesionUsuario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idUsuario'] = this.idUsuario;
    data['cedulaUsuario'] = this.cedulaUsuario;
    data['nombreUsuario'] = this.nombreUsuario;
    data['telefonoUsuario'] = this.telefonoUsuario;
    data['emailUsuario'] = this.emailUsuario;
    data['passwordUsuario'] = this.passwordUsuario;
    data['estadoSesionUsuario'] = this.estadoSesionUsuario;
    return data;
  }
}
