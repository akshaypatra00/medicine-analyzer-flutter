import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/search_history_model.dart';
import 'app_providers.dart';

final searchHistoryProvider = FutureProvider<List<SearchHistoryModel>>((
  ref,
) async {
  final repository = await ref.watch(searchHistoryRepositoryProvider.future);
  return repository.getSearchHistory();
});

final addToHistoryProvider = FutureProvider.family<void, (String, String)>((
  ref,
  params,
) async {
  final (query, type) = params;
  final repository = await ref.watch(searchHistoryRepositoryProvider.future);
  await repository.addToHistory(query, type);
  ref.invalidate(searchHistoryProvider);
});

final clearHistoryProvider = FutureProvider<void>((ref) async {
  final repository = await ref.watch(searchHistoryRepositoryProvider.future);
  await repository.clearHistory();
  ref.invalidate(searchHistoryProvider);
});

final deleteHistoryProvider = FutureProvider.family<void, String>((
  ref,
  id,
) async {
  final repository = await ref.watch(searchHistoryRepositoryProvider.future);
  await repository.deleteHistory(id);
  ref.invalidate(searchHistoryProvider);
});
