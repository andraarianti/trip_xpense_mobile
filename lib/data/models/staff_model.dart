class StaffModel {
  final int staffID;
  final String name;
  final int positionID;
  final String role;
  final DateTime? lastModified;
  final bool isDeleted;
  final String username;
  final String password;
  final String email;
  final DateTime? lastLogin;
  final int maxAttempt;
  final bool isLocked;

  StaffModel({
    required this.staffID,
    required this.name,
    required this.positionID,
    required this.role,
    this.lastModified,
    required this.isDeleted,
    required this.username,
    required this.password,
    required this.email,
    this.lastLogin,
    required this.maxAttempt,
    required this.isLocked,
  });

  factory StaffModel.fromJson(Map<String, dynamic> json) {
    return StaffModel(
      staffID: json['StaffID'],
      name: json['Name'],
      positionID: json['PositionID'],
      role: json['Role'],
      lastModified: json['LastModified'] != null ? DateTime.parse(json['LastModified']) : null,
      isDeleted: json['IsDeleted'],
      username: json['Username'],
      password: json['Password'],
      email: json['Email'],
      lastLogin: json['LastLogin'] != null ? DateTime.parse(json['LastLogin']) : null,
      maxAttempt: json['MaxAttempt'],
      isLocked: json['IsLocked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'StaffID': staffID,
      'Name': name,
      'PositionID': positionID,
      'Role': role,
      'LastModified': lastModified?.toIso8601String(),
      'IsDeleted': isDeleted,
      'Username': username,
      'Password': password,
      'Email': email,
      'LastLogin': lastLogin?.toIso8601String(),
      'MaxAttempt': maxAttempt,
      'IsLocked': isLocked,
    };
  }
}
