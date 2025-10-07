class LoginResponse {
  final bool success;
  final String token;
  final Map<String, dynamic>? user;

  LoginResponse({required this.success, required this.token, this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(success: json['success'] ?? false,
        token: json["token"] ?? "",
        user: json['user']
    );
  }
}
