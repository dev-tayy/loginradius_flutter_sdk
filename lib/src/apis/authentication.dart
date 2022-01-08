import 'package:flutter/foundation.dart';
import 'package:loginradius_sdk/loginradius_sdk.dart';
import 'package:loginradius_sdk/src/core/api_client.dart';
import 'package:loginradius_sdk/src/models/error.dart';

class LRAuthenticationApi {
  LRAuthenticationApi({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();
  final ApiClient _apiClient;

  final LoginRadiusSDK _loginRadiusSDK = LoginRadiusSDK.instance;

  //<--POST REQUESTS-->

  /// Login by Email and Password
  ///
  /// [data] - Email and Password of the User required, Valid JSON object of Unique Security Question ID and Answer of set Security Question
  ///
  /// [emailTemplate] - Email template name (Optional)
  ///
  /// [loginUrl] - URL where the user is logging from (Optional)
  ///
  /// [g-recaptcha-response] - Google reCAPTCHA response (Optional)
  ///

  Future<dynamic> signInWithEmailAndPassword({
    required Map<String, dynamic> data,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
    String? emailTemplate,
    String? recaptchaResponse,
    String? loginUrl,
  }) async {
    debugPrint("Login by Email");
    debugPrint('apiiiiiiiiii ${_loginRadiusSDK.apiKey}');
    debugPrint(_loginRadiusSDK.appName);
    debugPrint(_loginRadiusSDK.sott);
    debugPrint(_loginRadiusSDK.verificationUrl);
    debugPrint(_loginRadiusSDK.resetPasswordUrl);
    await _apiClient.post(
      '/identity/v2/auth/login',
      data: data,
      sott: _loginRadiusSDK.sott,
      params: {
        'apikey': _loginRadiusSDK.apiKey,
        'verificationurl': _loginRadiusSDK.verificationUrl,
        'emailtemplate': emailTemplate,
        'loginurl': loginUrl,
        'g-recaptcha-response': recaptchaResponse
      },
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// Login by Username and Password
  ///
  /// [data] - Username and Password of the User required, Valid JSON object of Unique Security Question ID and Answer of set Security Question
  ///
  /// [emailTemplate] - Email template name (Optional)
  ///
  /// [loginUrl] - URL where the user is logging from (Optional)
  ///
  /// [g-recaptcha-response] - Google reCAPTCHA response (Optional)
  ///

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
        'apikey': _loginRadiusSDK.apiKey,
        'verificationurl': _loginRadiusSDK.verificationUrl,
        'emailtemplate': emailTemplate,
        'loginurl': loginUrl,
        'g-recaptcha-response': recaptchaResponse
      },
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// Register by Email and Password
  ///
  /// [data] - User data required
  ///
  /// [onSuccess] - Callback function on success
  ///
  /// [onError] - Callback function on error
  ///

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
      sott: _loginRadiusSDK.sott,
      data: data,
      params: {
        'apikey': _loginRadiusSDK.apiKey,
        'verificationurl': _loginRadiusSDK.verificationUrl,
        'emailtemplate': emailTemplate,
        'welcomeemailtemplate': welcomeEmailTemplate,
      },
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to send the reset password url to a specified account. Note: If you have the UserName workflow enabled, you may replace the 'email' parameter with 'username'
  ///
  /// [onSuccess] - Callback function on success
  ///
  /// [onError] - Callback function on error
  ///
  /// [data] - Note: If you have the UserName workflow enabled, you may replace the 'email' parameter with 'username'
  ///
  /// [emailTemplate] - Email template name
  ///

  Future<dynamic> forgotPassword({
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
        'apikey': _loginRadiusSDK.apiKey,
        'resetpasswordurl': _loginRadiusSDK.resetPasswordUrl,
        'emailtemplate': emailTemplate,
      },
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to add additional emails to a user's account.
  ///
  /// [onSuccess] - Callback function on success
  ///
  /// [onError] - Callback function on error
  ///
  /// [data] - Map of new email and email type
  ///
  /// [emailTemplate] - Email template name
  ///
  /// [emailType] - Email type
  ///
  /// [accessToken] - Access Token of the User

  Future<dynamic> addEmail({
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
        'apikey': _loginRadiusSDK.apiKey,
        'verificationurl': _loginRadiusSDK.verificationUrl,
        'emailtemplate': emailTemplate,
      },
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method  creates a user in the database using ReCaptcha.
  ///
  /// [onSuccess] - Callback function on success
  ///
  /// [onError] - Callback function on error
  ///
  /// [data] - User data required
  ///
  /// [emailTemplate] - Email template name
  ///
  /// [welcomeEmailTemplate] - Welcome email template name
  ///
  /// [smsTemplate] - SMS template name
  ///
  /// [options] - PreventVerificationEmail (Specifying this value prevents the verification email from being sent. Only applicable if you have the optional email verification flow)

  Future<dynamic> signUpByReCaptcha({
    required Map<String, dynamic> data,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
    String? emailTemplate,
    String? welcomeEmailTemplate,
    String? smsTemplate,
    String? options,
  }) async {
    debugPrint("Auth User Registration by ReCaptcha");
    await _apiClient.post(
      '/identity/v2/auth/register/captcha',
      data: data,
      params: {
        'apikey': _loginRadiusSDK.apiKey,
        'verificationurl': _loginRadiusSDK.verificationUrl,
        'emailtemplate': emailTemplate,
        'smstemplate': smsTemplate,
        'welcomeemailtemplate': welcomeEmailTemplate,
        'options': options,
      },
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method  is used to link up a social provider account with an existing LoginRadius account on the basis of access token and the social providers user access token.
  ///
  /// [onSuccess] - Callback function on success
  ///
  /// [onError] - Callback function on error
  ///
  /// [candidateToken] - Access token of the account to be linked
  ///
  /// [accessToken] - Access Token of the User

  Future<dynamic> linkSocialIdentity({
    required String? candidateToken,
    required String? accessToken,
    required Map<String, dynamic>? data,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Auth Link Social Identity");
    await _apiClient.post(
      '/identity/v2/auth/socialidentity',
      data: {
        'candidatetoken': candidateToken,
      },
      accessToken: accessToken,
      params: {'apikey': _loginRadiusSDK.apiKey},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  //<--GET REQUESTS-->

  /// Retrieves a copy of the user data based on the access_token.
  ///
  /// [onSuccess] - Callback function on success
  ///
  /// [onError] - Callback function on error
  ///
  /// [accessToken] - Access Token of the User
  ///

  Future<dynamic> getUserProfileData({
    required String accessToken,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Get User Profile Data");
    await _apiClient.get(
      '/identity/v2/auth/account',
      accessToken: accessToken,
      params: {'apikey': _loginRadiusSDK.apiKey},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method validates access token, if valid then returns a response with its expiry otherwise error.
  ///
  /// [onSuccess] - Callback function on success
  ///
  /// [onError] - Callback function on error
  ///
  /// [accessToken] - Access Token of the User
  ///

  Future<dynamic> validateAccessToken({
    required String accessToken,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Validates Access Token");
    await _apiClient.get(
      '/identity/v2/auth/access_token/Validate',
      accessToken: accessToken,
      params: {'apikey': _loginRadiusSDK.apiKey},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to obtain information on the provided access_token.
  ///
  /// [onSuccess] - Callback function on success
  ///
  /// [onError] - Callback function on error
  ///
  /// [accessToken] - Access Token of the User
  ///

  Future<dynamic> getAccessTokenInfo({
    required String accessToken,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Auth Access Token Info");
    await _apiClient.get(
      '/identity/v2/auth/access_token',
      accessToken: accessToken,
      params: {'apikey': _loginRadiusSDK.apiKey},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method invalidates a current Access Token.
  ///
  /// [onSuccess] - Callback function on success
  ///
  /// [onError] - Callback function on error
  ///
  /// [accessToken] - Access Token of the User
  ///
  /// [preventRefresh] - Prevent refresh of access token (Optional)
  ///

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
      params: {
        'apikey': _loginRadiusSDK.apiKey,
        'preventRefresh ': preventRefresh
      },
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to verify the email of the user. Note: This method will only return the full profile if you have 'Enable automatic login after email verification' enabled in your LoginRadius Admin Console's Js Widget settings under 'Deployment'.
  /// [onSuccess] - Callback function on success.
  ///
  /// [onError] - Callback function on error.
  ///
  /// [verificationToken] - Verification token received in the email.
  ///
  /// [welcomeEmailTemplate] - Email template name (Optional)
  ///
  /// [url] - Mention URL to log the main URL(Domain name) in Database. (Optional)
  ///

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
        'apikey': _loginRadiusSDK.apiKey,
        'verificationtoken ': verificationToken,
        'welcomeemailtemplate': welcomeEmailTemplate,
        'url': url
      },
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to delete an account by passing it a delete token.
  ///
  /// [onSuccess] - Callback function on success.
  ///
  /// [onError] - Callback function on error.
  ///
  /// [deleteToken] - Delete token received in the email.
  ///

  Future<dynamic> deleteAccountByToken({
    required String deleteToken,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Delete Account By Token");
    await _apiClient.get(
      '/identity/v2/auth/account/delete',
      params: {'apikey': _loginRadiusSDK.apiKey, 'deletetoken ': deleteToken},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method checks if the email exists or not on your site.
  ///
  /// [onSuccess] - Callback function on success.
  ///
  /// [onError] - Callback function on error.
  ///
  /// [email] - Email of the user.
  ///

  Future<dynamic> checkEmailExists({
    required String email,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Check Email Availability");
    await _apiClient.get(
      '/identity/v2/auth/email',
      params: {'apikey': _loginRadiusSDK.apiKey, 'email ': email},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method checks if the username exists or not on your site.
  ///
  /// [onSuccess] - Callback function on success.
  ///
  /// [onError] - Callback function on error.
  ///
  /// [username] - Username of the user.
  ///

  Future<dynamic> checkusernameExists({
    required String username,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Check Username Availability");
    await _apiClient.get(
      '/identity/v2/auth/username',
      params: {'apikey': _loginRadiusSDK.apiKey, 'username ': username},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method updates the privacy policy stored in the user's profile by providing the access_token of the user accepting the privacy policy.
  ///
  /// [onSuccess] - Callback function on success.
  ///
  /// [onError] - Callback function on error.
  ///
  /// [accessToken] - Access Token of the User.
  ///

  Future<dynamic> acceptPrivacyPolicy({
    required String accessToken,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Auth Privacy Policy Accept");
    await _apiClient.get(
      '/identity/v2/auth/privacypolicy/accept',
      accessToken: accessToken,
      params: {'apikey': _loginRadiusSDK.apiKey},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method will return all the accepted privacy policies for the user by providing the access_token of that user.
  ///
  /// [onSuccess] - Callback function on success.
  ///
  /// [onError] - Callback function on error.
  ///
  /// [accessToken] - Access Token of the User.
  ///

  Future<dynamic> getPrivacyPolicyHistoryByAccessToken({
    required String accessToken,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Privacy Policy History by Access Token");
    await _apiClient.get(
      '/identity/v2/auth/privacypolicy/history',
      accessToken: accessToken,
      params: {'apikey': _loginRadiusSDK.apiKey},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method sends a welcome email to the user.
  ///
  /// [onSuccess] - Callback function on success.
  ///
  /// [onError] - Callback function on error.
  ///
  /// [accessToken] - Access Token of the User.
  ///
  /// [welcomeEmailTemplate] - Email Template to be used for sending the email.
  ///

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
      params: {
        'apikey': _loginRadiusSDK.apiKey,
        'welcomeemailtemplate': welcomeEmailTemplate
      },
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to retrieve the list of questions that are configured on the respective LoginRadius site.
  ///
  /// [onSuccess] - Callback function on success.
  ///
  /// [onError] - Callback function on error.
  ///
  /// [accessToken] - Access Token of the User.
  ///

  Future<dynamic> getSecurityQuestionByAccessToken({
    required String accessToken,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Get Security Questions By Access Token");
    await _apiClient.get(
      '/identity/v2/auth/securityquestion/accesstoken',
      accessToken: accessToken,
      params: {'apikey': _loginRadiusSDK.apiKey},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to retrieve the list of questions that are configured on the respective LoginRadius site.
  ///
  /// [onSuccess] - Callback function on success.
  ///
  /// [onError] - Callback function on error.
  ///
  /// [email] - Email of the User.
  ///

  Future<dynamic> getSecurityQuestionByEmail({
    required String email,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Get Security Questions By Email");
    await _apiClient.get(
      '/identity/v2/auth/securityquestion/email',
      params: {'apikey': _loginRadiusSDK.apiKey, 'email': email},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to retrieve the list of questions that are configured on the respective LoginRadius site.
  ///
  /// [onSuccess] - Callback function on success.
  ///
  /// [onError] - Callback function on error.
  ///
  /// [username] - Username of the User.
  ///

  Future<dynamic> getSecurityQuestionByUsername({
    required String username,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Get Security Questions By Username");
    await _apiClient.get(
      '/identity/v2/auth/securityquestion/username',
      params: {'apikey': _loginRadiusSDK.apiKey, 'username': username},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to retrieve the list of questions that are configured on the respective LoginRadius site.
  ///
  /// [onSuccess] - Callback function on success.
  ///
  /// [onError] - Callback function on error.
  ///
  /// [phone] - Phone number of the User.
  ///

  Future<dynamic> getSecurityQuestionByPhoneNumber({
    required String phoneNumber,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Get Security Questions By Phone number");
    await _apiClient.get(
      '/identity/v2/auth/securityquestion/phone',
      params: {'apikey': _loginRadiusSDK.apiKey, 'phone': phoneNumber},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  //<--PUT REQUESTS-->

  /// This method is used to verify the email of user when the OTP Email verification flow is enabled, please note that you must contact LoginRadius to have this feature enabled.
  ///
  /// [onSuccess] - Callback function on success
  ///
  /// [onError] - Callback function on error
  ///
  /// [data] - User data object. ('email' and 'otp' required).
  ///
  /// [welcomeEmailTemplate] - Email template name
  ///
  ///[url] - Mention URL to log the main URL(Domain name) in Database.

  Future<dynamic> verifyEmailByOTP({
    required Map<String, dynamic> data,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
    String? welcomeEmailTemplate,
    String? url,
  }) async {
    debugPrint("Verify Email with OTP");
    await _apiClient.put(
      '/identity/v2/auth/email',
      data: data,
      params: {
        'apikey': _loginRadiusSDK.apiKey,
        'url': url,
        'welcomeemailtemplate': welcomeEmailTemplate,
      },
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to change the accounts password based on the previous password.
  ///
  /// [accessToken] - Access Token of the User.
  ///
  /// [oldPassword] - Current Password of the User.
  ///
  /// [newPassword] - New Password of the User.
  ///
  /// [onSuccess] - Callback function on success
  ///
  /// [onError] - Callback function on error

  Future<dynamic> changePassword({
    required String oldPassword,
    required String newPassword,
    required String accessToken,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Auth Change Passsword");
    await _apiClient.put(
      '/identity/v2/auth/password/change',
      data: {
        'oldpassword': oldPassword,
        'newpassword': newPassword,
      },
      params: {
        'apikey': _loginRadiusSDK.apiKey,
      },
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method resends the verification email to the user.
  ///
  /// [email] - Email of the User.
  ///
  /// [emailTemplate] - Email template name
  ///
  /// [onSuccess] - Callback function on success
  ///
  /// [onError] - Callback function on error

  Future<dynamic> resendMailVerification({
    required String email,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
    String? emailTemplate,
  }) async {
    debugPrint("Auth Resend Email Verification");
    await _apiClient.put(
      '/identity/v2/auth/register',
      data: {'email': email},
      params: {
        'apikey': _loginRadiusSDK.apiKey,
        'verificationurl': _loginRadiusSDK.verificationUrl,
        'emailtemplate': emailTemplate,
      },
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to set a new password for the specified account.
  ///
  /// [resetToken] - Reset token received in the email
  ///
  /// [password] - New password for the account
  ///
  /// [welcomeEmailTemplate] - Email template name
  ///
  /// [resetPasswordEmailTemplate] - Reset password email template name
  ///
  /// [onSuccess] - Callback function on success
  ///
  /// [onError] - Callback function on error

  Future<dynamic> resetPasswordByToken({
    required String? resetToken,
    required String? newPassword,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
    String? welcomeEmailTemplate,
    String? resetPasswordEmailTemplate,
  }) async {
    debugPrint("Auth Reset Password by Reset Token");
    await _apiClient.put(
      '/identity/v2/auth/password/reset',
      data: {
        'resettoken': resetToken,
        'password': newPassword,
        'welcomeemailtemplate': welcomeEmailTemplate,
        "resetpasswordemailtemplate": resetPasswordEmailTemplate,
      },
      params: {'apikey': _loginRadiusSDK.apiKey},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to set a new password for the specified account.
  ///
  /// [email] - User's Email.
  ///
  /// [otp] - One-time passcode sent to user's Email
  ///
  /// [password] - New password for the account
  ///
  /// [welcomeEmailTemplate] - Email template name
  ///
  /// [resetPasswordEmailTemplate] - Reset password email template name
  ///
  /// [onSuccess] - Callback function on success
  ///
  /// [onError] - Callback function on error
  //TODO: Issue with the API endpoint, requesting for resettoken when it isn't specified in the body of the endpoint.
  Future<dynamic> resetPasswordByOTP({
    required String? email,
    required String? otp,
    required String? newPassword,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
    String? welcomeEmailTemplate,
    String? resetPasswordEmailTemplate,
  }) async {
    debugPrint("Auth Reset Password by OTP");
    await _apiClient.put(
      '/identity/v2/auth/password/reset',
      data: {
        'Otp': otp,
        'Email': email,
        'password': newPassword,
        'welcomeemailtemplate': welcomeEmailTemplate,
        "resetpasswordemailtemplate": resetPasswordEmailTemplate,
      },
      params: {'apikey': _loginRadiusSDK.apiKey},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to reset password for the specified account by security question.
  ///
  /// [email] - User's Email.
  ///
  /// [securityAnswer] - Valid JSON object of Unique Security Question ID and Answer of set Security Question
  ///
  /// [password] - New password for the account
  ///
  /// [resetPasswordEmailTemplate] - Reset password email template name
  ///
  /// [onSuccess] - Callback function on success
  ///
  /// [onError] - Callback function on error

  Future<dynamic> resetPasswordBySecurityAnswerandEmail({
    required String? email,
    required String? newPassword,
    required Map<String, dynamic>? securityAnswer,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
    String? resetPasswordEmailTemplate,
  }) async {
    debugPrint("Auth Reset Password by Security Answer and Email");
    await _apiClient.put(
      '/identity/v2/auth/password/securityanswer',
      data: {
        'email': email,
        'password': newPassword,
        'securityanswer': securityAnswer,
        "resetpasswordemailtemplate": resetPasswordEmailTemplate,
      },
      params: {'apikey': _loginRadiusSDK.apiKey},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to reset password for the specified account by security question.
  ///
  /// [phone] - User's phone number.
  ///
  /// [securityAnswer] - Valid JSON object of Unique Security Question ID and Answer of set Security Question
  ///
  /// [password] - New password for the account
  ///
  /// [resetPasswordEmailTemplate] - Reset password email template name
  ///
  /// [onSuccess] - Callback function on success
  ///
  /// [onError] - Callback function on error

  Future<dynamic> resetPasswordBySecurityAnswerandPhone({
    required String? phone,
    required String? newPassword,
    required Map<String, dynamic>? securityAnswer,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
    String? resetPasswordEmailTemplate,
  }) async {
    debugPrint("Auth Reset Password by Security Answer and Phone");
    await _apiClient.put(
      '/identity/v2/auth/password/securityanswer',
      data: {
        'phone': phone,
        'password': newPassword,
        'securityanswer': securityAnswer,
        "resetpasswordemailtemplate": resetPasswordEmailTemplate,
      },
      params: {'apikey': _loginRadiusSDK.apiKey},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to reset password for the specified account by security question.
  ///
  /// [username] - User's username.
  ///
  /// [securityAnswer] - Valid JSON object of Unique Security Question ID and Answer of set Security Question
  ///
  /// [password] - New password for the account
  ///
  /// [resetPasswordEmailTemplate] - Reset password email template name
  ///
  /// [onSuccess] - Callback function on success
  ///
  /// [onError] - Callback function on error

  Future<dynamic> resetPasswordBySecurityAnswerandUsername({
    required String? username,
    required String? newPassword,
    required Map<String, dynamic>? securityAnswer,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
    String? resetPasswordEmailTemplate,
  }) async {
    debugPrint("Auth Reset Password by Security Answer and Username");
    await _apiClient.put(
      '/identity/v2/auth/password/securityanswer',
      data: {
        'username': username,
        'password': newPassword,
        'securityanswer': securityAnswer,
        "resetpasswordemailtemplate": resetPasswordEmailTemplate,
      },
      params: {'apikey': _loginRadiusSDK.apiKey},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method  is used to set a new password for the specified account if you are using the username as the unique identifier in your workflow.
  ///
  /// [username] - User's username.
  ///
  /// [otp] - One-time passcode sent to user's Email
  ///
  /// [password] - New password for the account
  ///
  /// [welcomeEmailTemplate] - Email template name
  ///
  /// [resetPasswordEmailTemplate] - Reset password email template name
  ///
  /// [onSuccess] - Callback function on success
  ///
  /// [onError] - Callback function on error
  //TODO: Issue with the API, requesting for resettoken when it isn't specified in the API.
  Future<dynamic> resetPasswordByOTPandUsername({
    required String? username,
    required String? otp,
    required String? newPassword,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
    String? welcomeEmailTemplate,
    String? resetPasswordEmailTemplate,
  }) async {
    debugPrint("Auth Reset Password by OTP and Username");
    await _apiClient.put(
      '/identity/v2/auth/password/reset',
      data: {
        'Otp': otp,
        'Username': username,
        'password': newPassword,
        'welcomeemailtemplate': welcomeEmailTemplate,
        "resetpasswordemailtemplate": resetPasswordEmailTemplate,
      },
      params: {'apikey': _loginRadiusSDK.apiKey},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to set or change UserName by access token.
  ///
  /// [accessToken] - Access Token of the User
  ///
  /// [username] - New username for the account
  ///
  /// [onSuccess] - Callback function on success
  ///
  /// [onError] - Callback function on error
  ///

  Future<dynamic> setOrChangeUsername({
    required String? accessToken,
    required String? username,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Auth Set or Change UserName");
    await _apiClient.put(
      '/identity/v2/auth/username',
      accessToken: accessToken,
      data: {'username': username},
      params: {'apikey': _loginRadiusSDK.apiKey},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method updates the user's profile by passing the access_token.
  ///
  /// [accessToken] - Access Token of the User
  ///
  /// [data] - User profile data
  ///
  /// [onSuccess] - Callback function on success
  ///
  /// [onError] - Callback function on error
  ///
  /// [emailTemplate] - Email template name
  ///
  /// [smsTemplate] - SMS template name
  ///
  /// [nullSupport] - Nullify the user's profile
  ///

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
        'apikey': _loginRadiusSDK.apiKey,
        'verificationurl': _loginRadiusSDK.verificationUrl,
        'emailtemplate': emailTemplate,
        'smstemplate': smsTemplate,
        'nullsupport': nullSupport
      },
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to update security questions by the access token.
  ///
  /// [accessToken] - Access Token of the User
  ///
  /// [securityQuestionAnswer] - Valid JSON object of Unique Security Question ID and Answer of set Security Question
  ///
  /// [onSuccess] - Callback function on success
  ///
  /// [onError] - Callback function on error
  ///

  Future<dynamic> updateSecurityQuestionByAccessToken({
    required String accessToken,
    required Map<String, dynamic> securityQuestionAnswer,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Update Security Question by Access token");
    await _apiClient.put(
      '/identity/v2/auth/account',
      accessToken: accessToken,
      data: {'securityquestionanswer': securityQuestionAnswer},
      params: {'apikey': _loginRadiusSDK.apiKey},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  //<--DELETE REQUESTS-->

  /// This method will send a confirmation email for account deletion to the customer's email when passed the customer's access token.
  ///
  /// [accessToken] - Access Token of the User
  ///
  /// [deleteUrl] - Url of the site
  ///
  /// [emailTemplate] - Email template name
  ///
  /// [onSuccess] - Callback function on success
  ///
  /// [onError] - Callback function on error
  ///

  Future<dynamic> deleteAccountWithEmailConfirmation({
    required String accessToken,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
    String? deleteUrl,
    String? emailTemplate,
  }) async {
    debugPrint("Auth Delete Account with Email Confirmation");
    await _apiClient.delete(
      '/identity/v2/auth/account',
      accessToken: accessToken,
      params: {
        'apikey': _loginRadiusSDK.apiKey,
        'deleteurl': deleteUrl,
        'emailtemplate': emailTemplate
      },
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to remove additional emails from a user's account.
  ///
  /// [accessToken] - Access Token of the User
  ///
  /// [email] - Email of the user
  ///
  /// [onSuccess] - Callback function on success
  ///
  /// [onError] - Callback function on error
  ///

  Future<dynamic> removeEmail({
    required String? email,
    required String? accessToken,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Auth Remove Email");
    await _apiClient.delete(
      '/identity/v2/auth/email',
      accessToken: accessToken,
      data: {'email': email},
      params: {'apikey': _loginRadiusSDK.apiKey},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }

  /// This method is used to unlink up a social provider account with the specified account based on the access token and the social providers user access token. The unlinked account will automatically get removed from your database.
  ///
  /// [accessToken] - Access Token of the User
  ///
  /// [provider] - Name of the provider
  ///
  /// [providerId] - Unique ID of the linked account
  ///
  /// [onSuccess] - Callback function on success
  ///
  /// [onError] - Callback function on error
  ///

  Future<dynamic> unlinkSocialIdentities({
    required String? provider,
    required String? providerId,
    required String? accessToken,
    required Function? Function(dynamic) onSuccess,
    required Function? Function(LRError) onError,
  }) async {
    debugPrint("Auth Unlink Social Identities");
    await _apiClient.delete(
      '/identity/v2/auth/socialidentity',
      accessToken: accessToken,
      data: {'provider': provider, 'providerid': providerId},
      params: {'apikey': _loginRadiusSDK.apiKey},
      onSuccess: (data) => onSuccess(data),
      onError: (error) => onError(error),
    );
  }
}
