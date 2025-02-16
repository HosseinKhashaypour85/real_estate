import 'dart:io';
import 'package:dio/dio.dart';
import 'package:real_state/features/post_features/services/post_api_services.dart';

class PostApiRepository {
  final PostApiServices _apiServices = PostApiServices();

  Future<Response> callPostApi(String title, File imageFile) async {
    try {
      final Response response = await _apiServices.callPostApi(title, imageFile);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
