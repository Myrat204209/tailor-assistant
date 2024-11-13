import 'package:flutter/material.dart';

/// Padding extensions
extension WidgetPaddingX on Widget {
  Widget paddingAll(double padding) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );
  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );
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
  Widget centralize() => Center(child: this);
}

/// Colorize Widget
extension WidgetColorX on Widget {
  Widget colorize(Color color) => ColoredBox(
        color: color,
        child: this,
      );
}

extension WidgetClipperX on Widget {
  Widget clipper(double radius) => ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: this,
      );
  Widget clipperOnly(double radius) => ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        ),
        child: this,
      );
  Widget clipperSymmetric(double radius) => ClipRRect(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(radius),
        ),
        child: this,
      );
}
