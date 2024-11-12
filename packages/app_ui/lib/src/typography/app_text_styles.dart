import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

/// The app consists of two main text style definitions: Display and Text.
enum AppTextType {
  /// All big sized text types or headline etc.
  display,

  /// Normal sized text defination or default text
  text,
}

/// The app consists of two main text style definitions: Display and Text.
///
/// Content text style is primarily used for all content-based components,
/// e.g. news feed including articles and sections, while the UI text style
/// is used for the rest of UI components.
///
// ignore: comment_references
/// The default app's [TextTheme] is [AppTheme.uiTextTheme].

/// UI Display Text Style Definitions
///
/// ```dart
/// AppTextStyle.display().xxl().semibold();
/// AppTextStyle.display().xl().regular();
/// AppTextStyle.text().lg().bold();
/// AppTextStyle.text().md().medium();
/// ```
class AppTextStyle extends TextStyle {
  /// Constructor
  const AppTextStyle({
    required this.textType,
    super.fontSize,
    super.fontWeight,
    this.lineHeight,
    double? height,
    super.letterSpacing,
    super.color = AppColors.textColor,
  }) : super(
          package: 'app_ui',
          fontFamily: 'Ubuntu',
          decoration: TextDecoration.none,
          textBaseline: TextBaseline.alphabetic,
          height: height ??
              (lineHeight == null ? null : lineHeight / (fontSize ?? 14)),
          // leadingDistribution: TextLeadingDistribution.even,
        );

  /// Typography default text style
  const AppTextStyle.text({
    Color? color,
    double? fontSize,
  }) : this(
          textType: AppTextType.text,
          color: color,
          fontSize: fontSize,
        );

  /// Typography display text style
  const AppTextStyle.display({
    Color? color,
    double? fontSize,
  }) : this(
          textType: AppTextType.display,
          color: color,
          fontSize: fontSize,
        );

  /// Is text display styled from typography
  final AppTextType textType;

  /// Text line height in pixels
  final double? lineHeight;

  /// Custom copyWith
  AppTextStyle _copyWith({
    double? fontSize,
    FontWeight? fontWeight,
    double? lineHeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return AppTextStyle(
      textType: textType,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      lineHeight: lineHeight ?? this.lineHeight,
      color: color ?? this.color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  /// Change only color
  AppTextStyle withColor(Color? color) => _copyWith(color: color);

  /// Change only font size
  AppTextStyle withFontSize(double? fontSize) => _copyWith(fontSize: fontSize);

  /// Change only line height
  AppTextStyle withLineHeight(double? lineHeight) =>
      _copyWith(lineHeight: lineHeight);
}

/// App text style sizes like: extra large, large, medium, small, extra small
///
/// Size variants extension
extension AppTextStyleSizeExtension on AppTextStyle {
  /// `Size` - xxl (double extra large)
  ///
  ///  * display - `fontSize`: 72, `lineHeight`: 90
  ///  * text - default
  AppTextStyle xxl() => switch (textType) {
        AppTextType.display => _copyWith(fontSize: 72, lineHeight: 90),
        AppTextType.text => _copyWith(fontSize: 24, lineHeight: 32),
      };

  /// `Size` - xl (extra large)
  ///
  ///  * display - `fontSize`: 60, `lineHeight`: 72
  ///  * text - `fontSize`: 20, `lineHeight`: 30
  AppTextStyle xl() => switch (textType) {
        AppTextType.display => _copyWith(fontSize: 60, lineHeight: 72),
        AppTextType.text => _copyWith(fontSize: 20, lineHeight: 30),
      };

  /// `Size` - lg (large)
  ///
  ///  * display - `fontSize`: 48, `lineHeight`: 60
  ///  * text - `fontSize`: 18, `lineHeight`: 28
  AppTextStyle lg() => switch (textType) {
        AppTextType.display => _copyWith(fontSize: 48, lineHeight: 60),
        AppTextType.text => _copyWith(fontSize: 18, lineHeight: 28),
      };

  /// `Size` - md (middle)
  ///
  ///  * display - `fontSize`: 36, `lineHeight`: 44
  ///  * text - `fontSize`: 16, `lineHeight`: 24
  AppTextStyle md() => switch (textType) {
        AppTextType.display => _copyWith(fontSize: 36, lineHeight: 44),
        AppTextType.text => _copyWith(fontSize: 16, lineHeight: 24),
      };

  /// `Size` - sm (small)
  ///
  ///  * display - `fontSize`: 30, `lineHeight`: 38
  ///  * text - `fontSize`: 14, `lineHeight`: 20
  AppTextStyle sm() => switch (textType) {
        AppTextType.display => _copyWith(fontSize: 30, lineHeight: 38),
        AppTextType.text => _copyWith(fontSize: 14, lineHeight: 20),
      };

  /// `Size` - xs (extra small)
  ///
  ///  * display - `fontSize`: 24, `lineHeight`: 32
  ///  * text - `fontSize`: 12, `lineHeight`: 18
  AppTextStyle xs() => switch (textType) {
        AppTextType.display => _copyWith(fontSize: 24, lineHeight: 32),
        AppTextType.text => _copyWith(fontSize: 12, lineHeight: 18),
      };
}

/// App text style font weight variants extension
extension AppTextStyleFontWeightExtension on AppTextStyle {
  /// Font weight to regular - FontWeight.w400
  AppTextStyle regular() => _copyWith(fontWeight: AppFontWeight.regular);

  /// Font weight to medium - FontWeight.w500
  AppTextStyle medium() => _copyWith(fontWeight: AppFontWeight.medium);

  /// Font weight to semiBold - FontWeight.w600
  AppTextStyle semiBold() => _copyWith(fontWeight: AppFontWeight.semiBold);

  /// Font weight to bold - FontWeight.w700
  AppTextStyle bold() => _copyWith(fontWeight: AppFontWeight.bold);
}

/// Material typography
extension AppTextStyleMaterialExtension on AppTextStyle {
  /// Title Text Style
  AppTextStyle title() => _copyWith(
        fontSize: 16,
        fontWeight: AppFontWeight.regular,
        height: 1.22,
      );

  /// Description Text Style
  AppTextStyle description() => _copyWith(
        fontSize: 14,
        fontWeight: AppFontWeight.regular,
      );

  /// Page Title Text Style
  AppTextStyle pageTitle() => _copyWith(
        fontSize: 22,
        fontWeight: AppFontWeight.regular,
      );

  /// Page Title Text Style
  AppTextStyle contentTitle() => _copyWith(
        fontSize: 20,
        fontWeight: AppFontWeight.regular,
      );

  /// Title Bold Text Style
  AppTextStyle titleBold() => _copyWith(
        fontSize: 16,
        fontWeight: AppFontWeight.bold,
      );

  /// Page Title Bold Text Style
  AppTextStyle pageTitleBold() => _copyWith(
        fontSize: 20,
        fontWeight: AppFontWeight.bold,
      );
}
