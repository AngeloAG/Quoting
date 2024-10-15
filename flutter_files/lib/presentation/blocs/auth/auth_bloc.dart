import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_files/domain/models/user.dart';
import 'package:fpdart/fpdart.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<AuthEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
