import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/medicine_analysis_entity.dart';
import '../../domain/entities/condition_analysis_entity.dart';
import 'app_providers.dart';

final medicineAnalysisProvider =
    FutureProvider.family<MedicineAnalysisEntity, String>((
      ref,
      medicineName,
    ) async {
      final repository = ref.watch(medicineAnalysisRepositoryProvider);
      return repository.getMedicineAnalysis(medicineName);
    });

final conditionAnalysisProvider =
    FutureProvider.family<ConditionAnalysisEntity, String>((
      ref,
      condition,
    ) async {
      final repository = ref.watch(medicineAnalysisRepositoryProvider);
      return repository.getConditionAnalysis(condition);
    });

final medicineSearchProvider = StateProvider<String>((ref) => '');

final conditionSearchProvider = StateProvider<String>((ref) => '');

final medicineLoadingProvider = StateProvider<bool>((ref) => false);

final conditionLoadingProvider = StateProvider<bool>((ref) => false);

final medicineErrorProvider = StateProvider<String?>((ref) => null);

final conditionErrorProvider = StateProvider<String?>((ref) => null);
