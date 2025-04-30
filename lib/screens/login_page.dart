import 'package:flutter/material.dart';
import '../services/kakao_service.dart'; // KakaoService를 사용하기 위해 import
import '../services/api_service.dart'; // ApiService를 사용하기 위해 import
import '../widgets/custom_button.dart'; // CustomButton 위젯을 사용하기 위해 import

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final KakaoService _kakaoService = KakaoService();
  final ApiService _apiService = ApiService();
  String _errorMessage = '';
  bool _isLoading = false; // 로딩 상태를 나타내는 변수

  Future<void> _loginWithKakao() async {
    setState(() {
      _errorMessage = ''; // 에러 메시지 초기화
      _isLoading = true; // 로딩 시작
    });
    print(1);
    try {
      //카카오 토큰이 존재하는지 확인
      final isExistToken = await _kakaoService.isExistKakaoToken();
      print(2);
      print(isExistToken);

      if(!isExistToken!) {
        // 카카오 토큰이 없다면
        final kakaoToken = await _kakaoService.login(); // KakaoService를 통해 카카오 로그인 시도
        print(3);

        if (kakaoToken != null) {
          // 카카오 로그인 성공
          // 앱 서버로 카카오 토큰을 전달하여 인증 진행
          print(4);
          final response = await _apiService.loginWithKakao(kakaoToken);
          print(5);
          print(response);
          if (response.statusCode == 200) {
            // 앱 서버 인증 성공
            // 다음 화면으로 이동 (예: 메인 화면)
            Navigator.pushReplacementNamed(context, '/main');
          } else {
            // 앱 서버 인증 실패
            setState(() {
              _showErrorSnackBar(response.data['message'] ?? '로그인 실패');
            });
          }
        } else {
          // 카카오 로그인 실패
          setState(() {
            _showErrorSnackBar('카카오 로그인 실패');
          });
        }
      } else {
          // 토큰이 이미 존재하면, 토큰으로 로그인 시도
        _showErrorSnackBar('이미 로그인 중 입니다.');
        _kakaoService.CheckToken();
        _kakaoService.logout();
      }
    } catch (e) {
      setState(() {
        _showErrorSnackBar('로그인 중 오류가 발생했습니다: $e');
      });
      print('Error during login: $e');
    } finally {
      setState(() {
        _isLoading = false; // 로딩 종료
      });
    }
  }
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //var pressed = (_isLoading ? null : _loginWithKakao) as VoidCallback;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Stack(
          children: [
            Column( // 에러메시지를 표시
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomButton( // 카카오 로그인 버튼
                  onPressed: _loginWithKakao,
                  text: '카카오 로그인',
                  //icon: Icons.chat, // 예시 아이콘
                ),
                SizedBox(height: 20),
                if(_errorMessage.isNotEmpty) // 에러메시지가 있는 경우만 띄우기
                  Text(
                    _errorMessage, // 에러 메시지 표시
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
            if(_isLoading)
              Center(
                child: CircularProgressIndicator(),
              )
        ]),
      ),
    );
  }
}