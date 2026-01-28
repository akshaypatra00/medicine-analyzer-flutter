// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_analysis_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineAnalysisModel _$MedicineAnalysisModelFromJson(
  Map<String, dynamic> json,
) => MedicineAnalysisModel(
  name: json['name'] as String,
  whyToTake: WhyToTakeModel.fromJson(json['whyToTake'] as Map<String, dynamic>),
  whenToTake: WhenToTakeModel.fromJson(
    json['whenToTake'] as Map<String, dynamic>,
  ),
  howToTake: HowToTakeModel.fromJson(json['howToTake'] as Map<String, dynamic>),
  dosageGuidance: DosageGuidanceModel.fromJson(
    json['dosageGuidance'] as Map<String, dynamic>,
  ),
  sideEffects: SideEffectsModel.fromJson(
    json['sideEffects'] as Map<String, dynamic>,
  ),
  whoShouldAvoid: WhoShouldAvoidModel.fromJson(
    json['whoShouldAvoid'] as Map<String, dynamic>,
  ),
  alternativeMedicines: (json['alternativeMedicines'] as List<dynamic>)
      .map((e) => AlternativeMedicineModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  foodLifestyle: FoodLifestyleModel.fromJson(
    json['foodLifestyle'] as Map<String, dynamic>,
  ),
  missedDoseGuidance: json['missedDoseGuidance'] as String,
  storageInstructions: json['storageInstructions'] as String,
);

Map<String, dynamic> _$MedicineAnalysisModelToJson(
  MedicineAnalysisModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'whyToTake': instance.whyToTake,
  'whenToTake': instance.whenToTake,
  'howToTake': instance.howToTake,
  'dosageGuidance': instance.dosageGuidance,
  'sideEffects': instance.sideEffects,
  'whoShouldAvoid': instance.whoShouldAvoid,
  'alternativeMedicines': instance.alternativeMedicines,
  'foodLifestyle': instance.foodLifestyle,
  'missedDoseGuidance': instance.missedDoseGuidance,
  'storageInstructions': instance.storageInstructions,
};

WhyToTakeModel _$WhyToTakeModelFromJson(Map<String, dynamic> json) =>
    WhyToTakeModel(
      description: json['description'] as String,
      benefits: (json['benefits'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$WhyToTakeModelToJson(WhyToTakeModel instance) =>
    <String, dynamic>{
      'description': instance.description,
      'benefits': instance.benefits,
    };

WhenToTakeModel _$WhenToTakeModelFromJson(Map<String, dynamic> json) =>
    WhenToTakeModel(
      timing: json['timing'] as String,
      frequency: json['frequency'] as String,
      beforeFood: json['beforeFood'] as bool,
      afterFood: json['afterFood'] as bool,
    );

Map<String, dynamic> _$WhenToTakeModelToJson(WhenToTakeModel instance) =>
    <String, dynamic>{
      'timing': instance.timing,
      'frequency': instance.frequency,
      'beforeFood': instance.beforeFood,
      'afterFood': instance.afterFood,
    };

HowToTakeModel _$HowToTakeModelFromJson(Map<String, dynamic> json) =>
    HowToTakeModel(
      formType: json['formType'] as String,
      instructions: json['instructions'] as String,
    );

Map<String, dynamic> _$HowToTakeModelToJson(HowToTakeModel instance) =>
    <String, dynamic>{
      'formType': instance.formType,
      'instructions': instance.instructions,
    };

DosageGuidanceModel _$DosageGuidanceModelFromJson(Map<String, dynamic> json) =>
    DosageGuidanceModel(
      adultDosage: json['adultDosage'] as String,
      pediatricDosage: json['pediatricDosage'] as String,
      geriatricDosage: json['geriatricDosage'] as String,
    );

Map<String, dynamic> _$DosageGuidanceModelToJson(
  DosageGuidanceModel instance,
) => <String, dynamic>{
  'adultDosage': instance.adultDosage,
  'pediatricDosage': instance.pediatricDosage,
  'geriatricDosage': instance.geriatricDosage,
};

SideEffectsModel _$SideEffectsModelFromJson(Map<String, dynamic> json) =>
    SideEffectsModel(
      commonSideEffects: (json['commonSideEffects'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      seriousSideEffects: (json['seriousSideEffects'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SideEffectsModelToJson(SideEffectsModel instance) =>
    <String, dynamic>{
      'commonSideEffects': instance.commonSideEffects,
      'seriousSideEffects': instance.seriousSideEffects,
    };

WhoShouldAvoidModel _$WhoShouldAvoidModelFromJson(Map<String, dynamic> json) =>
    WhoShouldAvoidModel(
      conditions: (json['conditions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      allergies: (json['allergies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      interactions: (json['interactions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$WhoShouldAvoidModelToJson(
  WhoShouldAvoidModel instance,
) => <String, dynamic>{
  'conditions': instance.conditions,
  'allergies': instance.allergies,
  'interactions': instance.interactions,
};

AlternativeMedicineModel _$AlternativeMedicineModelFromJson(
  Map<String, dynamic> json,
) => AlternativeMedicineModel(
  name: json['name'] as String,
  purpose: json['purpose'] as String,
);

Map<String, dynamic> _$AlternativeMedicineModelToJson(
  AlternativeMedicineModel instance,
) => <String, dynamic>{'name': instance.name, 'purpose': instance.purpose};

FoodLifestyleModel _$FoodLifestyleModelFromJson(Map<String, dynamic> json) =>
    FoodLifestyleModel(
      recommendedFoods: (json['recommendedFoods'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      foodsToAvoid: (json['foodsToAvoid'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      lifestyle: (json['lifestyle'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$FoodLifestyleModelToJson(FoodLifestyleModel instance) =>
    <String, dynamic>{
      'recommendedFoods': instance.recommendedFoods,
      'foodsToAvoid': instance.foodsToAvoid,
      'lifestyle': instance.lifestyle,
    };
