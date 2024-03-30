class StaffEntity {
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

  StaffEntity({
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
}
