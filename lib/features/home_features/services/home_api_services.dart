import 'package:dio/dio.dart';
class HomeApiServices {
  final Dio _dio  = Dio();
  Future<Response>callHomeApi()async{
    final Response response =await  _dio.get('https://hosseinkhashaypour.chbk.app/api/collections/real_state/records');
    return response;
  }
}