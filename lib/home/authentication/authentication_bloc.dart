import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/repositories/user_repository/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'authentication_state.dart';
part 'authentication_event.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseUserRepository _firebaseUserRepository;

  AuthenticationBloc({required FirebaseUserRepository firebaseUserRepository})
      : _firebaseUserRepository = firebaseUserRepository,
        super(Uninitialized()) {
    on<AppStarted>(_onAppStarted);
  }

  void _onAppStarted(
      AppStarted event,
      Emitter<AuthenticationState> emit,
      ) async {
    try {
      await _firebaseUserRepository.authenticate();
      final userId = _firebaseUserRepository.getUserId();

      emit(userId == null ? Unauthenticated() : Authenticated(userId));
    } catch (_) {
      emit(Unauthenticated());
    }
  }
}
