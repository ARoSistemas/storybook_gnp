
// import 'dart:convert';

// class LoginMdl {
//   LoginMdl({
//required this.code, 
//required this.message, 
//required this.payload});

//   factory LoginMdl.fromRaw(String raw) => LoginMdl.fromMap(json.decode(raw));

//   factory LoginMdl.fromMap(Map<String, dynamic> json) => LoginMdl(
//     code: json['code'] ?? 0,
//     message: json['message'] ?? '',
//     payload: json['payload'] != null
//         ? DataLogin.fromMap(json['payload'])
//         : DataLogin.empty(),
//   );

//   factory LoginMdl.empty() => LoginMdl(
//     code: 0,
//     message: '',
//     payload: DataLogin.empty(),
//   );

//   factory LoginMdl.hardCode() => LoginMdl.fromMap(jsonDecode(rHardCode));

//   LoginMdl copyWith({
//     int? code,
//     String? message,
//     DataLogin? payload,
//   }) => LoginMdl(
//     code: code ?? this.code,
//     message: message ?? this.message,
//     payload: payload ?? this.payload,
//   );

//   Map<String, dynamic> toJson() => {
//     'code': code,
//     'message': message,
//     'payload': payload.toJson(),
//   };

//   final int code;
//   final String message;
//   final DataLogin payload;


// class DataLogin {
//   DataLogin({
//     required this.token,
//     required this.codAfiliacion,
//     required this.rfc,
//     required this.nombreCompleto,
//     required this.especialidad,
//     required this.estado,
//     required this.circulo,
//     required this.tabulador,
//     required this.estatus,
//     required this.vigenciaConvenio,
//     required this.banVerConvenio,
//     required this.banDescargaConvenio,
//     required this.uid,
//     required this.banVerAviso,
//     required this.banConvenioActualizado,
//   });

//   factory DataLogin.fromRaw(String raw) => 
// DataLogin.fromMap(json.decode(raw));

//   factory DataLogin.fromMap(Map<String, dynamic> json) => DataLogin(
//     token: json['token'] != null ? 
//Token.fromMap(json['token']) : Token.empty(),
//     codAfiliacion: json['codAfiliacion'] ?? '',
//     rfc: json['rfc'] ?? '',
//     nombreCompleto: json['nombreCompleto'] ?? '',
//     especialidad: json['especialidad'] ?? '',
//     estado: json['estado'] ?? '',
//     circulo: json['circulo'] ?? '',
//     tabulador: json['tabulador'] ?? '',
//     estatus: json['estatus'] ?? '',
//     vigenciaConvenio: json['vigenciaConvenio'] ?? '',
//     banVerConvenio: json['banVerConvenio'] ?? false,
//     banDescargaConvenio: json['banDescargaConvenio'] ?? false,
//     uid: json['uid'] ?? '',
//     banVerAviso: json['banVerAviso'] ?? false,
//     banConvenioActualizado: json['banConvenioActualizado'] ?? false,
//   );

//   factory DataLogin.empty() => DataLogin(
//     token: Token(jwt: '', refreshtoken: '', jwtLogin: JwtPayload.empty()),
//     codAfiliacion: '',
//     rfc: '',
//     nombreCompleto: '',
//     especialidad: '',
//     estado: '',
//     circulo: '',
//     tabulador: '',
//     estatus: '',
//     vigenciaConvenio: '',
//     banVerConvenio: false,
//     banDescargaConvenio: false,
//     uid: '',
//     banVerAviso: false,
//     banConvenioActualizado: false,
//   );

//   final Token token;
//   final String codAfiliacion;
//   final String rfc;
//   final String nombreCompleto;
//   final String especialidad;
//   final String estado;
//   final String circulo;
//   final String tabulador;
//   final String estatus;
//   final String vigenciaConvenio;
//   final String uid;
//   final bool banVerConvenio;
//   final bool banDescargaConvenio;
//   final bool banVerAviso;
//   final bool banConvenioActualizado;

//   DataLogin copyWith({
//     Token? token,
//     String? codAfiliacion,
//     String? rfc,
//     String? nombreCompleto,
//     String? especialidad,
//     String? estado,
//     String? circulo,
//     String? tabulador,
//     String? estatus,
//     String? vigenciaConvenio,
//     bool? banVerConvenio,
//     bool? banDescargaConvenio,
//     String? uid,
//     bool? banVerAviso,
//     bool? banConvenioActualizado,
//   }) => DataLogin(
//     token: token ?? this.token,
//     codAfiliacion: codAfiliacion ?? this.codAfiliacion,
//     rfc: rfc ?? this.rfc,
//     nombreCompleto: nombreCompleto ?? this.nombreCompleto,
//     especialidad: especialidad ?? this.especialidad,
//     estado: estado ?? this.estado,
//     circulo: circulo ?? this.circulo,
//     tabulador: tabulador ?? this.tabulador,
//     estatus: estatus ?? this.estatus,
//     vigenciaConvenio: vigenciaConvenio ?? this.vigenciaConvenio,
//     banVerConvenio: banVerConvenio ?? this.banVerConvenio,
//     banDescargaConvenio: banDescargaConvenio ?? this.banDescargaConvenio,
//     uid: uid ?? this.uid,
//     banVerAviso: banVerAviso ?? this.banVerAviso,
//     banConvenioActualizado:
//         banConvenioActualizado ?? this.banConvenioActualizado,
//   );

//   Map<String, dynamic> toJson() => {
//     'token': token.toJson(),
//     'codAfiliacion': codAfiliacion,
//     'rfc': rfc,
//     'nombreCompleto': nombreCompleto,
//     'especialidad': especialidad,
//     'estado': estado,
//     'circulo': circulo,
//     'tabulador': tabulador,
//     'estatus': estatus,
//     'vigenciaConvenio': vigenciaConvenio,
//     'banVerConvenio': banVerConvenio,
//     'banDescargaConvenio': banDescargaConvenio,
//     'uid': uid,
//     'banVerAviso': banVerAviso,
//     'banConvenioActualizado': banConvenioActualizado,
//   };
// }

