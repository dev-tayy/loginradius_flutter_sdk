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
  late final String? _sott;
  String? _verificationUrl;

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
    _sott = sott;
    _verificationUrl = verificationUrl;
    debugPrint("Initializing LoginRadius SDK");
    debugPrint("API Key: $apiKey");
    debugPrint("APP Name: $appName");
    debugPrint("SOTT: $sott");
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
      sott: _sott,
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
      sott: _sott,
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

  /// Retrieves a copy of the user data based on the access_token.
  /// [onSuccess] - Callback function on success
  /// [onError] - Callback function on error
  /// [accessToken] - Access Token of the User

  Future<dynamic> getUserProfileData({
    required String accessToken,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Get User Profile Data");
    await _apiClient.get(
      '/identity/v2/auth/account',
      accessToken: accessToken,
      params: {'apikey': _apiKey},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// Invalidates a current Access Token.
  /// [onSuccess] - Callback function on success
  /// [onError] - Callback function on error
  /// [accessToken] - Access Token of the User

  Future<dynamic> invalidateAccessToken({
    required String accessToken,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Invalidate Access Token");
    await _apiClient.get(
      '/identity/v2/auth/access_token/InValidate',
      accessToken: accessToken,
      params: {'apikey': _apiKey, 'preventRefresh ': true},
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
            'Authorization': 'Bearer<ACCESS_TOKEN> $accessToken',
          }));
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
            'Authorization': 'Bearer<ACCESS_TOKEN> $accessToken',
          }));
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
    String? sott,
    String? accessToken,
    required Map<String, dynamic>? data,
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
            'Authorization': 'Bearer<ACCESS_TOKEN> $accessToken',
          }));
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
