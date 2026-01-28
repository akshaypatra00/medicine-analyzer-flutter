import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../../data/datasources/groq_remote_data_source.dart';
import '../../data/repositories/medicine_analysis_repository_impl.dart';
import '../../data/repositories/search_history_repository_impl.dart';
import '../../domain/repositories/medicine_analysis_repository.dart';
import '../../domain/repositories/search_history_repository.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final groqRemoteDataSourceProvider = Provider<GroqRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return GroqRemoteDataSource(dio: dio);
});

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((
  ref,
) async {
  return await SharedPreferences.getInstance();
});

final medicineAnalysisRepositoryProvider = Provider<MedicineAnalysisRepository>(
  (ref) {
    final remoteDataSource = ref.watch(groqRemoteDataSourceProvider);
    return MedicineAnalysisRepositoryImpl(remoteDataSource: remoteDataSource);
  },
);

final searchHistoryRepositoryProvider = FutureProvider<SearchHistoryRepository>(
  (ref) async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    return SearchHistoryRepositoryImpl(prefs: prefs);
  },
);

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false);

  void toggleTheme() {
    state = !state;
  }

  void setDarkMode(bool isDark) {
    state = isDark;
  }
}
