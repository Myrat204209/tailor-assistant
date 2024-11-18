// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const AuthState.unknown()) {
    on<AuthSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthLogoutRequested>(_onLogoutPressed);
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  FutureOr<void> _onSubscriptionRequested(
    AuthSubscriptionRequested event,
    Emitter<AuthState> emit,
  ) {
    return emit.onEach(
      _authRepository.status,
      onData: (status) async {
        switch (status) {
          case AuthStatus.unknown:
            return emit(const AuthState.unknown());
          case AuthStatus.authenticated:
            final user = await _tryGetUser();
            return emit(
              user != null
                  ? AuthState.authenticated(user)
                  : const AuthState.unauthenticated(),
            );
          case AuthStatus.unauthenticated:
            return emit(const AuthState.unauthenticated());
        }
      },
      onError: addError,
    );
  }

  void _onLogoutPressed(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) {
    _authRepository.logOut();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }
}
