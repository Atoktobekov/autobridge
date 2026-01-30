import 'package:dio/dio.dart';
import 'package:talker_flutter/talker_flutter.dart';

class AppHttpClient {
  AppHttpClient({
    required Dio dio,
    Talker? talker,
  })  : _dio = dio,
        _talker = talker;

  final Dio _dio;
  final Talker? _talker;

  Future<void> preflightUrl(String url) async {
    try {
      await _dio.head(url);
      _talker?.info('HTTP preflight succeeded', {'url': url});
    } on DioException catch (error, stackTrace) {
      _talker?.warning('HTTP preflight failed', {'url': url, 'error': error.message});
      _talker?.handle(error, stackTrace);
    } catch (error, stackTrace) {
      _talker?.handle(error, stackTrace);
    }
  }
}
