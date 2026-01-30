import 'package:autobridge/domain/entities/contact_request.dart';

abstract class RequestRepository {
  Future<void> submitRequest(ContactRequest request);
}
