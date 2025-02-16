import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:real_state/features/home_features/model/home_model.dart';
import 'package:real_state/features/home_features/services/home_api_repository.dart';
import 'package:real_state/features/public_features/functions/error/error_message_class.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeApiRepository repository;

  HomeBloc(this.repository) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      emit(HomeLoadingState());
      try {
        final HomeModel homeModel = await repository.callHomeApi();
        emit(HomeCompletedState(homeModel));
      } on DioException catch (e) {
        emit(HomeErrorState(ErrorMessageClass(errorMsg: e.toString())));
      }
    });
  }
}
