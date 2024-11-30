// ignore_for_file: lines_longer_than_80_chars

import 'dart:developer' show log;

import 'dart:developer';
import 'package:bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  // @override
  // void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
  //   final stopwatch = Stopwatch()..start();
  //   super.onEvent(bloc, event);
  //   stopwatch.stop();
  //   log('onEvent(${bloc.runtimeType}, $event) took ${stopwatch.elapsedMilliseconds}ms');
  // }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    final stopwatch = Stopwatch()..start();
    super.onChange(bloc, change);
    stopwatch.stop();
    log('onChange(${bloc.runtimeType}, $change) took ${stopwatch.elapsedMilliseconds}ms');
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    final stopwatch = Stopwatch()..start();
    super.onTransition(bloc, transition);
    stopwatch.stop();
    log('onTransition(${bloc.runtimeType}, $transition) took ${stopwatch.elapsedMilliseconds}ms');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
  }
}
