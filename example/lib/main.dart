import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:loginradius_sdk/loginradius_sdk.dart';

void main() {
  LoginRadiusSDK _loginRadius = LoginRadiusSDK.instance;
  _loginRadius.init(
    apiKey: API_KEY,
    appName: APP_NAME,
    resetPasswordUrl: RESET_PASSWORD_URL,
    verificationUrl: VERIFICATION_URL,
    sott: SOTT,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _counter = 0;

  final LoginRadiusSDK _loginRadius = LoginRadiusSDK.instance;

  void _incrementCounter() async {
    //LOGIN USERS

    late String accessToken;

    await _loginRadius.signInWithEmailAndPassword(
        data: {
          'email': 'email@email.com',
          'password': 'P@ssword12345',
        },
        onSuccess: (data) {
          debugPrint('LOGIN BY EMAIL $data');
          accessToken = data['access_token'];
        },
        onError: (error) {
          debugPrint(error.description);
        });

    Future.delayed(const Duration(seconds: 3), () {});

    // // REGISTER USERS
    // _loginRadius.registerbyEmail(
    //     data: {
    //       'email': [
    //         {'type': 'Primary', 'value': 'email@email.com'}
    //       ],
    //       'password': 'P@ssword12345',
    //     },
    //     onSuccess: (data) {
    //       debugPrint(data);
    //     },
    //     onError: (error) {
    //       debugPrint(error.description);
    //     });

    //GET USER PROFILE DETAILS

    _loginRadius.getUserProfileData(
        accessToken: accessToken,
        onSuccess: (data) {
          debugPrint('GET USER PROFILE DATA $data');
        },
        onError: (error) {
          debugPrint(error.description);
        });

    Future.delayed(const Duration(seconds: 3), () {});
    //INVALIDATE ACCESS TOKEN/LOG OUT

    _loginRadius.invalidateAccessToken(
        accessToken: accessToken,
        onSuccess: (data) {
          debugPrint('INVALIDATE ACCESS TOKEN $data');
        },
        onError: (error) {
          debugPrint(error.description);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
