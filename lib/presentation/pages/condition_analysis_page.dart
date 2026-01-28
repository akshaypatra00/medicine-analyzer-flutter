import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../providers/analysis_providers.dart';
import '../widgets/analysis_widgets.dart';

class ConditionAnalysisPage extends ConsumerWidget {
  final String condition;

  const ConditionAnalysisPage({Key? key, required this.condition})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analysisAsync = ref.watch(conditionAnalysisProvider(condition));

    return Scaffold(
      appBar: AppBar(
        title: Text(condition),
        elevation: 0,
      ),
      body: analysisAsync.when(
        loading: () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const Gap(16),
              Text(
                'Analyzing condition...',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        error: (error, stackTrace) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const Gap(16),
                  Text(
                    'Error analyzing condition',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Gap(8),
                  Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                  ),
                  const Gap(24),
                  FilledButton(
                    onPressed: () {
                      ref.refresh(conditionAnalysisProvider(condition));
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        },
        data: (analysis) {
          return ConditionAnalysisResultView(
            condition: condition,
            analysisData: analysis,
          );
        },
      ),
    );
  }
}
