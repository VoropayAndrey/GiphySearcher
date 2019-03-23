import 'package:flutter/material.dart';
import 'dart:math';


class ColorUtils {
  static Color getRandomColor({int alpha = 0xFF}) {
      return Color(Random().nextInt(0x00FFFFFF) | alpha << 24);
  }
}