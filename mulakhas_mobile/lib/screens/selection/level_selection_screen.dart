import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/library_providers.dart';
import '../../providers/selection_provider.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/error_view.dart';
import '../../widgets/selection_step_card.dart';

class LevelSelectionScreen extends ConsumerWidget {
  const LevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelsAsync = ref.watch(levelsProvider);
    final selection = ref.watch(selectionProvider);
    final selectedLevel = selection.level;

    return Scaffold(
      appBar: const CustomAppBar(title: 'اختر السنة الدراسية'),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'الخطوة 2 من 3',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    if (selection.major != null)
                      Text(
                        'التخصص: ${selection.major!.name}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'حدد السنة الدراسية (المستوى)',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'اختر المستوى الأكاديمي الحالي.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: levelsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => ErrorView(
                message: err.toString(),
                onRetry: () => ref.refresh(levelsProvider),
              ),
              data: (levels) {
                if (levels.isEmpty) {
                  return const Center(child: Text('لا توجد مستويات متاحة'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: levels.length,
                  itemBuilder: (context, index) {
                    final level = levels[index];
                    final isSelected = selectedLevel?.id == level.id;
                    return SelectionStepCard(
                      title: level.name,
                      icon: Icons.stairs_rounded,
                      isSelected: isSelected,
                      onTap: () {
                        ref.read(selectionProvider.notifier).setLevel(level);
                        Navigator.pushNamed(context, AppRoutes.semester);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
