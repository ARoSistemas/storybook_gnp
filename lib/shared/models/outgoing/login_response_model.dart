import 'dart:convert';

class LoginMdl {
  LoginMdl({required this.code, required this.message, required this.payload});

  factory LoginMdl.fromRaw(String raw) => LoginMdl.fromMap(json.decode(raw));

  factory LoginMdl.fromMap(Map<String, dynamic> json) => LoginMdl(
    code: json['code'] ?? 0,
    message: json['message'] ?? '',
    payload: json['payload'] != null
        ? DataLogin.fromMap(json['payload'])
        : DataLogin.empty(),
  );

  factory LoginMdl.empty() => LoginMdl(
    code: 0,
    message: '',
    payload: DataLogin.empty(),
  );

  factory LoginMdl.hardCode() => LoginMdl.fromMap(jsonDecode(rHardCode));

  LoginMdl copyWith({
    int? code,
    String? message,
    DataLogin? payload,
  }) => LoginMdl(
    code: code ?? this.code,
    message: message ?? this.message,
    payload: payload ?? this.payload,
  );

  Map<String, dynamic> toJson() => {
    'code': code,
    'message': message,
    'payload': payload.toJson(),
  };

  final int code;
  final String message;
  final DataLogin payload;

  static const String rHardCode = '''
{
    "code": 200,
    "message": "",
    "payload": {
        "token": {
            "jwt": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJmaXJlYmFzZS1qd3RAZ25wLWFkbW9ucHJvdmVlZG9yZXNzYWx1ZC1xYS5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsInN1YiI6ImZpcmViYXNlLWp3dEBnbnAtYWRtb25wcm92ZWVkb3Jlc3NhbHVkLXFhLmlhbS5nc2VydmljZWFjY291bnQuY29tIiwiYXVkIjoiaHR0cHM6XC9cL2lkZW50aXR5dG9vbGtpdC5nb29nbGVhcGlzLmNvbVwvZ29vZ2xlLmlkZW50aXR5LmlkZW50aXR5dG9vbGtpdC52MS5JZGVudGl0eVRvb2xraXQiLCJpYXQiOjE3NTk1MjM2OTAsImV4cCI6MTc1OTUyNTQ5MCwicHJvamVjdGlkIjoiZ25wLWFkbW9ucHJvdmVlZG9yZXNzYWx1ZC1xYSIsInVpZCI6Ik1EVU1FSUowMjgiLCJjbGFpbXMiOnsicm9sIjoiSU5VS0kgTUVMT1BJIiwibmVnb2Npb3NPcGVyYWJsZXMiOiJNRFVNRUlKMDI4IiwiaWRwYXJ0aWNpcGFudGUiOiJNRFVNRUlKMDI4IiwibWFpbCI6ImhlcnJhbWllbnRhc2IyQGdtYWlsLmNvbSIsImFwZW1hdGVybm8iOiJNRUxPUEkiLCJnaXZlbm5hbWUiOiJKVUFOIEpBQ09CTyIsImFwZXBhdGVybm8iOiJJTlVLSSIsImN1ZW50YWJsb3F1ZWFkYSI6ZmFsc2UsInRpcG91c3VhcmlvIjoicHJvdmVlZG9yZXMiLCJjZWR1bGEiOiIiLCJyb2xlcyI6WyJQcm92ZWVkb3IiXX19.a4adYBTxPzlrHzc1Y9UnpETr5fyTYQ91mqq7hrlyvp8tR9SaG5GZKiGm8DFFsp2WalrP8QZVgvf8N1YCPGPyyKfTaCuxabF5-s861E6hWam79iklZxlDkGTSjr8YtOWfsrdgMKlhHaJWtimq0IGghjI4afo1w0nau4jOfXvAH4WmnoSPnPHkFmqdxrOGKjMRwKhR1_uItjJC8qHGa2LVaqFeTPrKlfx9sI8j0UQiIUnHH0bsbUg8weXdBBtkRHM15z0qBWfXs_Wa7cnNJD0SrNFDa8os_LmFIMtOSuFFWfpPQQiDjybQugyCPWEF8KtyIRzcjwHiUxYDadKE5bQMmg",
            "refreshtoken": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJmaXJlYmFzZS1qd3RAZ25wLWF1dGguaWFtLmdzZXJ2aWNlYWNjb3VudC5jb20iLCJzdWIiOiJmaXJlYmFzZS1qd3RAZ25wLWF1dGguaWFtLmdzZXJ2aWNlYWNjb3VudC5jb20iLCJhdWQiOiJodHRwczpcL1wvaWRlbnRpdHl0b29sa2l0Lmdvb2dsZWFwaXMuY29tXC9nb29nbGUuaWRlbnRpdHkuaWRlbnRpdHl0b29sa2l0LnYxLklkZW50aXR5VG9vbGtpdCIsImlhdCI6MTc1OTUyMzY5MCwiZXhwIjoxNzU5NjEwMDkwLCJ1aWQiOiJNRFVNRUlKMDI4IiwicHJvamVjdGlkIjoiZ25wLWFkbW9ucHJvdmVlZG9yZXNzYWx1ZC1xYSIsIm1vYmlsZSI6ZmFsc2UsImNsYWltcyI6eyJyb2wiOiJJTlVLSSBNRUxPUEkiLCJuZWdvY2lvc09wZXJhYmxlcyI6Ik1EVU1FSUowMjgiLCJpZHBhcnRpY2lwYW50ZSI6Ik1EVU1FSUowMjgiLCJtYWlsIjoiaGVycmFtaWVudGFzYjJAZ21haWwuY29tIiwiYXBlbWF0ZXJubyI6Ik1FTE9QSSIsImdpdmVubmFtZSI6IkpVQU4gSkFDT0JPIiwiYXBlcGF0ZXJubyI6IklOVUtJIiwiY3VlbnRhYmxvcXVlYWRhIjpmYWxzZSwidGlwb3VzdWFyaW8iOiJwcm92ZWVkb3JlcyIsImNlZHVsYSI6IiIsInJvbGVzIjpbIlByb3ZlZWRvciJdfX0.iVkxt5bRqi0glgbxLIbHfzwmV8UbKjuFGWBDkBz8c8xeh52oY4ilGQMq3kam-IZ952IHye6QF93rp7Anr5zORbt1lvvvnkUygInpMTR1ELiM0aTuDVvWKXmtsR9RJrk3rBgRYgBFW95efc4wOQFWb0cc34TRmLvE2cIT3FhMuPRQCCUXUtBuoiQGXbYWJ5ZucQDzB1YK_LhyVLAgwiRl3mQ2DZ3j3Cv26CCihtrwi3VElqTEGYO1OcqTk5cSf0FiK915ETkrM_XIz0DN2sxLbjyS66cXLWpC_sAnJ13UK80atabKxEXE4ZumsvFO_42liKMYJvIvKWuwn5KI2X_8pg"
        },
        "codigoFiliacion": "0000799393",
        "rfc": "AAGJ500515KP8",
        "nombreCompleto": "JUAN JACOBO INUKI MELOPI",
        "especialidad": "INFECTOLOGIA",
        "estado": "CIUDAD DE MEXICO",
        "circulo": "OMNIA",
        "tabulador": "",
        "estatus": "VI",
        "vigenciaConvenio": "01 agosto 2025 - 31 agosto 2025",
        "banVerConvenio": true,
        "banDescargaConvenio": true,
        "uid": null,
        "banVerAviso": false,
        "banConvenioActualizado": false
    }
}''';
}

