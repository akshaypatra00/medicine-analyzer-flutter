import 'package:json_annotation/json_annotation.dart';

part 'search_history_model.g.dart';

@JsonSerializable()
class SearchHistoryModel {
  final String id;
  final String query;
  final String type;
  final DateTime timestamp;

  SearchHistoryModel({
    required this.id,
    required this.query,
    required this.type,
    required this.timestamp,
  });

  factory SearchHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$SearchHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchHistoryModelToJson(this);
}
