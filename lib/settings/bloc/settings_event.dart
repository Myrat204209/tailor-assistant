part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

final class SettingsBaseUrlChanged extends SettingsEvent {
  const SettingsBaseUrlChanged(this.baseUrl);
  final String? baseUrl;

  @override
  List<Object?> get props => [baseUrl];
}

final class SettingsSaveRequested extends SettingsEvent {}

final class SettingsDefaultSettingsRestored extends SettingsEvent {}
