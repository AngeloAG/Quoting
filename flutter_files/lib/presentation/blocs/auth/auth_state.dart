part of 'auth_bloc.dart';

final class AuthState extends Equatable {
  final User currentUser;

  const AuthState({this.currentUser = const User(id: '', email: '')});

  @override
  List<Object> get props => [];
}
