import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dap_foreman_assis/app/app.dart';
import 'package:flutter/widgets.dart';

typedef AppBuilder = FutureOr<Widget> Function();

Future<void> bootstrap(AppBuilder builder) async {
  await runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    const blocObserver = AppBlocObserver();

    Bloc.observer = blocObserver;
    runApp(
      await builder(),
    );
  }, (exception, stackTrace) async {
    FlutterError.onError = (details) {
      log(details.exceptionAsString(), stackTrace: details.stack);
    };
  });
}
