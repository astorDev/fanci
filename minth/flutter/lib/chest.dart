import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration get transparent {
    return const InputDecoration(
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
    );
  }
}