class AuthModel {
  final String token;
  final String expiresAt;
  final int expiresTimestamp;
  final int ttlMinutes; // in minutes

  const AuthModel({
    required this.token,
    required this.expiresAt,
    required this.expiresTimestamp,
    required this.ttlMinutes,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['token'] as String,
      expiresAt: json['expires_at'] as String,
      expiresTimestamp: json['expires_timestamp'] as int,
      ttlMinutes: json['ttl_minutes'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'expires_at': expiresAt,
      'expires_timestamp': expiresTimestamp,
      'ttl_minutes': ttlMinutes,
    };
  }
}
