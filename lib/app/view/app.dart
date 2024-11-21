// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auth_repository/auth_repository.dart';
import 'package:dap_foreman_assis/app/app.dart';
import 'package:dap_foreman_assis/auth/auth.dart';
import 'package:dap_foreman_assis/employees/employees.dart';
import 'package:dap_foreman_assis/operation/operation.dart';
import 'package:dap_foreman_assis/orders/data/data.dart';
import 'package:dap_foreman_assis/orders/orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  const App({
    required UserRepository userRepository,
    required AuthRepository authRepository,
    required OperationRepository operationRepository,
    required EmployeesRepository employeesRepository,
    required OrdersRepository ordersRepository,
    super.key,
  })  : _authRepository = authRepository,
        _employeesRepository = employeesRepository,
        _operationRepository = operationRepository,
        _ordersRepository = ordersRepository,
        _userRepository = userRepository;

  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  final EmployeesRepository _employeesRepository;
  final OperationRepository _operationRepository;
  final OrdersRepository _ordersRepository;
  @override
  Widget build(BuildContext context) {
    final authBloc = AuthBloc(
      authRepository: _authRepository,
      userRepository: _userRepository,
    )..add(AuthSubscriptionRequested());
    final operationBloc =
        OperationBloc(operationRepository: _operationRepository);
    final ordersBloc = OrdersBloc(ordersRepository: _ordersRepository)
      ..add(const OrdersRequested());
    final employeesBloc =
        EmployeesBloc(employeesRepository: _employeesRepository)
          ..add(EmployeesInitRequested());
    final themeCubit = ThemeCubit()..loadTheme();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authRepository),
        RepositoryProvider.value(value: _ordersRepository),
        RepositoryProvider.value(value: _userRepository),
        RepositoryProvider.value(value: _operationRepository),
        RepositoryProvider.value(value: _employeesRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: authBloc),
          BlocProvider.value(value: employeesBloc),
          BlocProvider.value(value: operationBloc),
          BlocProvider.value(value: ordersBloc),
          BlocProvider.value(value: themeCubit),
        ],
        child: const AppView(),
      ),
    );
  }
}
