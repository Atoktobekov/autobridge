import '../entities/user_profile.dart';

abstract class UserRepository {
  Stream<UserProfile?> watchProfile(String userId);
  Future<void> ensureUserProfile(UserProfile profile);
}
