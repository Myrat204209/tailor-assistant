import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final kAppOutlinedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15),
  borderSide: const BorderSide(color: AppColors.border),
);

/// Base App Theme
abstract class AppBaseTheme {
  const AppBaseTheme();

  /// Returns the primary `ThemeData` for the app
  ThemeData get themeData;

  /// Returns the `ColorScheme` for the theme
  ColorScheme get colorScheme;

  /// Shared Icon Theme
  IconThemeData get iconTheme => IconThemeData(color: colorScheme.onSurface);

  /// Shared Input Decoration Theme
  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
        border: kAppOutlinedBorder,
        focusedBorder: kAppOutlinedBorder,
        enabledBorder: kAppOutlinedBorder,
        // TODO: Try to understand what they want from you
        filled: true,
        contentPadding: EdgeInsets.zero,
        labelStyle: TextStyle(color: colorScheme.onSurface),
        hintStyle:
            TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.7)),
      );

  /// Shared Divider Theme
  DividerThemeData get dividerTheme => const DividerThemeData(
        color: AppColors.secondAccent,
        thickness: 1,
      );

  /// Restores your original `AppTextStyle` for the `TextTheme`
  TextTheme get textTheme => TextTheme(
        displayLarge: const AppTextStyle.text().pageTitleBold(),
        displayMedium: const AppTextStyle.text().pageTitle(),
        displaySmall: const AppTextStyle.text().contentTitle(),
        headlineMedium: const AppTextStyle.text().pageTitle(),
        headlineSmall: const AppTextStyle.text().contentTitle(),
        titleLarge: const AppTextStyle.text().titleBold(),
        titleMedium: const AppTextStyle.text().title(),
        titleSmall: const AppTextStyle.text().description(),
      );
}

/// Light Theme
class AppTheme extends AppBaseTheme {
  const AppTheme();

  @override
  ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.bgMain, // Distinct background color
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: colorScheme.surface, // Distinct app bar surface
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
        titleTextStyle: textTheme.titleLarge?.copyWith(fontFamily: 'Ubuntu'),
      ),
      textTheme: textTheme,
      iconTheme: iconTheme,
      inputDecorationTheme: inputDecorationTheme,
      // buttonTheme: buttonTheme,
      dividerTheme: dividerTheme,
    );
  }

  @override
  ColorScheme get colorScheme {
    return const ColorScheme.light(
      primary: AppColors.mainAccent,
      onPrimary: AppColors.secondAccent,
      secondary: AppColors.majorAccent,
      onSecondary: AppColors.majorLightAccent,
      error: AppColors.alertLightAccent,
      onError: AppColors.alertAccent,
      onSurface: AppColors.textColor,
      scrim: AppColors.bgMain,
      tertiary: AppColors.thirdAccent,
      onTertiary: AppColors.thirdLightAccent,
      outline: AppColors.textLight,
      shadow: AppColors.textLightTitle,
    );
  }
}

/// Dark Theme
class AppDarkTheme extends AppBaseTheme {
  const AppDarkTheme();

  @override
  ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor:
          AppColors.bgMainDark, // Distinct background color
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: colorScheme.surface, // Distinct app bar surface
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
        titleTextStyle: textTheme.titleLarge?.copyWith(fontFamily: 'Ubuntu'),
      ),
      textTheme: textTheme,
      iconTheme: iconTheme,
      inputDecorationTheme: inputDecorationTheme,
      // buttonTheme: buttonTheme,
      dividerTheme: dividerTheme,
    );
  }

  @override
  ColorScheme get colorScheme {
    return const ColorScheme.dark(
      primary: AppColors.mainAccentDark,
      onPrimary: AppColors.secondAccentDark,
      secondary: AppColors.majorAccentDark,
      onSecondary: AppColors.majorLightAccentDark,
      error: AppColors.alertLightAccentDark,
      onError: AppColors.alertAccentDark,
      onSurface: AppColors.textColorDark,
      surface: AppColors.bgSecondDark,
      scrim: AppColors.bgMainDark,
      tertiary: AppColors.thirdAccentDark,
      onTertiary: AppColors.thirdLightAccentDark,
      outline: AppColors.textLightDark,
      shadow: AppColors.textLightTitleDark,

    );
  }
}
