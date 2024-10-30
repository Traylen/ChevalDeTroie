import 'package:flutter/material.dart';

class Constants {
  static OutlineInputBorder input_enabled = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Color(0xFFa1a1a1),
      ));
  static OutlineInputBorder input_active = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Color(0xFF396ce7),
      ));
}
