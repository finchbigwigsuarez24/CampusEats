
class AppUser {
  final String uid;
  final String fullName;
  final String email;
  final String role;
  final String accountType;
  final bool isActive;

  const AppUser({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.role,
    required this.accountType,
    required this.isActive,
  });

  factory AppUser.fromMap(
    String uid,
    Map<String, dynamic> data,
  ) {
    return AppUser(
      uid: uid,
      fullName: data['fullName'] ?? 'CampusEats User',
      email: data['email'] ?? '',
      role: data['role'] ?? '',
      accountType: data['accountType'] ?? '',
      isActive: data['isActive'] == true,
    );
  }
}
