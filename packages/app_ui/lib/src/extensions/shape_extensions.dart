import 'package:flutter/material.dart';

extension ShapeBorderX on ShapeBorder {
  static ShapeBorder roundedRectangle(double radius, [Color? color]) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
      side: color != null ? BorderSide(color: color) : BorderSide.none,
    );
  }

  static ShapeBorder roundedVertical(double radius, [Color? color]) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
      side: color != null ? BorderSide(color: color) : BorderSide.none,
    );
  }

  static ShapeBorder continousRectangle(double radius, [Color? color]) {
    return ContinuousRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
      side: color != null ? BorderSide(color: color) : BorderSide.none,
    );
  }
}
