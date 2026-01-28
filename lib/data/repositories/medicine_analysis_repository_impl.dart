import '../../core/utils/app_utils.dart';
import '../../domain/entities/medicine_analysis_entity.dart';
import '../../domain/entities/condition_analysis_entity.dart';
import '../../domain/repositories/medicine_analysis_repository.dart';
import '../datasources/groq_remote_data_source.dart';

class MedicineAnalysisRepositoryImpl implements MedicineAnalysisRepository {
  final GroqRemoteDataSource remoteDataSource;

  MedicineAnalysisRepositoryImpl({required this.remoteDataSource});

  @override
  Future<MedicineAnalysisEntity> getMedicineAnalysis(
    String medicineName,
  ) async {
    try {
      AppUtils.log('Fetching analysis for medicine: $medicineName');

      final sanitizedName = AppUtils.sanitizeInput(medicineName);

      if (!AppUtils.isValidMedicineName(sanitizedName)) {
        throw Exception('Invalid medicine name');
      }

      final model = await remoteDataSource.analyzeMedicine(sanitizedName);
      return _mapModelToEntity(model);
    } catch (e) {
      AppUtils.log('Error in getMedicineAnalysis: $e');
      rethrow;
    }
  }

  @override
  Future<ConditionAnalysisEntity> getConditionAnalysis(String condition) async {
    try {
      AppUtils.log('Fetching analysis for condition: $condition');

      final sanitizedCondition = AppUtils.sanitizeInput(condition);

      if (!AppUtils.isValidConditionName(sanitizedCondition)) {
        throw Exception('Invalid condition name');
      }

      final model = await remoteDataSource.analyzeCondition(sanitizedCondition);
      return _mapConditionModelToEntity(model);
    } catch (e) {
      AppUtils.log('Error in getConditionAnalysis: $e');
      rethrow;
    }
  }

  MedicineAnalysisEntity _mapModelToEntity(dynamic model) {
    return MedicineAnalysisEntity(
      name: model.name,
      whyToTake: WhyToTakeEntity(
        description: model.whyToTake.description,
        benefits: List<String>.from(model.whyToTake.benefits),
      ),
      whenToTake: WhenToTakeEntity(
        timing: model.whenToTake.timing,
        frequency: model.whenToTake.frequency,
        beforeFood: model.whenToTake.beforeFood,
        afterFood: model.whenToTake.afterFood,
      ),
      howToTake: HowToTakeEntity(
        formType: model.howToTake.formType,
        instructions: model.howToTake.instructions,
      ),
      dosageGuidance: DosageGuidanceEntity(
        adultDosage: model.dosageGuidance.adultDosage,
        pediatricDosage: model.dosageGuidance.pediatricDosage,
        geriatricDosage: model.dosageGuidance.geriatricDosage,
      ),
      sideEffects: SideEffectsEntity(
        commonSideEffects: List<String>.from(
          model.sideEffects.commonSideEffects,
        ),
        seriousSideEffects: List<String>.from(
          model.sideEffects.seriousSideEffects,
        ),
      ),
      whoShouldAvoid: WhoShouldAvoidEntity(
        conditions: List<String>.from(model.whoShouldAvoid.conditions),
        allergies: List<String>.from(model.whoShouldAvoid.allergies),
        interactions: List<String>.from(model.whoShouldAvoid.interactions),
      ),
      alternativeMedicines: List<AlternativeMedicineEntity>.from(
        model.alternativeMedicines.map(
          (alt) =>
              AlternativeMedicineEntity(name: alt.name, purpose: alt.purpose),
        ),
      ),
      foodLifestyle: FoodLifestyleEntity(
        recommendedFoods: List<String>.from(
          model.foodLifestyle.recommendedFoods,
        ),
        foodsToAvoid: List<String>.from(model.foodLifestyle.foodsToAvoid),
        lifestyle: List<String>.from(model.foodLifestyle.lifestyle),
      ),
      missedDoseGuidance: model.missedDoseGuidance,
      storageInstructions: model.storageInstructions,
    );
  }

  ConditionAnalysisEntity _mapConditionModelToEntity(dynamic model) {
    return ConditionAnalysisEntity(
      condition: model.condition,
      recommendedFoods: List<String>.from(model.recommendedFoods),
      foodsToAvoid: List<String>.from(model.foodsToAvoid),
      helpfulHabits: List<String>.from(model.helpfulHabits),
      whenToSeeDr: model.whenToSeeDr,
    );
  }
}
