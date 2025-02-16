import 'package:dio/dio.dart';
import 'package:real_state/features/auth_features/services/auth_api_services.dart';

class AuthApiRepository {
  final AuthApiServices _apiServices = AuthApiServices();

//   sign in api
  Future<Response> callSignInApi(String identity, String password) async {
    return await _apiServices.callSignInApi(identity, password);
  }

//   sign up api
  Future<Response> callSignUpApi(
      String username, String password, String passwordConfirm) async {
    return await _apiServices.callSignUpApi(
        username, password, passwordConfirm);
  }
}
