import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class KakaoService {

  Future<String?> login() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      if (isInstalled) {
        // 카카오톡으로 로그인
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        TokenManagerProvider.instance.manager.setToken(token);
        print('---------1------카카오톡으로 로그인 성공 ${token.accessToken}');
        return token.accessToken;
      } else {
        // 카카오계정으로 로그인
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        TokenManagerProvider.instance.manager.setToken(token);
        print('--------2--------카카오톡으로 로그인 성공 ${token.accessToken}');
        CheckToken();
        return token.accessToken;
      }
    } catch (e) {
      print('---------3---------Error during login: $e');
      throw e;
    }
  }

  Future <void> CheckToken() async{
    try {
      AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
      print('토큰 정보 보기 성공'
          '\n회원정보: ${tokenInfo.id}'
          '\n만료시간: ${tokenInfo.expiresIn} 초');
    } catch (error) {
      print('토큰 정보 보기 실패 $error');
    }
    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }

  Future<bool?> isExistKakaoToken() async{
    try{
      final token = await TokenManagerProvider.instance.manager.getToken();
      if(token == null) {
        print('토큰이 null인경우');
        print(token);
        return false;
      }else{
        return token.accessToken.isNotEmpty;
      }
    }
    catch(e){
      print(e);
      return false;
    }
  }
  Future <void> logout()async{
    try {
      await UserApi.instance.logout();
      print('로그아웃 성공, SDK에서 토큰 폐기');
    } catch (error) {
      print('로그아웃 실패, SDK에서 토큰 폐기 $error');
    }
  }
}