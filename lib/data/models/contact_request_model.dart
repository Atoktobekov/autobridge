import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/contact_request.dart';

class ContactRequestModel extends ContactRequest {
  ContactRequestModel({
    required super.id,
    required super.fullName,
    required super.phone,
    required super.comment,
    required super.budget,
    required super.preferredBrand,
    required super.preferredModel,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'phone': phone,
      'comment': comment,
      'budget': budget,
      'preferredBrand': preferredBrand,
      'preferredModel': preferredModel,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
