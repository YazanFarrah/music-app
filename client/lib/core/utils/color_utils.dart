import 'dart:math';

import 'package:flutter/material.dart';

String rgbToHex(Color color) {
  return '${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}';
}

Color hexToColor(String hex) {
  return Color(int.parse(hex, radix: 16) + 0xFF000000);
}

String generateRandomHexColor() {
  final random = Random();
  final color = Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
  return rgbToHex(color);
}

Color getColorBasedOnBackground(String hexColor) {
  final rgb = hexToColor(hexColor);

  final r = rgb.red / 255.0;
  final g = rgb.green / 255.0;
  final b = rgb.blue / 255.0;

  final luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b;

  // Threshold can be adjusted; typically around 0.5
  return luminance > 0.5 ? Colors.black87 : Colors.white;
}
