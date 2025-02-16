part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

// sign in api
class AuthInitial extends AuthState {}

class SignInAuthLoadingState extends AuthState {}

class SignInAuthCompletedState extends AuthState {
  final String? token;

  SignInAuthCompletedState(this.token);
}

class SignInAuthErrorState extends AuthState {
  final ErrorMessageClass errorMessageClass;

  SignInAuthErrorState(this.errorMessageClass);
}

//sign up
class SignUpLoadingState extends AuthState {}

class SignUpCompletedState extends AuthState {
  final String? token;

  SignUpCompletedState(this.token);
}

class SignUpErrorState extends AuthState {
  final ErrorMessageClass errorMessageClass;

  SignUpErrorState(this.errorMessageClass);
}
