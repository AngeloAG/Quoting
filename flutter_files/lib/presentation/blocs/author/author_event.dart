part of 'author_bloc.dart';

@immutable
sealed class AuthorEvent {}

final class AuthorUploadEvent extends AuthorEvent {
  final String authorContent;

  AuthorUploadEvent({required this.authorContent});
}

final class AuthorLoadEvent extends AuthorEvent {}

final class AuthorRemoveEvent extends AuthorEvent {
  final String authorId;

  AuthorRemoveEvent({required this.authorId});
}
