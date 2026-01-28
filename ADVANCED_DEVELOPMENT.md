# Medicine Analyzer - Advanced Development Guide

## 🎯 Extending the Application

This guide covers how to add new features and extend the Medicine Analyzer app.

## 🏗️ Adding a New Feature: Step-by-Step

### Example: Adding Medicine Interactions Check

#### Step 1: Create Domain Entity
**File**: `lib/domain/entities/medicine_interaction_entity.dart`

```dart
class MedicineInteractionEntity {
  final String medicine1;
  final String medicine2;
  final String interaction;
  final String severity; // low, medium, high
  final String recommendation;

  MedicineInteractionEntity({
    required this.medicine1,
    required this.medicine2,
    required this.interaction,
    required this.severity,
    required this.recommendation,
  });
}
```

#### Step 2: Create Data Model
**File**: `lib/data/models/medicine_interaction_model.dart`

```dart
import 'package:json_annotation/json_annotation.dart';

part 'medicine_interaction_model.g.dart';

@JsonSerializable()
class MedicineInteractionModel {
  final String medicine1;
  final String medicine2;
  final String interaction;
  final String severity;
  final String recommendation;

  MedicineInteractionModel({
    required this.medicine1,
    required this.medicine2,
    required this.interaction,
    required this.severity,
    required this.recommendation,
  });

  factory MedicineInteractionModel.fromJson(Map<String, dynamic> json) =>
      _$MedicineInteractionModelFromJson(json);

  Map<String, dynamic> toJson() => _$MedicineInteractionModelToJson(this);
}
```

#### Step 3: Add Repository Interface
**Update**: `lib/domain/repositories/medicine_analysis_repository.dart`

```dart
abstract class MedicineAnalysisRepository {
  // ... existing methods ...
  
  /// Check interaction between two medicines
  Future<MedicineInteractionEntity> checkMedicineInteraction(
    String medicine1,
    String medicine2,
  );
}
```

#### Step 4: Update Remote Data Source
**Update**: `lib/data/datasources/groq_remote_data_source.dart`

```dart
Future<MedicineInteractionModel> checkMedicineInteraction(
  String medicine1,
  String medicine2,
) async {
  try {
    final prompt = '''
    Check for drug interactions between:
    Medicine 1: $medicine1
    Medicine 2: $medicine2
    
    Return JSON: {
      "medicine1": "name",
      "medicine2": "name",
      "interaction": "description",
      "severity": "low/medium/high",
      "recommendation": "what to do"
    }
    ''';
    
    // Make API call
    // Parse and return response
  } catch (e) {
    rethrow;
  }
}
```

#### Step 5: Implement Repository
**Update**: `lib/data/repositories/medicine_analysis_repository_impl.dart`

```dart
@override
Future<MedicineInteractionEntity> checkMedicineInteraction(
  String medicine1,
  String medicine2,
) async {
  final model = await remoteDataSource.checkMedicineInteraction(
    medicine1,
    medicine2,
  );
  return _mapInteractionModelToEntity(model);
}

MedicineInteractionEntity _mapInteractionModelToEntity(
  MedicineInteractionModel model,
) {
  return MedicineInteractionEntity(
    medicine1: model.medicine1,
    medicine2: model.medicine2,
    interaction: model.interaction,
    severity: model.severity,
    recommendation: model.recommendation,
  );
}
```

#### Step 6: Create Provider
**File**: `lib/presentation/providers/interaction_providers.dart`

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/medicine_interaction_entity.dart';
import 'app_providers.dart';

final medicineInteractionProvider = 
  FutureProvider.family<MedicineInteractionEntity, (String, String)>(
    (ref, params) async {
      final (medicine1, medicine2) = params;
      final repository = ref.watch(medicineAnalysisRepositoryProvider);
      return repository.checkMedicineInteraction(medicine1, medicine2);
    },
  );
```

#### Step 7: Create UI Widget
**File**: `lib/presentation/widgets/interaction_checker_widget.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/interaction_providers.dart';

class MedicineInteractionChecker extends ConsumerStatefulWidget {
  const MedicineInteractionChecker({Key? key}) : super(key: key);

  @override
  ConsumerState<MedicineInteractionChecker> createState() =>
      _MedicineInteractionCheckerState();
}

