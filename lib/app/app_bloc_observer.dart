import 'dart:developer' show log;
import 'package:bloc/bloc.dart';
import 'package:dap_foreman_assis/operation/operation.dart';
import 'package:dap_foreman_assis/reports/reports.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  // @override
  // void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
  //   if (bloc is ReportsBloc) {
  //     // Only log if the bloc is ReportsBloc
  //     final stopwatch = Stopwatch()..start();
  //     super.onChange(bloc, change);
  //     stopwatch.stop();
  //     log('onChange(${bloc.runtimeType}, $change) took ${stopwatch.elapsedMilliseconds}ms\n');
  //   }
  // }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    // if (bloc is ReportsBloc || bloc is EditCubit) {
    // Only log if the bloc is ReportsBloc
    final stopwatch = Stopwatch()..start();
    super.onTransition(bloc, transition);
    stopwatch.stop();
    log('onTransition(${bloc.runtimeType}, $transition) took ${stopwatch.elapsedMilliseconds}ms\n');
    // }
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    if (bloc is ReportsBloc || bloc is EditCubit) {
      // Only log if the bloc is ReportsBloc
      super.onError(bloc, error, stackTrace);
      log('onError(${bloc.runtimeType}, $error, $stackTrace)\n');
    }
  }
}
