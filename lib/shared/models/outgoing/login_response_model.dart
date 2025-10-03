import 'dart:convert';

class LoginMdl {
  LoginMdl({
    required this.token,
    required this.codAfiliacion,
    required this.rfc,
    required this.nombreCompleto,
    required this.especialidad,
    required this.estado,
    required this.circulo,
    required this.tabulador,
    required this.estatus,
    required this.vigenciaConvenio,
    required this.banVerConvenio,
    required this.banDescargaConvenio,
    required this.uid,
    required this.banVerAviso,
    required this.banConvenioActualizado,
  });

  factory LoginMdl.fromRaw(String raw) => LoginMdl.fromMap(json.decode(raw));

  factory LoginMdl.fromMap(Map<String, dynamic> json) => LoginMdl(
    token: json['token'] ?? '',
    codAfiliacion: json['codAfiliacion'] ?? '',
    rfc: json['rfc'] ?? '',
    nombreCompleto: json['nombreCompleto'] ?? '',
    especialidad: json['especialidad'] ?? '',
    estado: json['estado'] ?? '',
    circulo: json['circulo'] ?? '',
    tabulador: json['tabulador'] ?? '',
    estatus: json['estatus'] ?? '',
    vigenciaConvenio: json['vigenciaConvenio'] ?? '',
    banVerConvenio: json['banVerConvenio'] ?? false,
    banDescargaConvenio: json['banDescargaConvenio'] ?? false,
    uid: json['uid'] ?? '',
    banVerAviso: json['banVerAviso'] ?? false,
    banConvenioActualizado: json['banConvenioActualizado'] ?? false,
  );

  factory LoginMdl.empty() => LoginMdl(
    token: Token(jwt: '', refreshtoken: ''),
    codAfiliacion: '',
    rfc: '',
    nombreCompleto: '',
    especialidad: '',
    estado: '',
    circulo: '',
    tabulador: '',
    estatus: '',
    vigenciaConvenio: '',
    banVerConvenio: false,
    banDescargaConvenio: false,
    uid: '',
    banVerAviso: false,
    banConvenioActualizado: false,
  );

  LoginMdl copyWith({
    Token? token,
    String? codAfiliacion,
    String? rfc,
    String? nombreCompleto,
    String? especialidad,
    String? estado,
    String? circulo,
    String? tabulador,
    String? estatus,
    String? vigenciaConvenio,
    bool? banVerConvenio,
    bool? banDescargaConvenio,
    String? uid,
    bool? banVerAviso,
    bool? banConvenioActualizado,
  }) => LoginMdl(
    token: token ?? this.token,
    codAfiliacion: codAfiliacion ?? this.codAfiliacion,
    rfc: rfc ?? this.rfc,
    nombreCompleto: nombreCompleto ?? this.nombreCompleto,
    especialidad: especialidad ?? this.especialidad,
    estado: estado ?? this.estado,
    circulo: circulo ?? this.circulo,
    tabulador: tabulador ?? this.tabulador,
    estatus: estatus ?? this.estatus,
    vigenciaConvenio: vigenciaConvenio ?? this.vigenciaConvenio,
    banVerConvenio: banVerConvenio ?? this.banVerConvenio,
    banDescargaConvenio: banDescargaConvenio ?? this.banDescargaConvenio,
    uid: uid ?? this.uid,
    banVerAviso: banVerAviso ?? this.banVerAviso,
    banConvenioActualizado:
        banConvenioActualizado ?? this.banConvenioActualizado,
  );

  Map<String, dynamic> toJson() => {
    'token': token.toJson(),
    'codAfiliacion': codAfiliacion,
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

  final Token token;
  final String codAfiliacion;
  final String rfc;
  final String nombreCompleto;
  final String especialidad;
  final String estado;
  final String circulo;
  final String tabulador;
  final String estatus;
  final String vigenciaConvenio;
  final bool banVerConvenio;
  final bool banDescargaConvenio;
  final String uid;
  final bool banVerAviso;
  final bool banConvenioActualizado;
}

/// Token Model
/// Represents the JWT and refresh token for user authentication.
/// Includes methods for JSON serialization and deserialization.
class Token {
  Token({
    required this.jwt,
    required this.refreshtoken,
  });

  factory Token.fromRaw(String raw) => Token.fromMap(json.decode(raw));

  factory Token.fromMap(Map<String, dynamic> json) => Token(
    jwt: json['jwt'] ?? '',
    refreshtoken: json['refreshtoken'] ?? '',
  );

  Token copyWith({
    String? jwt,
    String? refreshtoken,
  }) => Token(
    jwt: jwt ?? this.jwt,
    refreshtoken: refreshtoken ?? this.refreshtoken,
  );

  Map<String, dynamic> toJson() => {
    'jwt': jwt,
    'refreshtoken': refreshtoken,
  };

  final String jwt;
  final String refreshtoken;
}
