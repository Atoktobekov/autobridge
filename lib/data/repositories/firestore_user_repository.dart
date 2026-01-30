import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:autobridge/domain/entities/user_profile.dart';
import 'package:autobridge/domain/repositories/user_repository.dart';
import 'package:autobridge/data/models/user_profile_model.dart';

class FirestoreUserRepository implements UserRepository {
  FirestoreUserRepository({FirebaseFirestore? firestore})
      : _collection = (firestore ?? FirebaseFirestore.instance).collection('users');

  final CollectionReference<Map<String, dynamic>> _collection;

  @override
  Stream<UserProfile?> watchProfile(String userId) {
    return _collection.doc(userId).snapshots().map((doc) {
      if (!doc.exists) {
        return null;
      }
      return UserProfileModel.fromDoc(doc);
    });
  }

  @override
  Future<void> ensureUserProfile(UserProfile profile) async {
    final docRef = _collection.doc(profile.id);
    final snapshot = await docRef.get();
    if (snapshot.exists) {
      await docRef.set(
        {
          'email': profile.email,
          'updatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );
      return;
    }
    final model = UserProfileModel(
      id: profile.id,
      email: profile.email,
      role: profile.role,
    );
    await docRef.set(model.toMap(), SetOptions(merge: true));
  }
}
