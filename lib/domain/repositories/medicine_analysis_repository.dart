import '../entities/medicine_analysis_entity.dart';
import '../entities/condition_analysis_entity.dart';

abstract class MedicineAnalysisRepository {
  Future<MedicineAnalysisEntity> getMedicineAnalysis(String medicineName);

  Future<ConditionAnalysisEntity> getConditionAnalysis(String condition);
}
