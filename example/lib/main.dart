import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loginradius_sdk/loginradius_sdk.dart';

void main() {
  LoginRadiusSDK _loginRadius = LoginRadiusSDK.instance;
  _loginRadius.init(
    apiKey: '',
    appName: '',
    resetPasswordUrl: '',
    verificationUrl: '',
    sott: 'adkadadakdjadjdk',
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
  int _counter = 0;

  LoginRadiusSDK _loginRadius = LoginRadiusSDK.instance;

  void _incrementCounter() {
    // _loginRadius.loginByEmail(
    //     data: {
    //       'email': 'email',
    //       'password': 'password',
    //     },
    //     onSuccess: (data) {
    //       print(data);
    //     },
    //     onError: (error) {
    //       print(error.description);
    //     });
    _loginRadius.registerbyEmail(
        data: {
          'email': [
            {'type': 'Primary', 'value': 'email'}
          ],
          'password': 'password',
        },
        onSuccess: (data) {
          print(data);
        },
        onError: (error) {
          print(error);
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
