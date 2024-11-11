// ignore_for_file: lines_longer_than_80_chars

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// {@template dap_theme}
/// The Default App [ThemeData].
/// {@endtemplate}
class AppTheme {
  /// {@macro dap_theme}
  const AppTheme();

  /// Default `ThemeData` for App UI.
  ThemeData get themeData {
    return ThemeData(
      // canvasColor: _backgroundColor,
      useMaterial3: true,
      scaffoldBackgroundColor: _backgroundColor,
      appBarTheme: _appBarTheme,
      textTheme: _textTheme,
      colorScheme: _colorScheme,
    );
  }

  ColorScheme get _colorScheme {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.mainAccent,
      onPrimary: AppColors.bgSecond,
      secondary: AppColors.secondAccent,
      onSecondary: AppColors.alertAccent,
      error: AppColors.secondAccent,
      onError: AppColors.alertAccent,
      surface: AppColors.bgMain,
      onSurface: AppColors.textColor,
      tertiary: AppColors.thirdLightAccent,
    );
  }

  Color get _backgroundColor => AppColors.bgMain;

  AppBarTheme get _appBarTheme {
    return AppBarTheme(
      titleTextStyle: const AppTextStyle.text().headline5().regular().copyWith(
            fontFamily: 'Ubuntu',
            color: AppColors.textColor,
          ),
      scrolledUnderElevation: 0,
      elevation: 0,
      toolbarHeight: 70,
      backgroundColor: AppColors.bgSecond,
      // systemOverlayStyle: const SystemUiOverlayStyle(
      //   statusBarIconBrightness: Brightness.dark,
      //   statusBarBrightness: Brightness.light,
      // ),
    );
  }

  TextTheme get _textTheme => uiTextTheme;

  /// The UI text theme based on [AppTextStyle].
  static final uiTextTheme = TextTheme(
    displayLarge: const AppTextStyle.text().headline1(),
    displayMedium: const AppTextStyle.text().headline2(),
    displaySmall: const AppTextStyle.text().headline3(),
    headlineMedium: const AppTextStyle.text().headline4(),
    headlineSmall: const AppTextStyle.text().headline5(),
    titleLarge: const AppTextStyle.text().headline6(),
    titleMedium: const AppTextStyle.text().subtitle1(),
    titleSmall: const AppTextStyle.text().subtitle2(),
    bodyLarge: const AppTextStyle.text().bodyText1(),
    bodyMedium: const AppTextStyle.text().bodyText2(),
    labelLarge: const AppTextStyle.text().button(),
    bodySmall: const AppTextStyle.text().caption(),
    labelSmall: const AppTextStyle.text().overline(),
  ).apply();
}

/// {@template app_dark_theme}
/// Dark Mode App [ThemeData].
/// {@endtemplate}
class AppDarkTheme extends AppTheme {
  /// {@macro app_dark_theme}
  const AppDarkTheme();

  @override
  ColorScheme get _colorScheme {
    return const ColorScheme.dark().copyWith(
      brightness: Brightness.dark,
      primary: AppColors.mainAccentDark,
      onPrimary: AppColors.majorAccentDark,
      secondary: AppColors.secondAccentDark,
      onSecondary: AppColors.alertAccentDark,
      error: AppColors.secondAccentDark,
      onError: AppColors.alertAccentDark,
      surface: AppColors.bgMainDark,
      onSurface: AppColors.mainAccentDark,
      tertiary: AppColors.thirdLightAccentDark,
    );
  }

  // @override
  // TextTheme get _textTheme {
  //   return AppTheme.contentTextTheme.apply(
  //     bodyColor: AppColors.white,
  //     displayColor: AppColors.white,
  //     decorationColor: AppColors.white,
  //   );
  // }

  // @override
  // SnackBarThemeData get _snackBarTheme {
  //   return SnackBarThemeData(
  //     contentTextStyle: UITextStyle.bodyText1.copyWith(
  //       color: AppColors.black,
  //     ),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(AppSpacing.sm),
  //     ),
  //     actionTextColor: AppColors.lightBlue.shade300,
  //     backgroundColor: AppColors.grey.shade300,
  //     elevation: 4,
  //     behavior: SnackBarBehavior.floating,
  //   );
  // }

  // @override
  // TextButtonThemeData get _textButtonTheme {
  //   return TextButtonThemeData(
  //     style: TextButton.styleFrom(
  //       textStyle: _textTheme.labelLarge?.copyWith(
  //         fontWeight: AppFontWeight.light,
  //       ),
  //       foregroundColor: AppColors.white,
  //     ),
  //   );
  // }

  @override
  Color get _backgroundColor => AppColors.bgMainDark;

  // @override
  // IconThemeData get _iconTheme {
  //   return const IconThemeData(color: AppColors.white);
  // }

  // @override
  // DividerThemeData get _dividerTheme {
  //   return const DividerThemeData(
  //     color: AppColors.onBackground,
  //     space: AppSpacing.lg,
  //     thickness: AppSpacing.xxxs,
  //     indent: AppSpacing.lg,
  //     endIndent: AppSpacing.lg,
  //   );
  // }
}
