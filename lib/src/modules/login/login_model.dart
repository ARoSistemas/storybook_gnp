part of 'login_controller.dart';

/// Login Model
/// Represents the response from the login API.
/// Includes methods for JSON serialization and deserialization.
final class _LoginModel {
  _LoginModel({
    required this.code,
    required this.message,
    required this.payload,
    required this.name,
  });

  factory _LoginModel.fromRaw(String raw) =>
      _LoginModel.fromMap(json.decode(raw));

  factory _LoginModel.fromMap(Map<String, dynamic> json) => _LoginModel(
    name: 'Login',
    code: json['code'] ?? 0,
    message: json['message'] ?? '',
    payload: json['payload'] != null
        ? UserModel.fromMap(json['payload'])
        : UserModel.empty(),
  );

  factory _LoginModel.empty() => _LoginModel(
    name: 'Login',
    code: 0,
    message: '',
    payload: UserModel.empty(),
  );

  factory _LoginModel.hardCode() => _LoginModel.fromMap(jsonDecode(rHardCode));

  _LoginModel copyWith({
    String? name,
    int? code,
    String? message,
    UserModel? payload,
  }) => _LoginModel(
    name: name ?? this.name,
    code: code ?? this.code,
    message: message ?? this.message,
    payload: payload ?? this.payload,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'code': code,
    'message': message,
    'payload': payload.toJson(),
  };

  final String name;
  final int code;
  final String message;
  final UserModel payload;

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

  /// EndClass
}
