// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auth_repository/auth_repository.dart';
import 'package:dap_foreman_assis/app/app.dart';
import 'package:dap_foreman_assis/auth/auth.dart';
import 'package:dap_foreman_assis/employees/employees.dart';
import 'package:dap_foreman_assis/operation/operation.dart';
import 'package:dap_foreman_assis/orders/orders.dart';
import 'package:dap_foreman_assis/profile/cubit/profile_cubit.dart';
import 'package:dap_foreman_assis/reports/reports.dart';
import 'package:dap_foreman_assis/theme_selector/theme_selector.dart';
import 'package:data_provider/data_provider.dart';
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
    required ReportBoxClient reportBoxClient,
    required StorageRepository storageRepository,
    super.key,
  })  : _authRepository = authRepository,
        _employeesRepository = employeesRepository,
        _reportsBoxRepository = reportBoxClient,
        _storageRepository = storageRepository,
        _operationRepository = operationRepository,
        _ordersRepository = ordersRepository,
        _userRepository = userRepository;

  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  final EmployeesRepository _employeesRepository;
  final OperationRepository _operationRepository;
  final OrdersRepository _ordersRepository;
  final ReportBoxClient _reportsBoxRepository;
  final StorageRepository _storageRepository;
  @override
  Widget build(BuildContext context) {
    final authBloc = AuthBloc(
      authRepository: _authRepository,
      userRepository: _userRepository,
    )..add(AuthSubscriptionRequested());
    final operationBloc =
        OperationBloc(operationRepository: _operationRepository)
          ..add(const OperationRequested());
    final ordersBloc = OrdersBloc(ordersRepository: _ordersRepository)
      ..add(const OrdersRequested());
    final employeesBloc =
        EmployeesBloc(employeesRepository: _employeesRepository)
          ..add(EmployeesInitRequested());
    // final themeCubit = ThemeCubit()..loadTheme();
    final editCubit = EditCubit();
    final profileCubit = ProfileCubit();
    final themeModeBloc = ThemeModeBloc();
    final reportsBloc = ReportsBloc(reportsBox: _reportsBoxRepository);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authRepository),
        RepositoryProvider.value(value: _ordersRepository),
        RepositoryProvider.value(value: _userRepository),
        RepositoryProvider.value(value: _reportsBoxRepository),
        RepositoryProvider.value(value: _storageRepository),
        RepositoryProvider.value(value: _operationRepository),
        RepositoryProvider.value(value: _employeesRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: authBloc),
          BlocProvider.value(value: employeesBloc),
          BlocProvider.value(value: operationBloc),
          BlocProvider.value(value: ordersBloc),
          BlocProvider.value(value: themeModeBloc),
          BlocProvider.value(value: reportsBloc),
          BlocProvider.value(value: editCubit),
          BlocProvider.value(value: profileCubit),
        ],
        child: const AppView(),
      ),
    );
  }
}
