import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../core/utils/app_utils.dart';
import '../models/search_history_model.dart';
import '../../domain/repositories/search_history_repository.dart';

class SearchHistoryRepositoryImpl implements SearchHistoryRepository {
  static const String _historyKey = 'search_history';
  final SharedPreferences _prefs;

  SearchHistoryRepositoryImpl({required SharedPreferences prefs})
    : _prefs = prefs;

  @override
  Future<List<SearchHistoryModel>> getSearchHistory() async {
    try {
      final jsonString = _prefs.getString(_historyKey);
      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map(
            (item) => SearchHistoryModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      AppUtils.log('Error fetching history: $e');
      return [];
    }
  }

  @override
  Future<void> addToHistory(String query, String type) async {
    try {
      final history = await getSearchHistory();

      history.removeWhere((item) => item.query == query && item.type == type);

      final newEntry = SearchHistoryModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        query: query,
        type: type,
        timestamp: DateTime.now(),
      );

      history.insert(0, newEntry);

      if (history.length > 50) {
        history.removeRange(50, history.length);
      }

      final jsonString = jsonEncode(
        history.map((item) => item.toJson()).toList(),
      );

      await _prefs.setString(_historyKey, jsonString);
      AppUtils.log('Added to history: $query');
    } catch (e) {
      AppUtils.log('Error adding to history: $e');
    }
  }

  @override
  Future<void> clearHistory() async {
    try {
      await _prefs.remove(_historyKey);
      AppUtils.log('History cleared');
    } catch (e) {
      AppUtils.log('Error clearing history: $e');
    }
  }

  @override
  Future<void> deleteHistory(String id) async {
    try {
      final history = await getSearchHistory();
      history.removeWhere((item) => item.id == id);

      final jsonString = jsonEncode(
        history.map((item) => item.toJson()).toList(),
      );

      await _prefs.setString(_historyKey, jsonString);
      AppUtils.log('Deleted history item: $id');
    } catch (e) {
      AppUtils.log('Error deleting history: $e');
    }
  }
}
