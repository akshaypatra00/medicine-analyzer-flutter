class ConditionAnalysisEntity {
  final String condition;
  final List<String> recommendedFoods;
  final List<String> foodsToAvoid;
  final List<String> helpfulHabits;
  final String whenToSeeDr;

  ConditionAnalysisEntity({
    required this.condition,
    required this.recommendedFoods,
    required this.foodsToAvoid,
    required this.helpfulHabits,
    required this.whenToSeeDr,
  });
}
