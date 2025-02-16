part of 'token_check_cubit.dart';

@immutable
abstract class TokenCheckState {}

class TokenCheckInitial extends TokenCheckState {}
class TokenCheckIsLogedState extends TokenCheckState {}
class TokenCheckIsNotLogedState extends TokenCheckState {}
