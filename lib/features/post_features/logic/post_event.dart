part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class SubmitPostEvent extends PostEvent{
  final File imageFile;
  final String title;
  SubmitPostEvent({required this.imageFile, required this.title});
}
