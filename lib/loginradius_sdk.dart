library loginradius_sdk;

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'src/models/error.dart';

export 'loginradius_sdk.dart';

class LoginRadiusSDK {
  LoginRadiusSDK({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();
  final ApiClient _apiClient;

  LoginRadiusSDK._privateConstructor({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  static final LoginRadiusSDK instance = LoginRadiusSDK._privateConstructor();

  late String _apiKey;
  late String _appName;
  String? _sott;
  String? _resetPasswordUrl;
  String? _verificationUrl;

  late bool _isInitialized = false;

  /// Initialize the SDK with your API Key and Secret.
  /// [apiKey] - LoginRadius API Key
  /// [apiSecret] - LoginRadius API Secret
  /// [debug] - Enable/Disable debug mode

  void init({
    required String apiKey,
    required String appName,
    String? sott,
    String? resetPasswordUrl,
    String? verificationUrl,
  }) {
    _apiKey = apiKey;
    _appName = appName;
    _sott = sott;
    _resetPasswordUrl = resetPasswordUrl;
    _verificationUrl = verificationUrl;
    debugPrint("Initializing LoginRadius SDK");
    debugPrint("API Key: $apiKey");
    debugPrint("APP Name: $appName");
    _isInitialized = true;
    debugPrint("Initialization complete");
  }

  /// Login by Email and Password
  /// [email] - Email of the user
  /// [password] - Password of the user
  /// [emailTemplate] - Email template name

  Future<dynamic> loginByEmail({
    required Map<String, dynamic> data,
    String? emailTemplate,
    String? recaptchaResponse,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Login by Email");
    await _apiClient.post(
      '/identity/v2/auth/login',
      data: data,
      params: {
        'apikey': _apiKey,
        'verificationurl': _verificationUrl,
        'emailtemplate': emailTemplate,
        'g-recaptcha-response': recaptchaResponse
      },
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// Register by Email and Password
  /// [email] - Email of the user
  /// [password] - Password of the user
  /// [onSuccess] - Callback function on success
  /// [onError] - Callback function on error

  Future<dynamic> registerbyEmail({
    required Map<String, dynamic> data,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
    String? emailType = 'Primary',
    String? emailTemplate,
    String? welcomeEmailTemplate,
  }) async {
    debugPrint("Register by Email");
    await _apiClient.post(
      '/identity/v2/auth/register',
      data: data,
      params: {
        'apikey': _apiKey,
        'verificationurl': _verificationUrl,
        'emailtemplate': emailTemplate,
        'welcomeemailtemplate': welcomeEmailTemplate,
      },
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }
}

class ApiClient {
  static const String _baseUrl = 'https://api.loginradius.com';
  final Dio _dio;

  ApiClient({
    Dio? dio, // if null, a new instance of Dio will be created
  }) : _dio = dio ?? Dio(BaseOptions(baseUrl: _baseUrl));

  Future<dynamic> get(
    String url, {
    required Map<String, dynamic>? params,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(dynamic) onError,
  }) async {
    try {
      Response response = await _dio.post(url, queryParameters: params);
      debugPrint("Response: ${response.data}");
      onSuccess(response.data);
      return response.data;
    } on DioError catch (e) {
      debugPrint("DioError: ${e.response!.data}");
      onError(LRError.fromJson(e.response!.data));
      return e.response!.data;
    }
  }

  Future<dynamic> post(
    String url, {
    required Map<String, dynamic>? data,
    required Map<String, dynamic>? params,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    try {
      Response response =
          await _dio.post(url, data: data, queryParameters: params);
      debugPrint("Response: ${response.data}");
      onSuccess(response.data);
      return response.data;
    } on DioError catch (e) {
      debugPrint("DioError: ${e.response!.data}");
      onError(LRError.fromJson(e.response!.data));
      return e.response!.data;
    }
  }

  Future<dynamic> put(
    String url, {
    required Map<String, dynamic>? data,
    required Map<String, dynamic>? params,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(dynamic) onError,
  }) async {
    try {
      Response response =
          await _dio.put(url, data: data, queryParameters: params);
      debugPrint("Response: ${response.data}");
      onSuccess(response.data);
      return response.data;
    } on DioError catch (e) {
      debugPrint("DioError: ${e.response!.data}");
      onError(LRError.fromJson(e.response!.data));
      return e.response!.data;
    }
  }

  Future<dynamic> delete(
    String url, {
    required Map<String, dynamic>? data,
    required Map<String, dynamic>? params,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(dynamic) onError,
  }) async {
    try {
      Response response =
          await _dio.delete(url, data: data, queryParameters: params);
      debugPrint("Response: ${response.data}");
      onSuccess(response.data);
      return response.data;
    } on DioError catch (e) {
      debugPrint("DioError: ${e.response!.data}");
      onError(LRError.fromJson(e.response!.data));
      return e.response!.data;
    }
  }
}
