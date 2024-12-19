import 'package:dap_foreman_assis/settings/settings.dart';
import 'package:data_provider/data_provider.dart';

sealed class SettingsException implements Exception {
  const SettingsException(this.error);
  final Object error;
}

/// UpdateBaseUrlFailure

final class UpdateBaseUrlFailure extends SettingsException {
  const UpdateBaseUrlFailure(super.error);
}

/// GetBaseUrlFailure
final class GetBaseUrlFailure extends SettingsException {
  const GetBaseUrlFailure(super.error);
}

final class SettingsRepository {
  SettingsRepository({
    required String defaultBaseUrl,
    required SettingsStorage settingsStorage,
    required SettingsClient settingsClient,
  })  : _defaultBaseUrl = defaultBaseUrl,
        _settingsStorage = settingsStorage,
        _settingsClient = settingsClient {
    // getBaseUrl().then(updateBaseUrl);
  }

  final String _defaultBaseUrl;
  final SettingsStorage _settingsStorage;
  final SettingsClient _settingsClient;

  /// Update base url of the app in the storage
  Future<void> updateBaseUrl(String? baseUrl) async {
    try {
      _settingsClient.updateBaseUrl(baseUrl ?? _defaultBaseUrl);
      await _settingsStorage.setAppBaseUrl(baseUrl ?? _defaultBaseUrl);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(UpdateBaseUrlFailure(error), stackTrace);
    }
  }

  /// Get base url of the app from the storage
  Future<String> getBaseUrl() async {
    try {
      return await _settingsStorage.fetchAppBaseUrl() ?? _defaultBaseUrl;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(GetBaseUrlFailure(error), stackTrace);
    }
  }
}
