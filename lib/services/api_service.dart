import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Response> login(String username, String password) async {
    try {
      Response response = await _dio.post(
        'http://14.56.199.186:8080/api/auth/login',
        //'/test',
        data: {
          'username': username,
          'password': password,
        },
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      print(response);
      return response;

    } on DioException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }
}