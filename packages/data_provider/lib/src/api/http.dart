import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Dio extended custom Http Client
class Http extends DioForNative {
  /// Construct a new Http
  Http({
    required String defaultBaseUrl,
    bool enableLogger = false,
  })  : _defaultBaseUrl = defaultBaseUrl,
        super(
          BaseOptions(
            baseUrl: defaultBaseUrl,
            connectTimeout: const Duration(milliseconds: 20000),
            receiveTimeout: const Duration(minutes: 1),
          ),
        ) {
    /// Add all interceptors
    interceptors.addAll([
      /// Token Interceptor

      /// Additional interceptor
      // const AlwaysAcceptApplicationJsonInterceptor(),

      /// Pretty logger interceptor
      if (enableLogger)
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
    ]);
  }

  /// Default base url
  final String _defaultBaseUrl;

  /// If given value is null default is used
  void updateBaseUrl(String? baseUrl) {
    options.baseUrl = baseUrl ?? _defaultBaseUrl;
  }
}
