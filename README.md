<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# LoginRadius Flutter SDK
![Home Image](http://docs.lrcontent.com/resources/github/banner-1544x500.png)

## Introduction ##
LoginRadius is an Identity Management Platform that simplifies user registration while securing data. LoginRadius Platform simplifies and secures your user registration process, increases conversion with Social Login that combines 30 major social platforms, and offers a full solution with Traditional Customer Registration. You can gather a wealth of user profile data from Social Login or Traditional Customer Registration.

LoginRadius centralizes it all in one place, making it easy to manage and access. Easily integrate LoginRadius with all of your third-party applications, like MailChimp, Google Analytics, Livefyre and many more, making it easy to utilize the data you are capturing.

LoginRadius helps businesses boost user engagement on their web/mobile platform, manage online identities, utilize social media for marketing, capture accurate consumer data, and get unique social insight into their customer base.

Please visit [here](http://www.loginradius.com/) for more information.

#### There are two projects in the library:
a. example - This is the demo application.    
b. lib -This is the LoginRadius SDK.

> #### Disclaimer
>This library is meant to help you with a quick implementation of the LoginRadius platform and also to serve as a reference point for the LoginRadius API. Keep in mind that it is an open source library, which means you are free to download and customize the library functions based on your specific application needs

## Initializing SDK
In your `main` function, create an instance of the **LoginRadiusSDK** and call the `init` method on it, then populate it with the required data.
```dart
import 'package:loginradius_sdk/loginradius_sdk.dart'; //import the LoginRadius package

void main() {
  LoginRadiusSDK _loginRadius = LoginRadiusSDK.instance;

  _loginRadius.init(
    apiKey: YOUR_API_KEY,
    appName: YOUR_APP_NAME,
    resetPasswordUrl: YOUR_RESET_PASSWORD_URL,
    verificationUrl: YOUR_VERIFICATION_URL,
    sott: YOUR_SOTT,
  );
  
  runApp(const MyApp());
}
```
The above initialization requires options object with the following parameter:

| Name | Required | Description |
| ---         |     ---     |  --- |
| apiKey   | :heavy_check_mark:     | Set to your LoginRadius API Key which you can get [here](https://loginradius.readme.io/get-api-key-and-secret).    |
| appName     | :heavy_check_mark:       | Set to your LoginRadius site name, this is required for User Registration to work with Single Sign On API.      |
| sott   | :heavy_check_mark:     | Secure One-time Token. Get token from Admin Console Note: While generating SOTT from Loginradius [Admin Console](https://secure.loginradius.com/deployment/mobile-app), enable Encode SOTT.    |
| verificationUrl     | :heavy_check_mark:       | Set dynamic URL for email verification (Default URL: https://auth.lrcontent.com/mobile/verification/index.html)      |
| resetPasswordUrl   | :heavy_check_mark:     | Set dynamic URL for reset password.    |


## LoginRadius API Showcase

This section helps you to explore various API methods of LoginRadius Flutter SDK. They can be used to fulfill your identity based needs related to traditional login, registration and many more.

## Authentication API
This API is used to perform operations on a user account after the user has authenticated himself for the changes to be made. Generally, it is used for Frontend API calls. Following is the list of methods covered under this API:

- Registration By Email
- Registration By Phone
- Login By Email
- Login By Username
- Read Complete User Profile
- Update User Profile
- Accept Privacy Policy
- Send Welcome Email
- Get Social Identity
- Link Social Account
- Unlink Social Account
- 
- Check Email Availability
- Add Email
- Verify Email
- Verify Email By OTP
- Remove Email
- Resend Verification Email
- Change Password
- Forgot Password By Email
- Validate Access Token
- Invalidate Access Token
- Get Security Questions By Email
- Get Security Questions By Username
- Get Security Questions By Access Token
- Update Security Questions By Access Token
- Login with Security Questions By Email
- Login with Security Questions By Phone
- Login with Security Questions By Username
- Check Username Availability
- Set or Change Username
- Reset Password By Email OTP
- Reset Password By Reset Token
- Reset Password By Security Questions using Email
- Reset Password By Security Questions using Username
- Delete Account
- Delete Account with Email confirmation

## Register by Email

This method creates a user in the database as well as sends a verification email to the user.

In the following example, we initialized the LoginRadius Authentication class `LRAuthenticationApi`. This class exposes all methods relating to Authentication of Users.  Then we call the `signUpWithEmailandPassword` method on the instance of the class `_auth`. This method has 3 required parameters, which are as follows:

| params | Description |
| --- | --- |
| `data` | User attributes. To view the complete list of user attributes, please have a look at the body parameters of the user registration API [here](https://www.loginradius.com/docs/api/v2/user-registration/auth-user-registration-by-email). |
| `onSuccess` | Callback function on success |
| `onError` | Callback function on error |

```dart
final LRAuthenticationApi _auth = LRAuthenticationApi();

void createAccount() {
    Map<String, dynamic> userData = {
      "FirstName": "Test",
      "LastName": "Account",
      "FullName": "Test Account",
      "BirthDate": "10-12-1985",
      "Gender": "M",
      "Email": [
        {"Type": "Primary", "Value": "example@example.com"}
      ],
      "Password": "******"
    };

    _auth.signUpWithEmailAndPassword(
        data: userData,
        onSuccess: (data) {
          debugPrint(data);
        },
        onError: (error) {
          debugPrint(error.description);
        });
 }  
```

## Login by Email

This method retrieves a copy of the user data based on the email.

```dart
  final LRAuthenticationApi _auth = LRAuthenticationApi();

  void loginbyEmail() async {
    late String accessToken;

    await _auth.signInWithEmailAndPassword(
       email: 'example@example.com',
       password: '********',
        onSuccess: (data) {
          accessToken = data['access_token'];
        },
        onError: (error) {
          debugPrint(error.description);
        });
  } 
```

## Login by Username

This method retrieves a copy of the user data based on the username.

```dart
final LRAuthenticationApi _auth = LRAuthenticationApi();

  void loginbyUsername() async {
    late String accessToken;
    await _auth.signInWithUsernameAndPassword(
       username: 'jackandjill',
       password: '********',
        onSuccess: (data) {
          accessToken = data['access_token'];
        },
        onError: (error) {
          debugPrint(error.description);
        });
  } 
```

## Read Complete User Profile

This method retrieves a copy of the user data based on the access token.

```dart
 final LRAuthenticationApi _auth = LRAuthenticationApi();

  void getUserProfile() async {
    String accessToken = '<your_access_token>'; // your access token

    _auth.getUserProfileData(
        accessToken: accessToken,
        onSuccess: (data) {
          debugPrint('GET USER PROFILE DATA $data');
        },
        onError: (error) {
          debugPrint(error.description);
        });
  } 
```

## Link Social Account

This method is used to link up a social provider account with the specified account based on the access token and the social providers user access token.

```dart
 final LRAuthenticationApi _auth = LRAuthenticationApi();

 String accessToken = 'your_access_token'; // Required
 String candidateToken = 'your_candidate_token'; // Required

 await _auth.linkSocialIdentity(
   candidateToken: candidateToken,
   accessToken: accessToken,
   onSuccess: (data) {
        debugPrint(data);
   },
   onError: (error) {
        debugPrint(error.description);
   });
  } 
```

## Unlink Social Account

This method is used to unlink up a social provider account with the specified account based on the access token and the social providers user access token. The unlinked account will automatically get removed from your database.

```dart
 final LRAuthenticationApi _auth = LRAuthenticationApi();

 String accessToken = 'your_access_token'; // Required
 String provider = '<provider_name>'; // Required
 String providerId = '<your_provider_id>'; // Required

 await _auth.unlinkSocialIdentities(
        provider: provider,
        providerId: providerId,
        accessToken: accessToken,
        onSuccess: (data) {
          debugPrint(data);
        },
        onError: (error) {
          debugPrint(error.description);
        });
  } 
```


## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
