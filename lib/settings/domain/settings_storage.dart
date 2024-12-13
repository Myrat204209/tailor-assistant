// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dap_foreman_assis/settings/domain/domain.dart';
import 'package:dap_foreman_assis/settings/domain/settings_repository.dart';
import 'package:dap_foreman_assis/settings/settings.dart';
import 'package:storage/storage.dart';

/// Storage keys for the [SettingsStorage]

abstract class SettingsStorageKeys {
  static const String appSettingsBaseUrl = '__app_settings_base_url_key__';
}

/// {@template settings_storage}
/// Storage for the [SettingsRepository].
/// {@endtemplate}
class SettingsStorage {
  /// {@macro settings_storage}
  const SettingsStorage({
    required Storage storage,
  }) : _storage = storage;
  final Storage _storage;

  /// Sets the app base url
  Future<void> setAppBaseUrl(String baseUrl) async => _storage.write(
        key: SettingsStorageKeys.appSettingsBaseUrl,
        value: baseUrl,
      );

  /// Fetches the app base url
  Future<String?> fetchAppBaseUrl() async =>
      _storage.read(key: SettingsStorageKeys.appSettingsBaseUrl);

}
