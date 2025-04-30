import 'package:flutter/material.dart';
import 'package:projectfolder/services/kakao_service.dart';
import 'screens/login_page.dart';
import 'screens/main_page.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final KakaoService _kakaoService = KakaoService();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.paused || State == AppLifecycleState.detached || State == AppLifecycleState.inactive){
      _kakaoService.logout();
    }
  }
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