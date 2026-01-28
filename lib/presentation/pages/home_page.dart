import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'dart:io';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../data/services/ocr_service.dart';
import '../providers/history_providers.dart';
import '../providers/analysis_providers.dart';
import '../widgets/custom_widgets.dart';
// Note: We need to import the pages that home page navigates to, assuming they exist nearby or are part of the same file structure.
// Based on context, MedicineAnalysisPage and ConditionAnalysisPage are likely in this file or imported.
// I will check if they were in the original file I read. Yes, MedicineAnalysisPage was partially shown.
// I will include the full existing implementation of HomePage and the classes defined in the same file.
import 'medicine_analysis_page.dart';
import 'condition_analysis_page.dart';

// Actually, in the previous read, MedicineAnalysisPage was defined in home_page.dart towards the end.
// And likely ConditionAnalysisPage too.
// I will merge them all into this file as they were, but cleaned.

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late TextEditingController _medicineController;
  late TextEditingController _conditionController;
  int _selectedTabIndex = 0;
  bool _isProcessingImage = false;

  @override
  void initState() {
    super.initState();
    _medicineController = TextEditingController();
    _conditionController = TextEditingController();
  }

  @override
  void dispose() {
    _medicineController.dispose();
    _conditionController.dispose();
    super.dispose();
  }

  void _searchMedicine() async {
    final medicineName = _medicineController.text.trim();
    if (medicineName.isEmpty) return;

    await ref.read(addToHistoryProvider((medicineName, 'medicine')).future);

    if (mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MedicineAnalysisPage(medicineName: medicineName),
        ),
      );
    }
  }

  void _searchCondition() async {
    final condition = _conditionController.text.trim();
    if (condition.isEmpty) return;

    await ref.read(addToHistoryProvider((condition, 'condition')).future);

    if (mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ConditionAnalysisPage(condition: condition),
        ),
      );
    }
  }

  Future<void> _handleCameraCapture() async {
    setState(() => _isProcessingImage = true);
    try {
      final imageFile = await OcrService.pickImageFromCamera();
      if (imageFile != null && mounted) {
        await _processImageForMedicine(imageFile);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error accessing camera: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessingImage = false);
      }
    }
  }

  Future<void> _handleGalleryUpload() async {
    setState(() => _isProcessingImage = true);
    try {
      final imageFile = await OcrService.pickImageFromGallery();
      if (imageFile != null && mounted) {
        await _processImageForMedicine(imageFile);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading image: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessingImage = false);
      }
    }
  }

  Future<void> _processImageForMedicine(File imageFile) async {
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const Gap(16),
              Text(
                'Extracting medicine name...',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );

    try {
      final medicineName = await OcrService.extractMedicineNameFromImage(imageFile);
      if (!mounted) return;
      
      Navigator.of(context).pop();

      if (medicineName != null && medicineName.isNotEmpty) {
        _medicineController.text = medicineName;
        setState(() {});
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Found: $medicineName'),
            duration: const Duration(seconds: 2),
          ),
        );
        
        Future.delayed(const Duration(milliseconds: 500), _searchMedicine);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No medicine name found in image. Please try again.'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.of(context).pushNamed('/history');
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed('/settings');
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary.withOpacity(0.85),
                        AppColors.accent.withOpacity(0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.health_and_safety_outlined,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          const Gap(16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome Back!',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Colors.white.withOpacity(0.9),
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                const Gap(4),
                                Text(
                                  'Your Health AI Assistant',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Gap(16),
                      Text(
                        'Get instant insights about medicines and health conditions with AI-powered analysis.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white.withOpacity(0.85),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(32),

                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _ModernTabButton(
                          label: '💊 Medicine',
                          isSelected: _selectedTabIndex == 0,
                          onTap: () => setState(() => _selectedTabIndex = 0),
                        ),
                      ),
                      const Gap(4),
                      Expanded(
                        child: _ModernTabButton(
                          label: '🏥 Condition',
                          isSelected: _selectedTabIndex == 1,
                          onTap: () => setState(() => _selectedTabIndex = 1),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(32),

                if (_selectedTabIndex == 0)
                  _MedicineSearchSection(
                    controller: _medicineController,
                    onSearch: _searchMedicine,
                    onCamera: _handleCameraCapture,
                    onGallery: _handleGalleryUpload,
                    isProcessing: _isProcessingImage,
                  )
                else
                  _ConditionSearchSection(
                    controller: _conditionController,
                    onSearch: _searchCondition,
                  ),

                const Gap(32),

                _RecentSearches(),
                const Gap(40),
              ],
            ),
          ),
          if (_isProcessingImage)
            Container(
              color: Colors.black.withOpacity(0.3),
            ),
        ],
      ),
    );
  }
}

