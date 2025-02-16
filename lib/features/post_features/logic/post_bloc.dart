import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:real_state/features/post_features/services/post_api_repository.dart';

import '../../public_features/functions/error/error_message_class.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostApiRepository _postApiRepository;

  PostBloc(this._postApiRepository) : super(PostInitial()) {
    on<SubmitPostEvent>(_onSubmitPost);
  }

  Future<void> _onSubmitPost(
      SubmitPostEvent event,
      Emitter<PostState> emit,
      ) async {
    emit(PostLoadingState());

    try {
      final response =
      await _postApiRepository.callPostApi(event.title, event.imageFile);

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(PostCompletedState(message: 'پست با موفقیت ارسال شد!'));
      } else {
        emit(PostErrorState(ErrorMessageClass(
            errorMsg: 'خطا در ارسال داده. کد وضعیت: ${response.statusCode}')));
      }
    } catch (e) {
      emit(PostErrorState(ErrorMessageClass(
          errorMsg: 'مشکلی در ارسال درخواست به وجود آمده است: $e')));
    }
  }
}
