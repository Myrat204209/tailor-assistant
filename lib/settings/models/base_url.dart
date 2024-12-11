import 'package:formz/formz.dart';

/// BaseUrl Form Input Validation Error
enum BaseUrlValidationError {
  /// If baseUrl is empty
  empty,

  /// BaseUrl is invalid (generic validation error)
  invalid,
}

/// {@template BaseUrl}
/// Reusable baseUrl form input.
/// {@endtemplate}
class BaseUrl extends FormzInput<String, BaseUrlValidationError> {
  /// {@macro BaseUrl}
  const BaseUrl.pure([super.value = '']) : super.pure();

  /// {@macro BaseUrl}
  const BaseUrl.dirty([super.value = '']) : super.dirty();

  @override
  BaseUrlValidationError? validator(String value) {
    if (value.isEmpty) return BaseUrlValidationError.empty;

    final uri = Uri.tryParse('http://$value');
    final isUrl = uri != null && uri.hasScheme && uri.host.isNotEmpty;

    if (!isUrl) return BaseUrlValidationError.invalid;

    return null;
  }
}
