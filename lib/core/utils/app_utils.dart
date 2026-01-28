import 'dart:io';
import 'package:flutter/foundation.dart';

class AppUtils {
  static bool isValidMedicineName(String name) {
    if (name.isEmpty || name.length > 100) return false;
    return RegExp(r'^[a-zA-Z0-9\s\-()]*$').hasMatch(name);
  }

  static bool isValidConditionName(String name) {
    if (name.isEmpty || name.length > 100) return false;
    return RegExp(r'^[a-zA-Z0-9\s\-()]*$').hasMatch(name);
  }

  static String sanitizeInput(String input) {
    return input.trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  static String formatText(String text) {
    return text.replaceAll('_', ' ').replaceAll('-', ' ');
  }

  static bool isAndroid() => !kIsWeb && Platform.isAndroid;

  static bool isIOS() => !kIsWeb && Platform.isIOS;

  static bool isWeb() => kIsWeb;

  static void log(String message, {String tag = 'AppUtils'}) {
    debugPrint('[$tag] $message');
  }

  static String getAppVersion() {
    return '1.0.0';
  }
}
