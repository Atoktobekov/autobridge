import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:talker/talker.dart';

import '../../core/config/app_config.dart';
import '../../domain/entities/contact_request.dart';
import '../../domain/repositories/request_repository.dart';
import '../models/contact_request_model.dart';

class FirestoreRequestRepository implements RequestRepository {
  FirestoreRequestRepository({
    FirebaseFirestore? firestore,
    Dio? dio,
    Talker? talker,
  })  : _collection = (firestore ?? FirebaseFirestore.instance).collection('requests'),
        _dio = dio ?? Dio(),
        _talker = talker ?? Talker();

  final CollectionReference<Map<String, dynamic>> _collection;
  final Dio _dio;
  final Talker _talker;

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
    final payload = model.toMap();
    await _collection.add(payload);
    final webhookUrl = AppConfig.requestWebhookUrl;
    if (webhookUrl.isNotEmpty) {
      try {
        await _dio.post(webhookUrl, data: payload);
      } catch (error, stackTrace) {
        _talker.warning('Webhook request failed', error, stackTrace);
      }
    }
  }
}
