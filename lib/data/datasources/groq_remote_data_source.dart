import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../core/constants/app_constants.dart';
import '../models/medicine_analysis_model.dart';
import '../models/condition_analysis_model.dart';

class GroqRemoteDataSource {
  final Dio _dio;
  late final String _apiKey;

  GroqRemoteDataSource({required Dio dio}) : _dio = dio {
    _apiKey =
        dotenv.env['GROQ_API_KEY'] ??
        '';
    if (_apiKey.isEmpty) {
      print('⚠️  WARNING: GROQ_API_KEY not set. Using default key.');
    } else {
      print('✅ API Key loaded successfully (${_apiKey.substring(0, 20)}...)');
    }
    _setupDio();
  }

  void _setupDio() {
    _dio.options = BaseOptions(
      baseUrl: AppConstants.groqApiBaseUrl,
      connectTimeout: const Duration(
        seconds: AppConstants.requestTimeoutSeconds,
      ),
      receiveTimeout: const Duration(
        seconds: AppConstants.requestTimeoutSeconds,
      ),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
    );
  }

  Future<MedicineAnalysisModel> analyzeMedicine(String medicineName) async {
    try {
      print('🔍 Starting medicine analysis for: $medicineName');
      print('🔑 API Key present: ${_apiKey.isNotEmpty}');

      final prompt =
          '''Provide detailed medical information about $medicineName. Return a JSON object with these exact fields:
- name
- whyToTake (object with: description, benefits array)
- whenToTake (object with: timing, frequency, beforeFood boolean, afterFood boolean)
- howToTake (object with: formType, instructions)
- dosageGuidance (object with: adultDosage, pediatricDosage, geriatricDosage)
- sideEffects (object with: commonSideEffects array, seriousSideEffects array)
- whoShouldAvoid (object with: conditions array, allergies array, interactions array)
- foodLifestyle (object with: recommendedFoods array, foodsToAvoid array, lifestyle array)

Return ONLY valid JSON, nothing else.''';

      print('📤 Sending request to Groq API...');
      final response = await _dio.post(
        '/chat/completions',
        data: {
          'model': AppConstants.groqModelName,
          'messages': [
            {'role': 'user', 'content': prompt},
          ],
          'temperature': 0.3,
          'max_tokens': 2000,
        },
      );

      print('📥 Response Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        try {
          final content = response.data['choices'][0]['message']['content'];
          print('📝 Response Content: ${content.substring(0, 100)}...');

          final jsonString = _extractJson(content);
          print('🔄 Extracted JSON: ${jsonString.substring(0, 100)}...');

          var jsonMap = _parseJsonString(jsonString);
          
          jsonMap = _sanitizeMedicineJson(jsonMap);

          final medicineData = MedicineAnalysisModel.fromJson(jsonMap);
          print('✅ Successfully parsed medicine data');
          return medicineData;
        } catch (parseError) {
          print('❌ Parse Error: $parseError');
          rethrow;
        }
      } else {
        print('❌ API Error: Status ${response.statusCode}');
        print('Response: ${response.data}');
        throw Exception('Failed to analyze medicine: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ Dio Error: ${e.message}');
      print('Type: ${e.type}');
      print('Response: ${e.response?.data}');
      print('Status Code: ${e.response?.statusCode}');
      print('Error Message: ${e.error}');

      String errorMessage = 'Network Error';
      if (e.response?.data != null && e.response!.data is Map) {
        final errorData = e.response!.data;
        if (errorData['error'] != null) {
          if (errorData['error'] is Map) {
             errorMessage = errorData['error']['message'] ?? errorData['error'].toString();
          } else {
             errorMessage = errorData['error'].toString();
          }
        }
      } else if (e.message != null && e.message!.isNotEmpty) {
        errorMessage = e.message!;
      } else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Connection timeout - Server took too long to respond';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'Receive timeout - No response from server';
      } else if (e.type == DioExceptionType.unknown) {
        errorMessage = 'Connection error - Check your internet connection';
      }
      throw Exception(errorMessage);
    } catch (e) {
      print('❌ Unexpected Error: $e');
      rethrow;
    }
  }

  Future<ConditionAnalysisModel> analyzeCondition(String condition) async {
    try {
      print('🔍 Starting condition analysis for: $condition');

      final prompt =
          '''
      Analyze the following health condition and provide dietary and lifestyle guidance in JSON format:
      {
        "condition": "condition name",
        "recommendedFoods": ["food1", "food2", "food3"],
        "foodsToAvoid": ["avoid1", "avoid2", "avoid3"],
        "helpfulHabits": ["habit1", "habit2", "habit3"],
        "whenToSeeDr": "symptoms or situations when professional medical advice should be sought"
      }
      
      Analyze this condition: $condition
      Return ONLY valid JSON, no other text.
      '''
              .trim();

      print('📤 Sending request to Groq API...');
      final response = await _dio.post(
        '/chat/completions',
        data: {
          'model': AppConstants.groqModelName,
          'messages': [
            {'role': 'user', 'content': prompt},
          ],
          'temperature': 0.3,
          'max_tokens': 1500,
        },
      );

      print('📥 Response Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        try {
          final content = response.data['choices'][0]['message']['content'];
          print('📝 Response Content: ${content.substring(0, 100)}...');

          final jsonString = _extractJson(content);
          print('🔄 Extracted JSON: ${jsonString.substring(0, 100)}...');

          var jsonMap = _parseJsonString(jsonString);
          
          jsonMap = _sanitizeConditionJson(jsonMap);

          final conditionData = ConditionAnalysisModel.fromJson(jsonMap);
          print('✅ Successfully parsed condition data');
          return conditionData;
        } catch (parseError) {
          print('❌ Parse Error: $parseError');
          rethrow;
        }
      } else {
        print('❌ API Error: Status ${response.statusCode}');
        print('Response: ${response.data}');
        throw Exception('Failed to analyze condition: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ Dio Error: ${e.message}');
      print('Type: ${e.type}');
      print('Response: ${e.response?.data}');
      throw Exception('Network Error: ${e.message}');
    } catch (e) {
      print('❌ Unexpected Error: $e');
      rethrow;
    }
  }

  String _extractJson(String text) {
    final jsonStartIndex = text.indexOf('{');
    final jsonEndIndex = text.lastIndexOf('}');

    if (jsonStartIndex == -1 || jsonEndIndex == -1) {
      throw Exception('Invalid JSON response from API');
    }

    return text.substring(jsonStartIndex, jsonEndIndex + 1);
  }

  Map<String, dynamic> _parseJsonString(String jsonString) {
    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to parse JSON: $e');
    }
  }

  Map<String, dynamic> _sanitizeMedicineJson(Map<String, dynamic> json) {
    final sanitized = Map<String, dynamic>.from(json);

    List<dynamic> ensureList(dynamic val) {
      if (val == null) return [];
      if (val is List) return val;
      return [];
    }

    String ensureString(dynamic val, [String defaultVal = '']) {
      if (val == null) return defaultVal;
      return val.toString();
    }
    
    sanitized['name'] = ensureString(sanitized['name'], 'Unknown Medicine');
    sanitized['missedDoseGuidance'] = ensureString(sanitized['missedDoseGuidance']);
    sanitized['storageInstructions'] = ensureString(sanitized['storageInstructions']);
    sanitized['alternativeMedicines'] = ensureList(sanitized['alternativeMedicines']);

    if (sanitized['alternativeMedicines'] is List) {
       sanitized['alternativeMedicines'] = (sanitized['alternativeMedicines'] as List).map((e) {
         if (e is Map) {
           final m = Map<String, dynamic>.from(e);
           m['name'] = ensureString(m['name']);
           m['purpose'] = ensureString(m['purpose']);
           return m;
         }
         return {'name': '', 'purpose': ''};
       }).toList();
    }

    if (sanitized['whyToTake'] is Map) {
      final whyToTake = Map<String, dynamic>.from(sanitized['whyToTake']);
      whyToTake['description'] = ensureString(whyToTake['description']);
      whyToTake['benefits'] = ensureList(whyToTake['benefits']);
      sanitized['whyToTake'] = whyToTake;
    } else {
        sanitized['whyToTake'] = {'description': '', 'benefits': []};
    }

    if (sanitized['whenToTake'] is Map) {
        final whenToTake = Map<String, dynamic>.from(sanitized['whenToTake']);
        whenToTake['timing'] = ensureString(whenToTake['timing']);
        whenToTake['frequency'] = ensureString(whenToTake['frequency']);
        sanitized['whenToTake'] = whenToTake;
    } else {
        sanitized['whenToTake'] = {'timing': '', 'frequency': '', 'beforeFood': false, 'afterFood': false};
    }
    
    if (sanitized['howToTake'] is Map) {
        final howToTake = Map<String, dynamic>.from(sanitized['howToTake']);
        howToTake['formType'] = ensureString(howToTake['formType']);
        howToTake['instructions'] = ensureString(howToTake['instructions']);
        sanitized['howToTake'] = howToTake;
    } else {
        sanitized['howToTake'] = {'formType': '', 'instructions': ''};
    }

    if (sanitized['dosageGuidance'] is Map) {
        final dosage = Map<String, dynamic>.from(sanitized['dosageGuidance']);
        dosage['adultDosage'] = ensureString(dosage['adultDosage']);
        dosage['pediatricDosage'] = ensureString(dosage['pediatricDosage']);
        dosage['geriatricDosage'] = ensureString(dosage['geriatricDosage']);
        sanitized['dosageGuidance'] = dosage;
    } else {
        sanitized['dosageGuidance'] = {'adultDosage': '', 'pediatricDosage': '', 'geriatricDosage': ''};
    }

    if (sanitized['sideEffects'] is Map) {
      final sideEffects = Map<String, dynamic>.from(sanitized['sideEffects']);
      sideEffects['commonSideEffects'] = ensureList(sideEffects['commonSideEffects']);
      sideEffects['seriousSideEffects'] = ensureList(sideEffects['seriousSideEffects']);
      sanitized['sideEffects'] = sideEffects;
    } else {
         sanitized['sideEffects'] = {'commonSideEffects': [], 'seriousSideEffects': []};
    }

    if (sanitized['whoShouldAvoid'] is Map) {
      final whoShouldAvoid = Map<String, dynamic>.from(sanitized['whoShouldAvoid']);
      whoShouldAvoid['conditions'] = ensureList(whoShouldAvoid['conditions']);
      whoShouldAvoid['allergies'] = ensureList(whoShouldAvoid['allergies']);
      whoShouldAvoid['interactions'] = ensureList(whoShouldAvoid['interactions']);
      sanitized['whoShouldAvoid'] = whoShouldAvoid;
    } else {
        sanitized['whoShouldAvoid'] = {'conditions': [], 'allergies': [], 'interactions': []};
    }

    if (sanitized['foodLifestyle'] is Map) {
      final foodLifestyle = Map<String, dynamic>.from(sanitized['foodLifestyle']);
      foodLifestyle['recommendedFoods'] = ensureList(foodLifestyle['recommendedFoods']);
      foodLifestyle['foodsToAvoid'] = ensureList(foodLifestyle['foodsToAvoid']);
      foodLifestyle['lifestyle'] = ensureList(foodLifestyle['lifestyle']);
      sanitized['foodLifestyle'] = foodLifestyle;
    } else {
        sanitized['foodLifestyle'] = {'recommendedFoods': [], 'foodsToAvoid': [], 'lifestyle': []};
    }

    return sanitized;
  }

  Map<String, dynamic> _sanitizeConditionJson(Map<String, dynamic> json) {
    final sanitized = Map<String, dynamic>.from(json);
    
    List<dynamic> ensureList(dynamic val) {
      if (val == null) return [];
      if (val is List) return val;
      return [];
    }

    String ensureString(dynamic val, [String defaultVal = '']) {
      if (val == null) return defaultVal;
      return val.toString();
    }

    sanitized['condition'] = ensureString(sanitized['condition']);
    sanitized['whenToSeeDr'] = ensureString(sanitized['whenToSeeDr']);

    sanitized['recommendedFoods'] = ensureList(sanitized['recommendedFoods']);
    sanitized['foodsToAvoid'] = ensureList(sanitized['foodsToAvoid']);
    sanitized['helpfulHabits'] = ensureList(sanitized['helpfulHabits']);

    return sanitized;
  }
}
