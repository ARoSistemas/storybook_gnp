class LoginResponse {
  LoginResponse({
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    token: json['token'] as String,
    // user: User.fromJson(json['user']),
  );

  final String token;
}
