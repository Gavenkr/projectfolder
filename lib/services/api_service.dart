import 'package:dio/dio.dart';
import 'package:projectfolder/utils/constants.dart';

class ApiService {
  final Dio _dio = Dio();

  String? _jwtToken; // jwt 토큰을 저장할 변수
  void setJwtToken(String token) {
    _jwtToken = token;
  }
  void removeJwtToken() {
    _jwtToken = null;
  }
  Options _addJwtTokenToHeader(Options? options) {
    final headers = Map<String, dynamic>.from(options?.headers ?? {});
    if (_jwtToken != null){
      headers['Authorization'] = 'Bearer $_jwtToken';
    }
    return options?.copyWith(headers: headers) ?? Options(headers: headers);
  }

  Future<Response> loginWithKakao(String accessToken) async {
    try {
      print(10);
      Response response = await _dio.post(
        '${SERVER_URL}/login/oauth/kakao',
        //'/test',
        data: {
          "accessToken":"${accessToken}",
        },
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      print(11);
      print(response);
      return response;

    } on DioException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }
  Future<Response> validateKakaoToken(String accessToken) async {
    try {
      Response response = await _dio.post(
        '${SERVER_URL}/validate/kakao', // 카카오 토큰 검증 엔드포인트
        data: {
          "kakaoToken": "${accessToken}",
        },
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      return response;
    } on DioException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }
}