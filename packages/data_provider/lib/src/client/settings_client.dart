import 'package:data_provider/data_provider.dart';

/// Settings Client
class SettingsClient {
  /// Constructor
  const SettingsClient({
    required Http httpClient,
  }) : _http = httpClient;
  final Http _http;

  ///Update base url of the app
  void updateBaseUrl(String baseUrl) => _http.updateBaseUrl(baseUrl);
}