class _MedicineInteractionCheckerState
    extends ConsumerState<MedicineInteractionChecker> {
  late TextEditingController _medicine1Controller;
  late TextEditingController _medicine2Controller;

  @override
  void initState() {
    super.initState();
    _medicine1Controller = TextEditingController();
    _medicine2Controller = TextEditingController();
  }

  void _checkInteraction() {
    final medicine1 = _medicine1Controller.text.trim();
    final medicine2 = _medicine2Controller.text.trim();
    
    if (medicine1.isEmpty || medicine2.isEmpty) return;

    // Trigger provider
    ref.read(medicineInteractionProvider((medicine1, medicine2)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _medicine1Controller,
          decoration: const InputDecoration(hintText: 'First Medicine'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _medicine2Controller,
          decoration: const InputDecoration(hintText: 'Second Medicine'),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: _checkInteraction,
          child: const Text('Check Interaction'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _medicine1Controller.dispose();
    _medicine2Controller.dispose();
    super.dispose();
  }
}
```

#### Step 8: Add to Page
**Update**: `lib/presentation/pages/home_page.dart`

```dart
// Add tab for interactions
if (_selectedTabIndex == 2)
  MedicineInteractionChecker()
```

## 📊 Database Integration (Future Enhancement)

When you need persistent storage beyond SharedPreferences:

### Using SQLite with sqflite

```dart
import 'package:sqflite/sqflite.dart';

class MedicineDatabase {
  static const String tableName = 'medicines';
  
  final Database _db;

  MedicineDatabase(this._db);

  Future<void> insertMedicine(MedicineAnalysisModel medicine) async {
    await _db.insert(
      tableName,
      medicine.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<MedicineAnalysisModel>> getMedicines() async {
    final result = await _db.query(tableName);
    return result
        .map((json) => MedicineAnalysisModel.fromJson(json))
        .toList();
  }
}
```

## 🔄 Real-time Updates with WebSockets

```dart
// In groq_remote_data_source.dart
Stream<String> streamMedicineAnalysis(String medicineName) async* {
  // Implement streaming response from Groq API
  // Yield chunks of data as they arrive
}
```

## 🎯 Adding Camera Integration

### Medicine Scanning Feature

```dart
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class MedicineScannerService {
  final TextRecognizer _textRecognizer = TextRecognizer();

  Future<String> extractMedicineNameFromImage(
    XFile imageFile,
  ) async {
    final inputImage = InputImage.fromFilePath(imageFile.path);
    final recognizedText = await _textRecognizer.processImage(inputImage);
    
    // Process and extract medicine name
    return _extractMedicineName(recognizedText.text);
  }

  String _extractMedicineName(String text) {
    // Implement name extraction logic
    return text;
  }
}
```

## 🌐 Internationalization (i18n)

Add multi-language support:

**Create**: `lib/core/localization/app_localizations.dart`

```dart
import 'package:intl/intl.dart';

class AppLocalizations {
  static String getLanguageName(String languageCode) {
    return Intl.defaultLocale = languageCode;
  }

  // Add language-specific strings
  static const Map<String, Map<String, String>> translations = {
    'en': {
      'search_medicine': 'Search Medicine',
      'check_condition': 'Check Condition',
    },
    'es': {
      'search_medicine': 'Buscar Medicina',
      'check_condition': 'Verificar Condición',
    },
  };
}
```

## 📈 Analytics Integration

```dart
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future<void> logMedicineSearch(String medicineName) async {
    await _analytics.logEvent(
      name: 'medicine_search',
      parameters: {
        'medicine_name': medicineName,
        'timestamp': DateTime.now().toString(),
      },
    );
  }

  Future<void> logConditionSearch(String condition) async {
    await _analytics.logEvent(
      name: 'condition_search',
      parameters: {
        'condition': condition,
        'timestamp': DateTime.now().toString(),
      },
    );
  }
}
```

## 🔐 Authentication & User Profiles

```dart
// User authentication layer
class AuthService {
  Future<bool> login(String email, String password) async {
    // Implement Firebase Auth or custom auth
    return true;
  }

  Future<UserProfile> getUserProfile() async {
    // Fetch user profile
    return UserProfile();
  }

  Future<void> saveUserPreferences(UserPreferences prefs) async {
    // Save in secure storage
  }
}
```

## 📲 Push Notifications

```dart
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    NotificationSettings settings = 
      await _firebaseMessaging.requestPermission();
    
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle notification
    });
  }

  Future<void> sendMedicineReminder(String medicineName) async {
    // Send reminder notification
  }
}
```

## 🧪 Testing Strategy

### Unit Tests
```dart
// test/repositories/medicine_analysis_repository_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('MedicineAnalysisRepository', () {
    late MedicineAnalysisRepository repository;

    setUp(() {
      // Setup test instance
    });

    test('getMedicineAnalysis returns valid entity', () async {
      final result = await repository.getMedicineAnalysis('Aspirin');
      expect(result.name, 'Aspirin');
    });
  });
}
```

### Integration Tests
```dart
// test_driver/app_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Tests', () {
    testWidgets('Search medicine flow', (WidgetTester tester) async {
      // Test complete user flow
    });
  });
}
```

## 🚀 Performance Optimization

### Caching Strategies
```dart
class CacheManager {
  final Duration _cacheDuration = Duration(hours: 24);
  final Map<String, CachedValue> _cache = {};

  Future<T> get<T>({
    required String key,
    required Future<T> Function() fetch,
  }) async {
    if (_cache.containsKey(key)) {
      final cached = _cache[key]!;
      if (!cached.isExpired) {
        return cached.value as T;
      }
    }

    final value = await fetch();
    _cache[key] = CachedValue(value, DateTime.now());
    return value;
  }
}
```

## 📚 Resource Links

- [Flutter Best Practices](https://flutter.dev/docs/testing/best-practices)
- [Riverpod Advanced](https://riverpod.dev/docs/introduction)
- [Groq API Docs](https://console.groq.com/docs)
- [Firebase Integration](https://firebase.flutter.dev)
- [SQLite Flutter](https://pub.dev/packages/sqflite)

---

**Happy coding! Build amazing health applications responsibly.** ❤️
