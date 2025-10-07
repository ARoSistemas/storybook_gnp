import 'dart:convert';

import 'package:storybook_gnp/shared/models/entities/jwt_payload_mdl.dart';
import 'package:storybook_gnp/shared/models/entities/token_mdl.dart';

/// User Model
/// Represents the user details returned from the login API.
/// Includes methods for JSON serialization and deserialization.
class UserModel {
  UserModel({
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

  factory UserModel.fromRaw(String raw) => UserModel.fromMap(json.decode(raw));

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    token: json['token'] != null ? Token.fromMap(json['token']) : Token.empty(),
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

  factory UserModel.empty() => UserModel(
    token: Token(jwt: '', refreshtoken: '', jwtLogin: JwtPayload.empty()),
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
  final String uid;
  final bool banVerConvenio;
  final bool banDescargaConvenio;
  final bool banVerAviso;
  final bool banConvenioActualizado;

  UserModel copyWith({
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
  }) => UserModel(
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
}
