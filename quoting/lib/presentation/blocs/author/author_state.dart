part of 'author_bloc.dart';

enum AuthorStatus { initial, loading, success, failure, loaded }

final class AuthorState extends Equatable {
  final AuthorStatus status;
  final List<Author> authors;
  final List<Author> searchedAuthors;
  final String failureMessage;

  const AuthorState({
    this.status = AuthorStatus.initial,
    this.authors = const [],
    this.searchedAuthors = const [],
    this.failureMessage = '',
  });

  AuthorState copyWith({
    AuthorStatus Function()? status,
    List<Author> Function()? authors,
    List<Author> Function(List<Author> currentAuthors)? searchedAuthors,
    String Function()? failureMessage,
  }) {
    return AuthorState(
        status: status != null ? status() : this.status,
        authors: authors != null ? authors() : this.authors,
        searchedAuthors: searchedAuthors != null
            ? searchedAuthors(this.authors)
            : this.searchedAuthors,
        failureMessage:
            failureMessage != null ? failureMessage() : this.failureMessage);
  }

  @override
  List<Object?> get props => [status, authors, searchedAuthors, failureMessage];
}
