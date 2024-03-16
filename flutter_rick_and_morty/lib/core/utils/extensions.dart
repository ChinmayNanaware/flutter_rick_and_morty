import 'dart:ui';

import 'package:flutter/material.dart';

extension StringExtension on String? {
  toColor() {
    var hexColor = this!.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }

  bool isNullOrEmpty() => this == null || this == '' || this == "null";
}
