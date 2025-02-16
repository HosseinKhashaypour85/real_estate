import 'package:dio/dio.dart';
import 'package:real_state/features/home_features/model/home_model.dart';
import 'package:real_state/features/home_features/services/home_api_services.dart';

class HomeApiRepository {
  final HomeApiServices _apiServices = HomeApiServices();
  Future<HomeModel>callHomeApi()async{
    final Response response = await _apiServices.callHomeApi();
    HomeModel homeModel = HomeModel.fromJson(response.data);
    return homeModel;
  }
}