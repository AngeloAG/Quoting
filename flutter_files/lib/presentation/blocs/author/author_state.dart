part of 'author_bloc.dart';

@immutable
sealed class AuthorState {}

final class AuthorInitial extends AuthorState {}

final class AuthorLoading extends AuthorState {}

final class AuthorFailure extends AuthorState {
  final String error;

  AuthorFailure(this.error);
}

final class AuthorSuccess extends AuthorState {}

final class AuthorLoadSuccess extends AuthorState {
  final List<Author> authors;

  AuthorLoadSuccess(this.authors);
}
