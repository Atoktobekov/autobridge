import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/contact_request.dart';
import '../../domain/repositories/request_repository.dart';
import '../models/contact_request_model.dart';

class FirestoreRequestRepository implements RequestRepository {
  FirestoreRequestRepository({FirebaseFirestore? firestore})
      : _collection = (firestore ?? FirebaseFirestore.instance).collection('requests');

  final CollectionReference<Map<String, dynamic>> _collection;

  @override
  Future<void> submitRequest(ContactRequest request) async {
    final model = ContactRequestModel(
      id: request.id,
      fullName: request.fullName,
      phone: request.phone,
      comment: request.comment,
      budget: request.budget,
      preferredBrand: request.preferredBrand,
      preferredModel: request.preferredModel,
    );
    await _collection.add(model.toMap());
  }
}
