import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Response> login(String username, String password) async {
    try {
      Response response = await _dio.post(
        'http://YOUR_SERVER_IP:PORT/login',
        data: {
          'username': username,
          'password': password,
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