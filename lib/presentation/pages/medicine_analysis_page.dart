import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../providers/analysis_providers.dart';
import '../widgets/analysis_widgets.dart';

class MedicineAnalysisPage extends ConsumerWidget {
  final String medicineName;

  const MedicineAnalysisPage({Key? key, required this.medicineName})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analysisAsync = ref.watch(medicineAnalysisProvider(medicineName));

    return Scaffold(
      appBar: AppBar(
        title: Text(medicineName),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share functionality implementation or placeholder
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Share functionality coming soon')),
              );
            },
          ),
        ],
      ),
      body: analysisAsync.when(
        loading: () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const Gap(16),
              Text(
                'Analyzing $medicineName...',
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
                    'Error analyzing medicine',
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
                      ref.refresh(medicineAnalysisProvider(medicineName));
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        },
        data: (analysis) {
          return MedicineAnalysisResultView(
            medicineName: medicineName,
            analysisData: analysis,
            onShare: () {},
          );
        },
      ),
    );
  }
}
