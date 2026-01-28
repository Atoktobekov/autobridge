class UserProfile {
  UserProfile({
    required this.id,
    required this.email,
    required this.role,
  });

  final String id;
  final String email;
  final String role;

  bool get isAdmin => role == 'admin';
}
