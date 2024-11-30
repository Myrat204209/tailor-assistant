import 'dart:async';
import 'dart:developer';

import 'package:dap_foreman_assis/app/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

typedef AppBuilder = FutureOr<Widget> Function();

Future<void> bootstrap(AppBuilder builder) async {
  await runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    const blocObserver = AppBlocObserver();
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationSupportDirectory(),
    );
    if (kDebugMode) {
      await HydratedBloc.storage.clear();
    }
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
