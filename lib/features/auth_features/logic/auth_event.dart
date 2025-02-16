part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

// sign in
class CallSignEvent extends AuthEvent {
  final String? phoneNumber;
  final String? password;

  CallSignEvent(this.phoneNumber, this.password);
}

//sign up
class CallSignUpEvent extends AuthEvent {
  final String? phoneNumber;
  final String? password;
  final String? passwordConfirm;

  CallSignUpEvent({
    required this.phoneNumber,
    required this.password,
    required this.passwordConfirm,
  });
}
