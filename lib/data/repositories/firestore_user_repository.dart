import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:autobridge/domain/entities/user_profile.dart';
import 'package:autobridge/domain/repositories/user_repository.dart';
import 'package:autobridge/data/models/user_profile_model.dart';
import 'package:talker_flutter/talker_flutter.dart';

class FirestoreUserRepository implements UserRepository {
  FirestoreUserRepository({FirebaseFirestore? firestore, Talker? talker})
      : _collection = (firestore ?? FirebaseFirestore.instance).collection('users'),
        _talker = talker;

  final CollectionReference<Map<String, dynamic>> _collection;
  final Talker? _talker;

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
      _talker?.debug('Updated user profile', {'id': profile.id});
      return;
    }
    final model = UserProfileModel(
      id: profile.id,
      email: profile.email,
      role: profile.role,
    );
    await docRef.set(model.toMap(), SetOptions(merge: true));
    _talker?.info('Created user profile', {'id': profile.id});
  }
}
