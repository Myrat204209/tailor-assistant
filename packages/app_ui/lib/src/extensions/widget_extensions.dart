import 'package:flutter/material.dart';

/// Padding extensions
extension WidgetPaddingX on Widget {
  /// Pads the widget on all sides with the given [padding].
  ///
  /// [padding] is the amount of padding to apply to all sides of the widget.
  ///
  /// The returned widget is a [Padding] widget with the given [padding] and
  /// the original widget as its child.
  Widget paddingAll(double padding) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );

  /// Pads the widget symmetrically with the given [horizontal]
  /// and [vertical] padding.
  ///
  /// [horizontal] is the amount of padding to apply to the left
  /// and right sides of the widget.
  ///
  /// [vertical] is the amount of padding to apply to the top and
  ///  bottom sides of the widget.
  ///
  /// The returned widget is a [Padding] widget with the given
  ///  [horizontal] and [vertical]
  /// padding and the original widget as its child.
  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  /// Pads the widget with specified padding for each side.
  ///
  /// [left] is the amount of padding to apply to the left side of the widget.
  ///
  /// [top] is the amount of padding to apply to the top side of the widget.
  ///
  /// [right] is the amount of padding to apply to the right side of the widget.
  ///
  /// [bottom] is the amount of padding to apply to the bottom
  /// side of the widget.
  ///
  /// The returned widget is a [Padding] widget
  ///  configured with [EdgeInsets.only]
  /// using the specified padding values and the original widget as its child.
  Widget paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          left: left,
          top: top,
          right: right,
          bottom: bottom,
        ),
        child: this,
      );
}

/// ALignment extensions
extension WidgetCenterX on Widget {
  /// Wrap the widget in a [Center] widget.
  Widget centralize() => Center(child: this);
}

/// Colorize Widget
extension WidgetColorX on Widget {
  /// Wrap the widget in a [ColoredBox] widget.
  Widget colorize(Color color) => ColoredBox(
        color: color,
        child: this,
      );
}

/// Clipper
extension WidgetClipperX on Widget {
  /// Clip the widget with a circular border radius.
  ///
  /// The [radius] parameter is the radius of the circular border.
  ///
  /// The returned widget is a [ClipRRect] widget with the given [radius]
  /// and the original widget as its child.
  //
  Widget clipper(double radius) => ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: this,
      );

  /// Clip the widget with a circular border radius.
  Widget clipperOnly(double radius) => ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        ),
        child: this,
      );

  /// Clip the widget with a circular border radius.
  Widget clipperSymmetric(double radius) => ClipRRect(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(radius),
        ),
        child: this,
      );
}
