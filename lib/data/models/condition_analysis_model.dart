import 'package:json_annotation/json_annotation.dart';

part 'condition_analysis_model.g.dart';

@JsonSerializable()
class ConditionAnalysisModel {
  final String condition;
  final List<String> recommendedFoods;
  final List<String> foodsToAvoid;
  final List<String> helpfulHabits;
  final String whenToSeeDr;

  ConditionAnalysisModel({
    required this.condition,
    required this.recommendedFoods,
    required this.foodsToAvoid,
    required this.helpfulHabits,
    required this.whenToSeeDr,
  });

  factory ConditionAnalysisModel.fromJson(Map<String, dynamic> json) =>
      _$ConditionAnalysisModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConditionAnalysisModelToJson(this);
}
