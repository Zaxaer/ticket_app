import 'package:dio/dio.dart';

abstract class IApiClient {
  Future<Response>? get(String uri);
}

class ApiClient implements IApiClient {
  final _dio = Dio();

  @override
  Future<Response>? get(String uri) {
    try {
      final response = _dio.get(uri);
      return response;
    } catch (e) {
      return null;
    }
  }
}
