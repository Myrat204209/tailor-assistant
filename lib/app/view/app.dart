// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auth_repository/auth_repository.dart';
import 'package:dap_foreman_assis/app/app.dart';
import 'package:dap_foreman_assis/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  const App({
    required UserRepository userRepository,
    required AuthRepository authRepository,
    super.key,
  })  : _authRepository = authRepository,
        _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    final authBloc = AuthBloc(
      authRepository: _authRepository,
      userRepository: _userRepository,
    )..add(AuthSubscriptionRequested());
    final themeCubit = ThemeCubit()..loadTheme();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authRepository),
        RepositoryProvider.value(value: _userRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: authBloc),
          BlocProvider.value(value: themeCubit),
        ],
        child: const AppView(),
      ),
    );
  }
}
