import 'package:storybook_gnp/shared/models/outgoing/login_response_model.dart';

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
