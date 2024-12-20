import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dap_foreman_assis/settings/settings.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required SettingsRepository settingsRepository,
  })  : _settingsRepository = settingsRepository,
        super(const SettingsState.initial()) {
    on<SettingsBaseUrlChanged>(_baseUrlChanged);
    on<SettingsDefaultSettingsRestored>(_onDefaultSettingsRestored);

    // initialize, get base url from storage
    // _settingsRepository
    //     .getBaseUrl()
    //     .then((value) => add(SettingsBaseUrlChanged(value)));
  }

  final SettingsRepository _settingsRepository;

  FutureOr<void> _baseUrlChanged(
    SettingsBaseUrlChanged event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: SettingsStatus.updating));
      await _settingsRepository.updateBaseUrl(event.baseUrl);
      emit(state.copyWith(
        status: SettingsStatus.updatingSucceeded,
        baseUrl: event.baseUrl != null ? BaseUrl.dirty(event.baseUrl!) : null,
      ));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: SettingsStatus.updatingFailure));
      addError(error, stackTrace);
    }
  }

  FutureOr<void> _onDefaultSettingsRestored(
    SettingsDefaultSettingsRestored event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: SettingsStatus.updating));
      await _settingsRepository.updateBaseUrl(null);
      emit(state.copyWith(status: SettingsStatus.updatingSucceeded));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: SettingsStatus.updatingFailure));
      addError(error, stackTrace);
    }
  }
}
