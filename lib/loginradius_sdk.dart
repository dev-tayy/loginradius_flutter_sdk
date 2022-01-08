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
  String? _resetPasswordUrl;

  /// Initialize the SDK with your API Key and Secret.
  /// [apiKey] - LoginRadius API Key
  /// [apiSecret] - LoginRadius API Secret
  /// [debug] - Enable/Disable debug mode

  void init({
    required String apiKey,
    required String appName,
    required String? sott,
    String? resetPasswordUrl,
    String? verificationUrl,
  }) {
    _apiKey = apiKey;
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

  //<--POST REQUESTS-->

  /// Login by Email and Password
  /// [data] - Email and Password of the User required, Valid JSON object of Unique Security Question ID and Answer of set Security Question
  /// [emailTemplate] - Email template name (Optional)
  /// [loginUrl] - URL where the user is logging from (Optional)
  /// [g-recaptcha-response] - Google reCAPTCHA response (Optional)

  Future<dynamic> signInWithEmailAndPassword({
    required Map<String, dynamic> data,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
    String? emailTemplate,
    String? recaptchaResponse,
    String? loginUrl,
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
        'loginurl': loginUrl,
        'g-recaptcha-response': recaptchaResponse
      },
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// Login by Username and Password
  /// [data] - Username and Password of the User required, Valid JSON object of Unique Security Question ID and Answer of set Security Question
  /// [emailTemplate] - Email template name (Optional)
  /// [loginUrl] - URL where the user is logging from (Optional)
  /// [g-recaptcha-response] - Google reCAPTCHA response (Optional)

  Future<dynamic> signInWithUsernameAndPassword({
    required Map<String, dynamic> data,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
    String? emailTemplate,
    String? recaptchaResponse,
    String? loginUrl,
  }) async {
    debugPrint("Login by Username");
    await _apiClient.post(
      '/identity/v2/auth/login',
      data: data,
      params: {
        'apikey': _apiKey,
        'verificationurl': _verificationUrl,
        'emailtemplate': emailTemplate,
        'loginurl': loginUrl,
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

  Future<dynamic> signUpWithEmailAndPassword({
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

  /// This method is used to send the reset password url to a specified account. Note: If you have the UserName workflow enabled, you may replace the 'email' parameter with 'username'
  /// [onSuccess] - Callback function on success
  /// [onError] - Callback function on error
  /// [data] - Note: If you have the UserName workflow enabled, you may replace the 'email' parameter with 'username'
  /// [emailTemplate] - Email template name

  Future<dynamic> authForgotPassword({
    required Map<String, dynamic> data,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
    String? emailTemplate,
  }) async {
    debugPrint("Auth Forgot Password");
    await _apiClient.post(
      '/identity/v2/auth/password',
      data: data,
      params: {
        'apikey': _apiKey,
        'resetpasswordurl': _resetPasswordUrl,
        'emailTemplate': emailTemplate,
      },
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to add additional emails to a user's account.
  /// [onSuccess] - Callback function on success
  /// [onError] - Callback function on error
  /// [data] - Map of email and email type
  /// [emailTemplate] - Email template name
  /// [emailType] - Email type
  /// [accessToken] - Access Token of the User

  Future<dynamic> authAddEmail({
    required String accessToken,
    required String newEmail,
    required String newEmailType,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
    String? emailTemplate,
  }) async {
    debugPrint("Auth Add Email");
    await _apiClient.post(
      '/identity/v2/auth/email',
      accessToken: accessToken,
      data: {'email': newEmail, 'emailType': newEmailType},
      params: {
        'apikey': _apiKey,
        'verificationurl': _verificationUrl,
        'emailTemplate': emailTemplate,
      },
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  //<--GET REQUESTS-->

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

  /// This method validates access token, if valid then returns a response with its expiry otherwise error.
  /// [onSuccess] - Callback function on success
  /// [onError] - Callback function on error
  /// [accessToken] - Access Token of the User

  Future<dynamic> validateAccessToken({
    required String accessToken,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Validates Access Token");
    await _apiClient.get(
      '/identity/v2/auth/access_token/Validate',
      accessToken: accessToken,
      params: {'apikey': _apiKey},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to obtain information on the provided access_token.
  /// [onSuccess] - Callback function on success
  /// [onError] - Callback function on error
  /// [accessToken] - Access Token of the User

  Future<dynamic> accessTokenInfo({
    required String accessToken,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Auth Access Token Info");
    await _apiClient.get(
      '/identity/v2/auth/access_token',
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
  /// [preventRefresh] - Prevent refresh of access token (Optional)

  Future<dynamic> invalidateAccessToken({
    required String accessToken,
    bool? preventRefresh = true,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Invalidate Access Token");
    await _apiClient.get(
      '/identity/v2/auth/access_token/InValidate',
      accessToken: accessToken,
      params: {'apikey': _apiKey, 'preventRefresh ': preventRefresh},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to verify the email of the user. Note: This method will only return the full profile if you have 'Enable automatic login after email verification' enabled in your LoginRadius Admin Console's Js Widget settings under 'Deployment'.
  /// [onSuccess] - Callback function on success.
  /// [onError] - Callback function on error.
  /// [verificationToken] - Verification token received in the email.
  /// [welcomeEmailTemplate] - Email template name (Optional)
  /// [url] - Mention URL to log the main URL(Domain name) in Database. (Optional)

  Future<dynamic> verifyEmail({
    required String verificationToken,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
    String? welcomeEmailTemplate,
    String? url,
  }) async {
    debugPrint("Verify Email");
    await _apiClient.get(
      '/identity/v2/auth/email',
      params: {
        'apikey': _apiKey,
        'verificationtoken ': verificationToken,
        'welcomeemailtemplate': welcomeEmailTemplate,
        'url': url
      },
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to delete an account by passing it a delete token.
  /// [onSuccess] - Callback function on success.
  /// [onError] - Callback function on error.
  /// [deleteToken] - Delete token received in the email.

  Future<dynamic> deleteAccount({
    required String deleteToken,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Delete Account");
    await _apiClient.get(
      '/identity/v2/auth/account/delete',
      params: {'apikey': _apiKey, 'deletetoken ': deleteToken},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method checks if the email exists or not on your site..
  /// [onSuccess] - Callback function on success.
  /// [onError] - Callback function on error.
  /// [email] - Email of the user.

  Future<dynamic> checkEmailExists({
    required String email,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Check Email Availability");
    await _apiClient.get(
      '/identity/v2/auth/email',
      params: {'apikey': _apiKey, 'email ': email},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method checks if the username exists or not on your site.
  /// [onSuccess] - Callback function on success.
  /// [onError] - Callback function on error.
  /// [username] - Username of the user.

  Future<dynamic> checkusernameExists({
    required String username,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Check Username Availability");
    await _apiClient.get(
      '/identity/v2/auth/username',
      params: {'apikey': _apiKey, 'username ': username},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method updates the privacy policy stored in the user's profile by providing the access_token of the user accepting the privacy policy.
  /// [onSuccess] - Callback function on success.
  /// [onError] - Callback function on error.
  /// [accessToken] - Access Token of the User.

  Future<dynamic> acceptPrivacyPolicy({
    required String accessToken,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Auth Privacy Policy Accept");
    await _apiClient.get(
      '/identity/v2/auth/privacypolicy/accept',
      accessToken: accessToken,
      params: {'apikey': _apiKey},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method will return all the accepted privacy policies for the user by providing the access_token of that user.
  /// [onSuccess] - Callback function on success.
  /// [onError] - Callback function on error.
  /// [accessToken] - Access Token of the User.

  Future<dynamic> getPrivacyPolicyHistoryByAccessToken({
    required String accessToken,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Privacy Policy History by Access Token");
    await _apiClient.get(
      '/identity/v2/auth/privacypolicy/history',
      accessToken: accessToken,
      params: {'apikey': _apiKey},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method sends a welcome email to the user.
  /// [onSuccess] - Callback function on success.
  /// [onError] - Callback function on error.
  /// [accessToken] - Access Token of the User.
  /// [welcomeEmailTemplate] - Email Template to be used for sending the email.

  Future<dynamic> sendWelcomeEmail({
    required String accessToken,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
    String? welcomeEmailTemplate,
  }) async {
    debugPrint("Send Welcome Email");
    await _apiClient.get(
      '/identity/v2/auth/account/sendwelcomeemail',
      accessToken: accessToken,
      params: {'apikey': _apiKey, 'welcomeemailtemplate': welcomeEmailTemplate},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to retrieve the list of questions that are configured on the respective LoginRadius site.
  /// [onSuccess] - Callback function on success.
  /// [onError] - Callback function on error.
  /// [accessToken] - Access Token of the User.

  Future<dynamic> getSecurityQuestionByAccessToken({
    required String accessToken,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Get Security Questions By Access Token");
    await _apiClient.get(
      '/identity/v2/auth/securityquestion/accesstoken',
      accessToken: accessToken,
      params: {'apikey': _apiKey},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to retrieve the list of questions that are configured on the respective LoginRadius site.
  /// [onSuccess] - Callback function on success.
  /// [onError] - Callback function on error.
  /// [email] - Email of the User.

  Future<dynamic> getSecurityQuestionByEmail({
    required String email,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Get Security Questions By Email");
    await _apiClient.get(
      '/identity/v2/auth/securityquestion/email',
      params: {'apikey': _apiKey, 'email': email},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to retrieve the list of questions that are configured on the respective LoginRadius site.
  /// [onSuccess] - Callback function on success.
  /// [onError] - Callback function on error.
  /// [username] - Username of the User.

  Future<dynamic> getSecurityQuestionByUsername({
    required String username,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Get Security Questions By Username");
    await _apiClient.get(
      '/identity/v2/auth/securityquestion/username',
      params: {'apikey': _apiKey, 'username': username},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to retrieve the list of questions that are configured on the respective LoginRadius site.
  /// [onSuccess] - Callback function on success.
  /// [onError] - Callback function on error.
  /// [phone] - Phone number of the User.

  Future<dynamic> getSecurityQuestionByPhoneNumber({
    required String phoneNumber,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Get Security Questions By Phone number");
    await _apiClient.get(
      '/identity/v2/auth/securityquestion/phone',
      params: {'apikey': _apiKey, 'phone': phoneNumber},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  //<--PUT REQUESTS-->

  /// Updates the user's profile by passing the access_token.
  /// [onSuccess] - Callback function on success
  /// [onError] - Callback function on error
  /// [accessToken] - Access Token of the User
  /// [data] - User profile data
  /// [emailTemplate] - Email template name
  /// [smsTemplate] - SMS template name
  /// [nullSupport] - Nullify the user's profile

  Future<dynamic> updateUserProfileWithToken({
    required String accessToken,
    required Map<String, dynamic> data,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
    String? emailTemplate,
    String? smsTemplate,
    String? nullSupport,
  }) async {
    debugPrint("Update User Profile With Token");
    await _apiClient.put(
      '/identity/v2/auth/account',
      accessToken: accessToken,
      data: data,
      params: {
        'apikey': _apiKey,
        'verificationurl': _verificationUrl,
        'emailtemplate': emailTemplate,
        'smstemplate': smsTemplate,
        'nullsupport': nullSupport
      },
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// Update security questions by the access token.
  /// [onSuccess] - Callback function on success
  /// [onError] - Callback function on error
  /// [accessToken] - Access Token of the User
  /// [data] - Valid JSON object of Unique Security Question ID and Answer of set Security Question

  Future<dynamic> updateSecurityQuestionByAccessToken({
    required String accessToken,
    required Map<String, dynamic> data,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Update Security Question by Access token");
    await _apiClient.put(
      '/identity/v2/auth/account',
      accessToken: accessToken,
      data: data,
      params: {'apikey': _apiKey},
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
