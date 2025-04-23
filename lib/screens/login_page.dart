import 'package:flutter/material.dart';
import '../services/api_service.dart'; // api_service 가져오기
import '../widgets/custom_text_field.dart'; // custom_text_field 가져오기
import '../widgets/custom_button.dart'; // custom_button 가져오기

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';
  final ApiService _apiService = ApiService(); // ApiService 인스턴스 생성

  Future<void> _login() async {
    setState(() {
      _errorMessage = '';
    });

    if (_formKey.currentState!.validate()) {
      try {
        final response = await _apiService.login(
          _usernameController.text,
          _passwordController.text,
        );
        if (response.statusCode == 200) {
          print('Login Success');
          setState(() {
            _errorMessage = "로그인 성공";
          });
          Navigator.pushReplacementNamed(context, '/main');
        } else {
          setState(() {
            _errorMessage = response.data['message'] ?? '로그인 실패';
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = '오류 발생: $e';
        });
        print('Error during login: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomTextField( // CustomTextField 사용
                controller: _usernameController,
                labelText: 'Username',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              CustomTextField( // CustomTextField 사용
                controller: _passwordController,
                labelText: 'Password',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomButton( // CustomButton 사용
                  onPressed: _login,
                  text: 'Login'
              ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}