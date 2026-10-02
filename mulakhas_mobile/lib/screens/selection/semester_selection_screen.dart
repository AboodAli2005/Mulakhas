import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/library_providers.dart';
import '../../providers/selection_provider.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/error_view.dart';
import '../../widgets/selection_step_card.dart';

class SemesterSelectionScreen extends ConsumerWidget {
  const SemesterSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selection = ref.watch(selectionProvider);
    final levelId = selection.level?.id;

    if (levelId == null) {
      return Scaffold(
        appBar: const CustomAppBar(title: 'اختر الفصل الدراسي'),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('يرجى اختيار المستوى أولاً'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(
                    context, AppRoutes.level),
                child: const Text('العودة لاختيار المستوى'),
              ),
            ],
          ),
        ),
      );
    }

    final semestersAsync = ref.watch(semestersProvider(levelId));
    final selectedSemester = selection.semester;

    return Scaffold(
      appBar: const CustomAppBar(title: 'اختر الفصل الدراسي'),
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
                      'الخطوة 3 من 3',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    if (selection.level != null)
                      Text(
                        'السنة: ${selection.level!.name}',
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
                  'حدد الفصل الدراسي',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'اختر الفصل لعرض المواد والمحاضرات المقررة.',
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
            child: semestersAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => ErrorView(
                message: err.toString(),
                onRetry: () => ref.refresh(semestersProvider(levelId)),
              ),
              data: (semesters) {
                if (semesters.isEmpty) {
                  return const Center(child: Text('لا توجد فصول متاحة'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: semesters.length,
                  itemBuilder: (context, index) {
                    final semester = semesters[index];
                    final isSelected = selectedSemester?.id == semester.id;
                    return SelectionStepCard(
                      title: semester.name,
                      icon: Icons.calendar_month_rounded,
                      isSelected: isSelected,
                      onTap: () {
                        ref
                            .read(selectionProvider.notifier)
                            .setSemester(semester);
                        // Navigate to materials
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.mainNav,
                          (route) => false,
                        );
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
