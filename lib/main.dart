import 'package:flutter/material.dart';
import 'app.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:projectfolder/utils/constants.dart';
void main(){
  // Kakao SDK 초기화
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
      javaScriptAppKey: '$JAVASCRIPT_APP_KEY',
      nativeAppKey: '$NATIVE_APP_KEY',
  );

  runApp(MyApp());
}