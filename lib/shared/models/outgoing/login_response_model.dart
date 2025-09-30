import 'dart:convert';

LoginRespondeModel loginResponseModelFromJson(String str) =>
LoginRespondeModel.fromJson(json.decode(str));

class LoginRespondeModel {
  LoginRespondeModel({
    this.token,
    this.codigoFiliacion,
    this.rfc,
    this.nombreCompleto,
    this.especialidad,
    this.estado,
    this.circulo,
    this.tabulador,
    this.estatus,
    this.vigenciaConvenio,
    this.banVerConvenio,
    this.banDescargaConvenio,
    this.uid,
    this.banVerAviso,
    this.banConvenioActualizado,
  });

  factory LoginRespondeModel.fromJson(Map<String, dynamic> json) =>
      LoginRespondeModel(
        // token: json['token'], == null ? null: Token.fromJson(json['token']),
        codigoFiliacion: json['codigoFiliacion'],
        rfc: json['rfc'],
        nombreCompleto: json['nombreCompleto'],
        especialidad: json['especialidad'],
        estado: json['estado'],
        circulo: json['circulo'],
        tabulador: json['tabulador'],
        estatus: json['estatus'],
        vigenciaConvenio: json['vigenciaConvenio'],
        banVerConvenio: json['banVerConvenio'],
        banDescargaConvenio: json['banDescargaConvenio'],
        uid: json['uid'],
        banVerAviso: json['banVerAviso'],
        banConvenioActualizado: json['banConvenioActualizado'],
      );

  Map<String, dynamic> toJson() => {
    'token': token?.toJson(),
    'codigoFiliacion': codigoFiliacion,
    'rfc': rfc,
    'nombreCompleto': nombreCompleto,
    'especialidad': especialidad,
    'estado': estado,
    'circulo': circulo,
    'tabulador': tabulador,
    'estatus': estatus,
    'vigenciaConvenio': vigenciaConvenio,
    'banVerConvenio': banVerConvenio,
    'banDescargaConvenio': banDescargaConvenio,
    'uid': uid,
    'banVerAviso': banVerAviso,
    'banConvenioActualizado': banConvenioActualizado,
  };

  final Token? token;
  final String? codigoFiliacion;
  final String? rfc;
  final String? nombreCompleto;
  final String? especialidad;
  final String? estado;
  final String? circulo;
  final String? tabulador;
  final String? estatus;
  final String? vigenciaConvenio;
  final bool? banVerConvenio;
  final bool? banDescargaConvenio;
  final String? uid;
  final bool? banVerAviso;
  final bool? banConvenioActualizado;
}

class Token {
  Token({
    this.jwt,
    this.refreshtoken,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    jwt: json['jwt'],
    refreshtoken: json['refreshtoken'],
  );
  Map<String, dynamic> toJson() => {
    'jwt': jwt,
    'refreshtoken': refreshtoken,
  };

  final String? jwt;
  final String? refreshtoken;
}
