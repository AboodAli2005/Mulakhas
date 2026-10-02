import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/library_providers.dart';
import '../../providers/selection_provider.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/error_view.dart';
import '../../widgets/selection_step_card.dart';

class MajorSelectionScreen extends ConsumerWidget {
  const MajorSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final majorsAsync = ref.watch(majorsProvider);
    final selectedMajor = ref.watch(selectionProvider).major;

    return Scaffold(
      appBar: const CustomAppBar(title: 'اختر التخصص'),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'الخطوة 1 من 3',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'حدد تخصصك الجامعي',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'سيتم عرض الملخصات والمحاضرات المتوافقة مع تخصصك.',
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
            child: majorsAsync.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (err, _) => ErrorView(
                message: err.toString(),
                onRetry: () => ref.refresh(majorsProvider),
              ),
              data: (majors) {
                if (majors.isEmpty) {
                  return const Center(child: Text('لا توجد تخصصات متاحة'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: majors.length,
                  itemBuilder: (context, index) {
                    final major = majors[index];
                    final isSelected = selectedMajor?.id == major.id;
                    return SelectionStepCard(
                      title: major.name,
                      icon: Icons.computer_rounded,
                      isSelected: isSelected,
                      onTap: () {
                        ref
                            .read(selectionProvider.notifier)
                            .setMajor(major);
                        Navigator.pushNamed(context, AppRoutes.level);
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