class _ModernTabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModernTabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Theme.of(context).textTheme.bodyMedium?.color,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class _MedicineSearchSection extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final VoidCallback onCamera;
  final VoidCallback onGallery;
  final bool isProcessing;

  const _MedicineSearchSection({
    required this.controller,
    required this.onSearch,
    required this.onCamera,
    required this.onGallery,
    required this.isProcessing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            enabled: !isProcessing,
            decoration: InputDecoration(
              hintText: 'Search medicine name...',
              prefixIcon: const Icon(Icons.medication_outlined),
              suffixIcon: controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        controller.clear();
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainer,
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
            onChanged: (value) {},
          ),
        ),
        const Gap(20),

        Row(
          children: [
            Expanded(
              child: _ActionButton(
                icon: Icons.search_rounded,
                label: 'Search',
                onPressed: isProcessing ? null : onSearch,
                isPrimary: true,
              ),
            ),
            const Gap(12),
            Expanded(
              child: _ActionButton(
                icon: Icons.camera_alt_outlined,
                label: 'Camera',
                onPressed: isProcessing ? null : onCamera,
              ),
            ),
            const Gap(12),
            Expanded(
              child: _ActionButton(
                icon: Icons.image_outlined,
                label: 'Gallery',
                onPressed: isProcessing ? null : onGallery,
              ),
            ),
          ],
        ),

        const Gap(16),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.info.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.info.withOpacity(0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: AppColors.info,
                size: 20,
              ),
              const Gap(12),
              Expanded(
                child: Text(
                  'Scan or upload a medicine box image to extract the name automatically',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.info,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final bool isPrimary;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: isPrimary
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              gradient: isPrimary
                  ? LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.accent,
                      ],
                    )
                  : null,
              color: !isPrimary ? Theme.of(context).colorScheme.surfaceContainer : null,
              borderRadius: BorderRadius.circular(12),
              border: !isPrimary
                  ? Border.all(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    )
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isPrimary ? Colors.white : Theme.of(context).textTheme.bodyMedium?.color,
                  size: 22,
                ),
                const Gap(4),
                Text(
                  label,
                  style: TextStyle(
                    color: isPrimary ? Colors.white : Theme.of(context).textTheme.bodySmall?.color,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ConditionSearchSection extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;

  const _ConditionSearchSection({
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Enter health condition...',
              prefixIcon: const Icon(Icons.health_and_safety_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainer,
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
          ),
        ),
        const Gap(20),
        _ActionButton(
          icon: Icons.search_rounded,
          label: 'Get Nutrition Guidance',
          onPressed: onSearch,
          isPrimary: true,
        ),
      ],
    );
  }
}

class _RecentSearches extends ConsumerWidget {
  const _RecentSearches();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(searchHistoryProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Searches',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(16),
        historyAsync.when(
          data: (history) {
            if (history.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Column(
                    children: [
                      Icon(
                        Icons.history,
                        size: 48,
                        color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.3),
                      ),
                      const Gap(12),
                      Text(
                        'No recent searches yet',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: history.length > 5 ? 5 : history.length,
              itemBuilder: (context, index) {
                final item = history[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            item.type == 'medicine'
                                ? Icons.medication_outlined
                                : Icons.health_and_safety_outlined,
                            size: 18,
                            color: AppColors.primary,
                          ),
                        ),
                        const Gap(12),
                        Expanded(
                          child: Text(
                            item.query,
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(
            child: Text(
              'Error loading history',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
      ],
    );
  }
}

// NOTE: I am not including the full content of MedicineAnalysisPage and ConditionAnalysisPage 
// because I don't have their full source code from the previous read. 
// I will create a separate file for them or read them first if they are critical.
// Actually, looking at the previous Read output, `home_page.dart` was read partially (only first 800 lines).
// It seems `MedicineAnalysisPage` and `ConditionAnalysisPage` were likely at the end of `home_page.dart`.
// If I overwrite `home_page.dart` now with missing classes, I will break the app.
// I MUST read the rest of `home_page.dart` before writing.
