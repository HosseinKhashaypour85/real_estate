import 'package:dio/dio.dart';

class AuthApiServices {
  final Dio _dio = Dio();

  // sign in api
  Future<Response> callSignInApi(String identity, String password) async {
    final apiUrl =
        'https://hosseinkhashaypour.chbk.app/api/collections/users/auth-with-password';
    final Response response = await _dio.post(
      apiUrl,
      data: {
        'identity': identity,
        'password': password,
      },
    );
    return response;
  }

  Future<Response> callSignUpApi(
      String username, String password, String passwordConfirm) async {
    final apiUrl =
        'https://hosseinkhashaypour.chbk.app/api/collections/users/records';
    final Response response = await _dio.post(
      apiUrl,
      data: {
        'username' : username,
        'password' : password,
        'passwordConfirm' : passwordConfirm,
      },
    );
    return response;
  }
}