// /// Token Model
// /// Represents the JWT and refresh token for user authentication.
// /// Includes methods for JSON serialization and deserialization.
// class Token {
//   Token({
//     required this.jwt,
//     required this.refreshtoken,
//     required this.jwtLogin,
//   });

//   factory Token.fromRaw(String raw) => Token.fromMap(json.decode(raw));

//   factory Token.fromMap(Map<String, dynamic> json) {
//     final String jwt = json['jwt'] ?? '';
//     return Token(
//       jwt: jwt,
//       refreshtoken: json['refreshtoken'] ?? '',
//       jwtLogin: jwt.split('.').length != 3
//           ? JwtPayload.empty()
//           : parseJwt(json['jwt']),
//     );
//   }

//   factory Token.empty() => Token(
//     jwt: '',
//     refreshtoken: '',
//     jwtLogin: JwtPayload.empty(),
//   );

//   Token copyWith({
//     String? jwt,
//     String? refreshtoken,
//     JwtPayload? jwtLogin,
//   }) => Token(
//     jwt: jwt ?? this.jwt,
//     refreshtoken: refreshtoken ?? this.refreshtoken,
//     jwtLogin: jwtLogin ?? this.jwtLogin,
//   );

//   Map<String, dynamic> toJson() => {
//     'jwt': jwt,
//     'refreshtoken': refreshtoken,
//     'jwtLogin': jwtLogin.toJson(),
//   };

//   final String jwt;
//   final String refreshtoken;
//   final JwtPayload jwtLogin;
// }

// JwtPayload parseJwt(String token) {
//   final List<String> parts = token.split('.');
//   if (parts.length != 3) {
//     throw Exception('Token no válido');
//   }

//   final String payload = parts[1];
//   final String normalized = base64Url.normalize(payload);
//   final String decoded = utf8.decode(base64Url.decode(normalized));
//   final Map<String, dynamic> payloadMap = jsonDecode(decoded);

//   return JwtPayload.fromJson(payloadMap);
// }

// class JwtPayload {
//   JwtPayload({
//     required this.iss,
//     required this.sub,
//     required this.aud,
//     required this.iat,
//     required this.exp,
//     required this.projectId,
//     required this.uid,
//     required this.claims,
//   });

//   factory JwtPayload.empty() => JwtPayload(
//     iss: '',
//     sub: '',
//     aud: '',
//     iat: 0,
//     exp: 0,
//     projectId: '',
//     uid: '',
//     claims: Claims.empty(),
//   );

//   factory JwtPayload.fromJson(Map<String, dynamic> json) => JwtPayload(
//     iss: json['iss'],
//     sub: json['sub'],
//     aud: json['aud'],
//     iat: json['iat'],
//     exp: json['exp'],
//     projectId: json['projectid'],
//     uid: json['uid'],
//     claims: Claims.fromJson(json['claims']),
//   );

//   Map<String, dynamic> toJson() => {
//     'iss': iss,
//     'sub': sub,
//     'aud': aud,
//     'iat': iat,
//     'exp': exp,
//     'projectId': projectId,
//     'uid': uid,
//     'claims': claims.toJson(),
//   };

//   final String iss;
//   final String sub;
//   final String aud;
//   final int iat;
//   final int exp;
//   final String projectId;
//   final String uid;
//   final Claims claims;
// }

// class Claims {
//   Claims({
//     required this.rol,
//     required this.negociosOperables,
//     required this.idParticipante,
//     required this.mail,
//     required this.apeMaterno,
//     required this.givenName,
//     required this.apePaterno,
//     required this.cuentaBloqueda,
//     required this.tipoUsuario,
//     required this.cedula,
//     required this.roles,
//   });

//   factory Claims.empty() => Claims(
//     rol: '',
//     negociosOperables: '',
//     idParticipante: '',
//     mail: '',
//     apeMaterno: '',
//     givenName: '',
//     apePaterno: '',
//     cuentaBloqueda: false,
//     tipoUsuario: '',
//     cedula: '',
//     roles: [],
//   );

//   factory Claims.fromJson(Map<String, dynamic> json) => Claims(
//     rol: json['rol'] ?? '',
//     negociosOperables: json['negociosOperables'] ?? '',
//     idParticipante: json['idparticipante'] ?? '',
//     mail: json['mail'] ?? '',
//     apeMaterno: json['apematerno'] ?? '',
//     givenName: json['givenname'] ?? '',
//     apePaterno: json['apepaterno'] ?? '',
//     cuentaBloqueda: json['cuentabloqueda'] ?? false,
//     tipoUsuario: json['tipousuario'] ?? '',
//     cedula: json['cedula'] ?? '',
//     roles: List<String>.from(json['roles'] ?? []),
//   );

//   Map<String, dynamic> toJson() => {
//     'rol': rol,
//     'negociosOperables': negociosOperables,
//     'idParticipante': idParticipante,
//     'mail': mail,
//     'apeMaterno': apeMaterno,
//     'givenName': givenName,
//     'apePaterno': apePaterno,
//     'cuentaBloqueda': cuentaBloqueda,
//     'tipoUsuario': tipoUsuario,
//     'cedula': cedula,
//   };


//   final String rol;
//   final String negociosOperables;
//   final String idParticipante;
//   final String mail;
//   final String apeMaterno;
//   final String givenName;
//   final String apePaterno;
//   final bool cuentaBloqueda;
//   final String tipoUsuario;
//   final String cedula;
//   final List<String> roles;
// }
