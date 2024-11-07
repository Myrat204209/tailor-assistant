import 'package:flutter/material.dart';

/// `AppColors` is a utility class that holds color constants 
/// for both Light and Dark modes to maintain color consistency 
/// across the app.
abstract class AppColors {
  /// Main accent color used throughout the app in Light Mode.
  /// Typically applied to buttons, icons, and primary UI elements.
  static const Color mainAccent = Color(0xFF6461F9);

  /// Main accent color used throughout the app in Dark Mode.
  /// Matches Light Mode's main accent but adapted for dark backgrounds.
  static const Color mainAccentDark = Color(0xFFA3A1FF);

  /// Secondary accent color for Light Mode.
  /// Used as a subtle complementary color for main accents.
  static const Color secondAccent = Color(0xFFE6E4FE);

  /// Secondary accent color for Dark Mode.
  /// Complements main accents with a darker tone.
  static const Color secondAccentDark = Color(0xFF4B49A6);

  /// Background color for primary surfaces in Light Mode.
  /// Typically used as a screen or main content background.
  static const Color bgMain = Color(0xFFF6F6FA);

  /// Background color for primary surfaces in Dark Mode.
  /// Used to match Light Mode's primary background for dark themes.
  static const Color bgMainDark = Color(0xFF2C2C34);

  /// Secondary background color in Light Mode.
  /// Used for cards, containers, and other secondary surfaces.
  static const Color bgSecond = Color(0xFFFFFFFF);

  /// Secondary background color in Dark Mode.
  /// Complements Dark Mode's main background with a slightly different shade.
  static const Color bgSecondDark = Color(0xFF3D3D44);

  /// Light alert background color in Light Mode.
  /// Used for backgrounds of alert or warning UI elements.
  static const Color alertLightAccent = Color(0xFFFFEDEF);

  /// Light alert background color in Dark Mode.
  /// Used for subtle alert backgrounds in dark themes.
  static const Color alertLightAccentDark = Color(0xFFC5B3B6);

  /// Major accent for light-colored alert backgrounds in Light Mode.
  /// Typically used for background of major alerts or notifications.
  static const Color majorLightAccent = Color(0xFFFFEFD9);

  /// Major accent for light-colored alert backgrounds in Dark Mode.
  static const Color majorLightAccentDark = Color(0xFFC5B8A5);

  /// Alert color used for text and icons in Light Mode.
  /// Ideal for error and critical warnings.
  static const Color alertAccent = Color(0xFFF11212);

  /// Alert color for Dark Mode.
  /// Used for icons and text in error or critical warning messages.
  static const Color alertAccentDark = Color(0xFFA31616);

  /// Primary text color for Light Mode.
  /// Typically used for body text and headings.
  static const Color textColor = Color(0xFF313131);

  /// Primary text color for Dark Mode.
  /// Adapts Light Mode's primary text color for dark backgrounds.
  static const Color textColorDark = Color(0xFFE1E1E1);

  /// Secondary text color for Light Mode.
  /// Used for less prominent text or placeholders.
  static const Color textLight = Color(0xFFB4B4B4);

  /// Secondary text color for Dark Mode.
  /// Complements Light Mode's secondary text color for dark themes.
  static const Color textLightDark = Color(0xFF8A8A8A);

  /// Light title text color for Light Mode.
  /// Typically used for subtitles and minor headings.
  static const Color textLightTitle = Color(0xFF797979);

  /// Light title text color for Dark Mode.
  static const Color textLightTitleDark = Color(0xFFA9A9A9);

  /// Border color for Light Mode.
  /// Used for dividers, outlines, and card borders.
  static const Color border = Color(0xFFDFE6EB);

  /// Major accent color in Light Mode.
  /// Often used to draw attention to important elements like buttons.
  static const Color majorAccent = Color(0xFFFF8B00);

  /// Major accent color in Dark Mode.
  static const Color majorAccentDark = Color(0xFFCC6E00);

  /// Tertiary accent color for Light Mode.
  /// Adds a cool accent to the app's color palette.
  static const Color thirdAccent = Color(0xFF078CE9);

  /// Tertiary accent color for Dark Mode.
  static const Color thirdAccentDark = Color(0xFF1A6FB0);

  /// Light variation of the tertiary accent in Light Mode.
  /// Used as a soft background or for hover effects.
  static const Color thirdLightAccent = Color(0xFFE4EEFE);

  /// Light variation of the tertiary accent in Dark Mode.
  static const Color thirdLightAccentDark = Color(0xFFB3BFD8);
}