class DataLogin {
  DataLogin({
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

  factory DataLogin.fromRaw(String raw) => DataLogin.fromMap(json.decode(raw));

  factory DataLogin.fromMap(Map<String, dynamic> json) => DataLogin(
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

  factory DataLogin.empty() => DataLogin(
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

  DataLogin copyWith({
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
  }) => DataLogin(
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

/// Token Model
/// Represents the JWT and refresh token for user authentication.
/// Includes methods for JSON serialization and deserialization.
class Token {
  Token({
    required this.jwt,
    required this.refreshtoken,
    required this.jwtLogin,
  });

  factory Token.fromRaw(String raw) => Token.fromMap(json.decode(raw));

  factory Token.fromMap(Map<String, dynamic> json) {
    final String jwt = json['jwt'] ?? '';
    return Token(
      jwt: jwt,
      refreshtoken: json['refreshtoken'] ?? '',
      jwtLogin: jwt.split('.').length != 3
          ? JwtPayload.empty()
          : parseJwt(json['jwt']),
    );
  }

  factory Token.empty() => Token(
    jwt: '',
    refreshtoken: '',
    jwtLogin: JwtPayload.empty(),
  );

  Token copyWith({
    String? jwt,
    String? refreshtoken,
    JwtPayload? jwtLogin,
  }) => Token(
    jwt: jwt ?? this.jwt,
    refreshtoken: refreshtoken ?? this.refreshtoken,
    jwtLogin: jwtLogin ?? this.jwtLogin,
  );

  Map<String, dynamic> toJson() => {
    'jwt': jwt,
    'refreshtoken': refreshtoken,
    'jwtLogin': jwtLogin.toJson(),
  };

  final String jwt;
  final String refreshtoken;
  final JwtPayload jwtLogin;
}

JwtPayload parseJwt(String token) {
  final List<String> parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('Token no válido');
  }

  final String payload = parts[1];
  final String normalized = base64Url.normalize(payload);
  final String decoded = utf8.decode(base64Url.decode(normalized));
  final Map<String, dynamic> payloadMap = jsonDecode(decoded);

  return JwtPayload.fromJson(payloadMap);
}

class JwtPayload {
  JwtPayload({
    required this.iss,
    required this.sub,
    required this.aud,
    required this.iat,
    required this.exp,
    required this.projectId,
    required this.uid,
    required this.claims,
  });

  factory JwtPayload.empty() => JwtPayload(
    iss: '',
    sub: '',
    aud: '',
    iat: 0,
    exp: 0,
    projectId: '',
    uid: '',
    claims: Claims.empty(),
  );

  factory JwtPayload.fromJson(Map<String, dynamic> json) => JwtPayload(
    iss: json['iss'],
    sub: json['sub'],
    aud: json['aud'],
    iat: json['iat'],
    exp: json['exp'],
    projectId: json['projectid'],
    uid: json['uid'],
    claims: Claims.fromJson(json['claims']),
  );

  Map<String, dynamic> toJson() => {
    'iss': iss,
    'sub': sub,
    'aud': aud,
    'iat': iat,
    'exp': exp,
    'projectId': projectId,
    'uid': uid,
    'claims': claims.toJson(),
  };

  final String iss;
  final String sub;
  final String aud;
  final int iat;
  final int exp;
  final String projectId;
  final String uid;
  final Claims claims;
}

class Claims {
  Claims({
    required this.rol,
    required this.negociosOperables,
    required this.idParticipante,
    required this.mail,
    required this.apeMaterno,
    required this.givenName,
    required this.apePaterno,
    required this.cuentaBloqueda,
    required this.tipoUsuario,
    required this.cedula,
    required this.roles,
  });

  factory Claims.empty() => Claims(
    rol: '',
    negociosOperables: '',
    idParticipante: '',
    mail: '',
    apeMaterno: '',
    givenName: '',
    apePaterno: '',
    cuentaBloqueda: false,
    tipoUsuario: '',
    cedula: '',
    roles: [],
  );

  factory Claims.fromJson(Map<String, dynamic> json) => Claims(
    rol: json['rol'] ?? '',
    negociosOperables: json['negociosOperables'] ?? '',
    idParticipante: json['idparticipante'] ?? '',
    mail: json['mail'] ?? '',
    apeMaterno: json['apematerno'] ?? '',
    givenName: json['givenname'] ?? '',
    apePaterno: json['apepaterno'] ?? '',
    cuentaBloqueda: json['cuentabloqueda'] ?? false,
    tipoUsuario: json['tipousuario'] ?? '',
    cedula: json['cedula'] ?? '',
    roles: List<String>.from(json['roles'] ?? []),
  );

  Map<String, dynamic> toJson() => {
    'rol': rol,
    'negociosOperables': negociosOperables,
    'idParticipante': idParticipante,
    'mail': mail,
    'apeMaterno': apeMaterno,
    'givenName': givenName,
    'apePaterno': apePaterno,
    'cuentaBloqueda': cuentaBloqueda,
    'tipoUsuario': tipoUsuario,
    'cedula': cedula,
  };

  final String rol;
  final String negociosOperables;
  final String idParticipante;
  final String mail;
  final String apeMaterno;
  final String givenName;
  final String apePaterno;
  final bool cuentaBloqueda;
  final String tipoUsuario;
  final String cedula;
  final List<String> roles;
}
