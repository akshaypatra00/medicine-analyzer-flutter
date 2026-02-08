

part of 'condition_analysis_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// *************************

ConditionAnalysisModel _$ConditionAnalysisModelFromJson(
  Map<String, dynamic> json,
) => ConditionAnalysisModel(
  condition: json['condition'] as String,
  recommendedFoods: (json['recommendedFoods'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  foodsToAvoid: (json['foodsToAvoid'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  helpfulHabits: (json['helpfulHabits'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  whenToSeeDr: json['whenToSeeDr'] as String,
);

Map<String, dynamic> _$ConditionAnalysisModelToJson(
  ConditionAnalysisModel instance,
) => <String, dynamic>{
  'condition': instance.condition,
  'recommendedFoods': instance.recommendedFoods,
  'foodsToAvoid': instance.foodsToAvoid,
  'helpfulHabits': instance.helpfulHabits,
  'whenToSeeDr': instance.whenToSeeDr,
};
