class AppConstants {
  static const String groqApiBaseUrl = 'https://api.groq.com/openai/v1';
  static const String groqModelName = 'llama-3.3-70b-versatile';
  static const int requestTimeoutSeconds = 30;

  static const String appName = 'Medicine Analyzer';
  static const String appVersion = '1.0.0';

  static const String medicalDisclaimerText =
      'This information is for educational purposes only and does not replace medical advice. '
      'Always consult with a healthcare professional before making any health-related decisions.';

  static const int medicineLengthMax = 100;
  static const int conditionLengthMax = 100;

  static const Duration cacheDuration = Duration(hours: 24);

  static const String medicineNameRegex = r'^[a-zA-Z0-9\s\-()]*$';
  static const String conditionNameRegex = r'^[a-zA-Z0-9\s\-()]*$';
}
