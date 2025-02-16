import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:real_state/features/auth_features/services/auth_api_repository.dart';

import '../../public_features/functions/error/error_exception.dart';
import '../../public_features/functions/error/error_message_class.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthApiRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<CallSignEvent>(
      (event, emit) async {
        emit(SignInAuthLoadingState());
        try {
          final Response response = await repository.callSignInApi(
              event.phoneNumber!, event.password!);
          final String? token = response.data['token'];
          emit(SignInAuthCompletedState(token));
        } on DioException catch (e) {
          emit(SignInAuthErrorState(
            ErrorMessageClass(errorMsg: ErrorExceptions().fromError(e)),
          ));
        }
      },
    );
    on<CallSignUpEvent>(
      (event, emit) async {
        emit(SignUpLoadingState());
        try {
          final Response response = await repository.callSignUpApi(
            event.phoneNumber!,
            event.password!,
            event.passwordConfirm!,
          );
          final String? token = response.data['token'];
          emit(SignUpCompletedState(token));
        } on DioException catch (e) {
          emit(SignInAuthErrorState(
            ErrorMessageClass(errorMsg: ErrorExceptions().fromError(e)),
          ));
        }
      },
    );
  }
}
