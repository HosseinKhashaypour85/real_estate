part of 'post_bloc.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostLoadingState extends PostState {}

class PostCompletedState extends PostState {
  final String message;
  PostCompletedState({required this.message});
}

class PostErrorState extends PostState {
  final ErrorMessageClass error;
  PostErrorState(this.error);
}
