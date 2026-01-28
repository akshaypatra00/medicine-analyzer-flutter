import '../../data/models/search_history_model.dart';

abstract class SearchHistoryRepository {
  Future<List<SearchHistoryModel>> getSearchHistory();

  Future<void> addToHistory(String query, String type);

  Future<void> clearHistory();

  Future<void> deleteHistory(String id);
}
