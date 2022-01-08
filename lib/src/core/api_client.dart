import 'package:dio/dio.dart';
import 'package:loginradius_sdk/src/models/error.dart';

class ApiClient {
  static const String _baseUrl = 'https://api.loginradius.com';
  final Dio _dio;

  ApiClient({
    Dio? dio, // if null, a new instance of Dio will be created
  }) : _dio = dio ?? Dio(BaseOptions(baseUrl: _baseUrl));

  Future<dynamic> get(
    String url, {
    String? sott,
    String? accessToken,
    required Map<String, dynamic>? params,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(dynamic) onError,
  }) async {
    try {
      Response response = await _dio.get(url,
          queryParameters: params,
          options: Options(headers: {
            'X-LoginRadius-Sott': sott,
            'Authorization': 'Bearer $accessToken',
          }));

      onSuccess(response.data);
      return response.data;
    } on DioError catch (e) {
      onError(LRError.fromJson(e.response!.data));
      return e.response!.data;
    }
  }

  Future<dynamic> post(
    String url, {
    String? sott,
    String? accessToken,
    required Map<String, dynamic>? data,
    required Map<String, dynamic>? params,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    try {
      Response response = await _dio.post(url,
          data: data,
          queryParameters: params,
          options: Options(headers: {
            'X-LoginRadius-Sott': sott,
            'Authorization': 'Bearer $accessToken',
          }));

      onSuccess(response.data);
      return response.data;
    } on DioError catch (e) {
      onError(LRError.fromJson(e.response!.data));
      return e.response!.data;
    }
  }

  Future<dynamic> put(
    String url, {
    String? sott,
    String? accessToken,
    required Map<String, dynamic>? data,
    required Map<String, dynamic>? params,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(dynamic) onError,
  }) async {
    try {
      Response response = await _dio.put(url,
          data: data,
          queryParameters: params,
          options: Options(headers: {
            'X-LoginRadius-Sott': sott,
            'Authorization': 'Bearer $accessToken',
          }));

      onSuccess(response.data);
      return response.data;
    } on DioError catch (e) {
      onError(LRError.fromJson(e.response!.data));
      return e.response!.data;
    }
  }

  Future<dynamic> delete(
    String url, {
    String? sott,
    String? accessToken,
    Map<String, dynamic>? data,
    required Map<String, dynamic>? params,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(dynamic) onError,
  }) async {
    try {
      Response response = await _dio.delete(url,
          data: data,
          queryParameters: params,
          options: Options(headers: {
            'X-LoginRadius-Sott': sott,
            'Authorization': 'Bearer $accessToken',
          }));

      onSuccess(response.data);
      return response.data;
    } on DioError catch (e) {
      onError(LRError.fromJson(e.response!.data));
      return e.response!.data;
    }
  }
}
