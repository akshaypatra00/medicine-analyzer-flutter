class MedicineAnalysisEntity {
  final String name;
  final WhyToTakeEntity whyToTake;
  final WhenToTakeEntity whenToTake;
  final HowToTakeEntity howToTake;
  final DosageGuidanceEntity dosageGuidance;
  final SideEffectsEntity sideEffects;
  final WhoShouldAvoidEntity whoShouldAvoid;
  final List<AlternativeMedicineEntity> alternativeMedicines;
  final FoodLifestyleEntity foodLifestyle;
  final String missedDoseGuidance;
  final String storageInstructions;

  MedicineAnalysisEntity({
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
}

class WhyToTakeEntity {
  final String description;
  final List<String> benefits;

  WhyToTakeEntity({required this.description, required this.benefits});
}

class WhenToTakeEntity {
  final String timing;
  final String frequency;
  final bool beforeFood;
  final bool afterFood;

  WhenToTakeEntity({
    required this.timing,
    required this.frequency,
    required this.beforeFood,
    required this.afterFood,
  });
}

class HowToTakeEntity {
  final String formType;
  final String instructions;

  HowToTakeEntity({required this.formType, required this.instructions});
}

class DosageGuidanceEntity {
  final String adultDosage;
  final String pediatricDosage;
  final String geriatricDosage;

  DosageGuidanceEntity({
    required this.adultDosage,
    required this.pediatricDosage,
    required this.geriatricDosage,
  });
}

class SideEffectsEntity {
  final List<String> commonSideEffects;
  final List<String> seriousSideEffects;

  SideEffectsEntity({
    required this.commonSideEffects,
    required this.seriousSideEffects,
  });
}

class WhoShouldAvoidEntity {
  final List<String> conditions;
  final List<String> allergies;
  final List<String> interactions;

  WhoShouldAvoidEntity({
    required this.conditions,
    required this.allergies,
    required this.interactions,
  });
}

class AlternativeMedicineEntity {
  final String name;
  final String purpose;

  AlternativeMedicineEntity({required this.name, required this.purpose});
}

class FoodLifestyleEntity {
  final List<String> recommendedFoods;
  final List<String> foodsToAvoid;
  final List<String> lifestyle;

  FoodLifestyleEntity({
    required this.recommendedFoods,
    required this.foodsToAvoid,
    required this.lifestyle,
  });
}
