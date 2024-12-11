part of 'settings_bloc.dart';

enum SettingsStatus {
  idle,

  updating,
  updatingFailure,
  updatingSucceeded,
}

final class SettingsState extends Equatable {
  const SettingsState({
    required this.status,
    this.baseUrl = const BaseUrl.pure('http://192.168.0.100:3000'),
  });
  const SettingsState.initial() : this(status: SettingsStatus.idle);
  final SettingsStatus status;
  final BaseUrl baseUrl;
  bool get isValid => Formz.validate([baseUrl]);

  @override
  List<Object> get props => [status, baseUrl];

  SettingsState copyWith({
    SettingsStatus? status,
    BaseUrl? baseUrl,
  }) {
    return SettingsState(
      status: status ?? this.status,
      baseUrl: baseUrl ?? this.baseUrl,
    );
  }
}
