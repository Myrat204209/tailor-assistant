import 'dart:async';

import 'package:dap_foreman_assis/app/app.dart';
import 'package:dap_foreman_assis/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

typedef AppBuilder = FutureOr<Widget> Function();
Future<void> bootstrap(AppBuilder builder) async {
  await runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

    const blocObserver = AppBlocObserver();
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationSupportDirectory(),
    );
    if (kDebugMode) {
      await HydratedBloc.storage.clear();
    }

    /// Hive Box

    Bloc.observer = blocObserver;
    runApp(
      await builder(),
    );
  }, (exception, stackTrace) async {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
     PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
    // FlutterError.onError = (details) {
    //   log(details.exceptionAsString(), stackTrace: details.stack);
    // };
  });
}
