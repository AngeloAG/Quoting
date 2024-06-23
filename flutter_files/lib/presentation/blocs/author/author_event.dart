part of 'author_bloc.dart';

@immutable
sealed class AuthorEvent extends Equatable {
  const AuthorEvent();

  @override
  List<Object> get props => [];
}

class AuthorLoadEvent extends AuthorEvent {}

class AuthorUploadEvent extends AuthorEvent {
  final String authorName;

  const AuthorUploadEvent({required this.authorName});
}

class AuthorRemoveEvent extends AuthorEvent {
  final Author author;

  const AuthorRemoveEvent({required this.author});
}

class AuthorUpdateEvent extends AuthorEvent {
  final Author author;

  const AuthorUpdateEvent({required this.author});
}
