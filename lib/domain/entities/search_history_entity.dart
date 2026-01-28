class SearchHistoryEntity {
  final String id;
  final String query;
  final String type;
  final DateTime timestamp;

  SearchHistoryEntity({
    required this.id,
    required this.query,
    required this.type,
    required this.timestamp,
  });
}
