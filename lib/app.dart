import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/main_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      initialRoute: '/', // 초기 경로 설정
      routes: {
        '/': (context) => LoginPage(),
        '/main': (context) => MainPage(),
      },
    );
  }
}