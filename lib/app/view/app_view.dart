import 'dart:async';
// import 'dart:developer';
import 'package:app_ui/app_ui.dart';
import 'package:auth_repository/auth_repository.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dap_foreman_assis/auth/auth.dart';
import 'package:dap_foreman_assis/home/home.dart';
import 'package:dap_foreman_assis/login/login.dart';
import 'package:dap_foreman_assis/theme_selector/theme_selector.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> with WidgetsBindingObserver {
  // List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  // final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  // bool _isOffline = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // initConnectivity();

    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
    // _connectivitySubscription =
    //     Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
    // _checkInitialConnection();
  }

  @override
  void dispose() {
    Hive.close();
    WidgetsBinding.instance.removeObserver(this);
    // _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    // late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // try {
    //   // result = await _connectivity.checkConnectivity();
    // } on PlatformException catch (e) {
    //   log("Couldn't check connectivity status", error: e);
    //   return;
    // }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value();
    }

    // return _updateConnectionStatus(result);
  }

  // Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
  //   setState(() {
  //     _connectionStatus = result;
  //   });
  //   // ignore: avoid_print
  //   print('Connectivity changed: $_connectionStatus');
  // }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      Hive.close();
    }
  }

  // void _updateConnectionStatus(ConnectivityResult result) {
  //   final isOffline = result == ConnectivityResult.none;
  //   if (isOffline != _isOffline) {
  //     setState(() {
  //       _isOffline = isOffline;
  //     });
  //     if (_isOffline) {
  //       _showNoConnectionDialog();
  //     } else {
  //       Navigator.of(context).pop();
  //     }
  //   }
  // }

  void _showNoConnectionDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Соединение прервано :('),
          content: const Text(''),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                initConnectivity();
              },
              child: const Text('Повторите заново...'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return BlocSelector<ThemeModeBloc, ThemeMode, ThemeMode>(
            selector: (state) => state,
            builder: (context, themeMode) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                themeMode: themeMode,
                theme: const AppTheme().themeData,
                darkTheme: const AppDarkTheme().themeData,
                home: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state.status == AuthStatus.unauthenticated) {
                      return const LoginPage();
                    } else {
                      return const HomePage();
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
