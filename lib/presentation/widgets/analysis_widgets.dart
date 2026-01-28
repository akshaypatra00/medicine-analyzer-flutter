import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../domain/entities/medicine_analysis_entity.dart';
import '../../domain/entities/condition_analysis_entity.dart';
import 'custom_widgets.dart';

class MedicineAnalysisResultView extends StatelessWidget {
  final String medicineName;
  final MedicineAnalysisEntity analysisData;
  final VoidCallback onShare;

  const MedicineAnalysisResultView({
    Key? key,
    required this.medicineName,
    required this.analysisData,
    required this.onShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(medicineName, style: Theme.of(context).textTheme.displaySmall),
          const Gap(24),
          
          _AnalysisSection(
            title: AppStrings.whyToTake,
            icon: Icons.medical_information,
            content: analysisData.whyToTake.description,
            listItems: analysisData.whyToTake.benefits,
          ),
          const Gap(16),

          _AnalysisSection(
            title: AppStrings.howToTake,
            icon: Icons.medication,
            content: '${analysisData.howToTake.formType}\n${analysisData.howToTake.instructions}',
          ),
           const Gap(16),

          _AnalysisSection(
            title: AppStrings.whenToTake,
            icon: Icons.access_time,
            content: '${analysisData.whenToTake.timing} (${analysisData.whenToTake.frequency})',
            listItems: [
              if (analysisData.whenToTake.beforeFood) 'Take before food',
              if (analysisData.whenToTake.afterFood) 'Take after food',
            ],
          ),
          const Gap(16),

           _AnalysisSection(
            title: 'Dosage',
            icon: Icons.scale,
            content: 'Adult: ${analysisData.dosageGuidance.adultDosage}\nPediatric: ${analysisData.dosageGuidance.pediatricDosage}\nGeriatric: ${analysisData.dosageGuidance.geriatricDosage}',
          ),
          const Gap(16),

          if (analysisData.sideEffects.commonSideEffects.isNotEmpty)
             _AnalysisSection(
              title: AppStrings.sideEffects,
              icon: Icons.warning_amber,
              content: 'Common Side Effects',
              listItems: analysisData.sideEffects.commonSideEffects,
            ),
           const Gap(16),
           
           if (analysisData.sideEffects.seriousSideEffects.isNotEmpty)
             MedicineCard(
               title: 'Serious Side Effects',
               items: analysisData.sideEffects.seriousSideEffects,
               icon: Icons.warning,
               isSeriousWarning: true,
             ),
           const Gap(16),

           _AnalysisSection(
            title: 'Dietary & Lifestyle',
            icon: Icons.restaurant,
            content: 'Recommended Foods: ${analysisData.foodLifestyle.recommendedFoods.join(", ")}\n\nFoods to Avoid: ${analysisData.foodLifestyle.foodsToAvoid.join(", ")}',
            listItems: analysisData.foodLifestyle.lifestyle,
          ),
        ],
      ),
    );
  }
}

class _AnalysisSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final String content;
  final List<String>? listItems;

  const _AnalysisSection({
    Key? key,
    required this.title,
    required this.icon,
    required this.content,
    this.listItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary),
              const Gap(8),
              Text(title, style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
          const Gap(12),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if (listItems != null && listItems!.isNotEmpty) ...[
            const Gap(8),
            ...listItems!.map((item) => Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Expanded(child: Text(item)),
                ],
              ),
            )),
          ]
        ],
      ),
    );
  }
}

class ConditionAnalysisResultView extends StatelessWidget {
  final String condition;
  final ConditionAnalysisEntity analysisData;

  const ConditionAnalysisResultView({
    Key? key,
    required this.condition,
    required this.analysisData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About $condition',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const Gap(24),
          
          _AnalysisSection(
            title: 'Recommended Foods',
            icon: Icons.thumb_up,
            content: 'Foods that are good for this condition:',
            listItems: analysisData.recommendedFoods,
          ),
          const Gap(16),

          _AnalysisSection(
            title: 'Foods to Avoid',
            icon: Icons.thumb_down,
            content: 'Foods that might aggravate this condition:',
            listItems: analysisData.foodsToAvoid,
          ),
          const Gap(16),

          _AnalysisSection(
            title: 'Helpful Habits',
            icon: Icons.accessibility_new,
            content: 'Lifestyle changes that can help:',
            listItems: analysisData.helpfulHabits,
          ),
           const Gap(16),

           _AnalysisSection(
            title: 'When to See a Doctor',
            icon: Icons.medical_services,
            content: analysisData.whenToSeeDr,
          ),
        ],
      ),
    );
  }
}
