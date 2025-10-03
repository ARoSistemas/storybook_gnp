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
    token: json['token'] ?? Token.empty(),
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

  factory LoginMdl.hardCode() => LoginMdl.fromMap(jsonDecode(rHardCode));

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
  final String uid;
  final bool banVerConvenio;
  final bool banDescargaConvenio;
  final bool banVerAviso;
  final bool banConvenioActualizado;

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

  factory Token.empty() => Token(jwt: '', refreshtoken: '');

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
