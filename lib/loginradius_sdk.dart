library loginradius_sdk;

import 'package:flutter/cupertino.dart';

export 'loginradius_sdk.dart';
export 'src/apis/authentication.dart';

class LoginRadiusSDK {
  LoginRadiusSDK._privateConstructor();

  static final LoginRadiusSDK instance = LoginRadiusSDK._privateConstructor();

  String? _apiKey;
  String? _appName;
  String? _sott;
  String? _verificationUrl;
  String? _resetPasswordUrl;

  /// Initialize the SDK with your API Key, AppName, SOTT, VerificationURL, ResetPasswordURL.
  ///
  /// [apiKey] - LoginRadius API Key
  ///
  /// [appName] - LoginRadius App Name
  ///
  /// [sott] - LoginRadius SOTT
  ///
  /// [verificationUrl] - LoginRadius Verification URL
  ///
  /// [resetPasswordUrl] - LoginRadius Reset Password URL
  ///

  void init({
    required String apiKey,
    required String appName,
    required String? sott,
    String? resetPasswordUrl,
    String? verificationUrl,
  }) {
    _apiKey = apiKey;
    _appName = appName;
    _sott = sott;
    _verificationUrl = verificationUrl;
    _resetPasswordUrl = resetPasswordUrl;
    debugPrint("Initializing LoginRadius SDK");
    debugPrint("API Key: $apiKey");
    debugPrint("APP Name: $appName");
    debugPrint("SOTT: $sott");
    debugPrint("RESET_PASSWORD_URL: $resetPasswordUrl");
    debugPrint("VERIFICATION_URL: $verificationUrl");
    debugPrint("Initialization complete");
  }

  String? get apiKey => instance._apiKey;
  String? get appName => instance._appName;
  String? get sott => instance._sott;
  String? get verificationUrl => instance._verificationUrl;
  String? get resetPasswordUrl => instance._resetPasswordUrl;
}
