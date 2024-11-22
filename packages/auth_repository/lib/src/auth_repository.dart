import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus { authenticated, unauthenticated, unknown }

class AuthRepository {
  static const _authKey = 'auth_status';
  final _controller = StreamController<AuthStatus>();

  AuthRepository() {
    _loadInitialStatus();
  }

  Stream<AuthStatus> get status => _controller.stream;

  Future<void> _loadInitialStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isAuthenticated = prefs.getBool(_authKey) ?? false;
    _controller.add(
      isAuthenticated ? AuthStatus.authenticated : AuthStatus.unauthenticated,
    );
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(_authKey, true);
        _controller.add(AuthStatus.authenticated);
      },
    );
  }

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_authKey, false);
    _controller.add(AuthStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}