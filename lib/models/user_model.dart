/// User model
class User {
  final String email;
  final String fullName;
  final String role;

  User({
    required this.email,
    required this.fullName,
    required this.role,
  });

  bool get isAdmin => role == 'ADMIN';
}

/// Auth Response from API
class AuthResponse {
  final String token;
  final String type;
  final String email;
  final String fullName;
  final String role;

  AuthResponse({
    required this.token,
    required this.type,
    required this.email,
    required this.fullName,
    required this.role,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'] ?? '',
      type: json['type'] ?? 'Bearer',
      email: json['email'] ?? '',
      fullName: json['fullName'] ?? '',
      role: json['role'] ?? 'USER',
    );
  }

  User toUser() {
    return User(
      email: email,
      fullName: fullName,
      role: role,
    );
  }
}
