import 'package:json_annotation/json_annotation.dart';

part 'medicine_analysis_model.g.dart';

@JsonSerializable()
class MedicineAnalysisModel {
  final String name;
  final WhyToTakeModel whyToTake;
  final WhenToTakeModel whenToTake;
  final HowToTakeModel howToTake;
  final DosageGuidanceModel dosageGuidance;
  final SideEffectsModel sideEffects;
  final WhoShouldAvoidModel whoShouldAvoid;
  final List<AlternativeMedicineModel> alternativeMedicines;
  final FoodLifestyleModel foodLifestyle;
  final String missedDoseGuidance;
  final String storageInstructions;

  MedicineAnalysisModel({
    required this.name,
    required this.whyToTake,
    required this.whenToTake,
    required this.howToTake,
    required this.dosageGuidance,
    required this.sideEffects,
    required this.whoShouldAvoid,
    required this.alternativeMedicines,
    required this.foodLifestyle,
    required this.missedDoseGuidance,
    required this.storageInstructions,
  });

  factory MedicineAnalysisModel.fromJson(Map<String, dynamic> json) =>
      _$MedicineAnalysisModelFromJson(json);

  Map<String, dynamic> toJson() => _$MedicineAnalysisModelToJson(this);
}

@JsonSerializable()
class WhyToTakeModel {
  final String description;
  final List<String> benefits;

  WhyToTakeModel({required this.description, required this.benefits});

  factory WhyToTakeModel.fromJson(Map<String, dynamic> json) =>
      _$WhyToTakeModelFromJson(json);

  Map<String, dynamic> toJson() => _$WhyToTakeModelToJson(this);
}

@JsonSerializable()
class WhenToTakeModel {
  final String timing;
  final String frequency;
  final bool beforeFood;
  final bool afterFood;

  WhenToTakeModel({
    required this.timing,
    required this.frequency,
    required this.beforeFood,
    required this.afterFood,
  });

  factory WhenToTakeModel.fromJson(Map<String, dynamic> json) =>
      _$WhenToTakeModelFromJson(json);

  Map<String, dynamic> toJson() => _$WhenToTakeModelToJson(this);
}

@JsonSerializable()
class HowToTakeModel {
  final String formType;
  final String instructions;

  HowToTakeModel({required this.formType, required this.instructions});

  factory HowToTakeModel.fromJson(Map<String, dynamic> json) =>
      _$HowToTakeModelFromJson(json);

  Map<String, dynamic> toJson() => _$HowToTakeModelToJson(this);
}

@JsonSerializable()
class DosageGuidanceModel {
  final String adultDosage;
  final String pediatricDosage;
  final String geriatricDosage;

  DosageGuidanceModel({
    required this.adultDosage,
    required this.pediatricDosage,
    required this.geriatricDosage,
  });

  factory DosageGuidanceModel.fromJson(Map<String, dynamic> json) =>
      _$DosageGuidanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$DosageGuidanceModelToJson(this);
}

@JsonSerializable()
class SideEffectsModel {
  final List<String> commonSideEffects;
  final List<String> seriousSideEffects;

  SideEffectsModel({
    required this.commonSideEffects,
    required this.seriousSideEffects,
  });

  factory SideEffectsModel.fromJson(Map<String, dynamic> json) =>
      _$SideEffectsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SideEffectsModelToJson(this);
}

@JsonSerializable()
class WhoShouldAvoidModel {
  final List<String> conditions;
  final List<String> allergies;
  final List<String> interactions;

  WhoShouldAvoidModel({
    required this.conditions,
    required this.allergies,
    required this.interactions,
  });

  factory WhoShouldAvoidModel.fromJson(Map<String, dynamic> json) =>
      _$WhoShouldAvoidModelFromJson(json);

  Map<String, dynamic> toJson() => _$WhoShouldAvoidModelToJson(this);
}

@JsonSerializable()
class AlternativeMedicineModel {
  final String name;
  final String purpose;

  AlternativeMedicineModel({required this.name, required this.purpose});

  factory AlternativeMedicineModel.fromJson(Map<String, dynamic> json) =>
      _$AlternativeMedicineModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlternativeMedicineModelToJson(this);
}

@JsonSerializable()
class FoodLifestyleModel {
  final List<String> recommendedFoods;
  final List<String> foodsToAvoid;
  final List<String> lifestyle;

  FoodLifestyleModel({
    required this.recommendedFoods,
    required this.foodsToAvoid,
    required this.lifestyle,
  });

  factory FoodLifestyleModel.fromJson(Map<String, dynamic> json) =>
      _$FoodLifestyleModelFromJson(json);

  Map<String, dynamic> toJson() => _$FoodLifestyleModelToJson(this);
}
