import 'package:hive/hive.dart';
import 'package:trip_xpense/data/models/staff_model.dart';

part 'login_model.g.dart';

@HiveType(typeId: 0)
class LoginResponse {
  @HiveField(0)
  final String username;

  @HiveField(1)
  final String token;

  LoginResponse({
    required this.username,
    required this.token,
  });

  // Menambahkan metode copyWith
  LoginResponse copyWith({
    String? username,
    String? token
  }) {
    return LoginResponse(
      username: username ?? this.username,
      token: token ?? this.token
    );
  }

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      username: json['Username'],
      token: json['Token']
    );
  }
}
