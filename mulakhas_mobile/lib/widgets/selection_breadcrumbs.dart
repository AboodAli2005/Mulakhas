import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_colors.dart';
import '../providers/selection_provider.dart';
import '../routes/app_routes.dart';

class SelectionBreadcrumbs extends ConsumerWidget {
  const SelectionBreadcrumbs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selection = ref.watch(selectionProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (!selection.hasAnySelection) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.tune_rounded, size: 18, color: AppColors.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Wrap(
              spacing: 6,
              runSpacing: 4,
              children: [
                if (selection.major != null)
                  _buildChip(
                    context,
                    selection.major!.name,
                    () => Navigator.pushNamed(context, AppRoutes.major),
                  ),
                if (selection.level != null)
                  _buildChip(
                    context,
                    selection.level!.name,
                    () => Navigator.pushNamed(context, AppRoutes.level),
                  ),
                if (selection.semester != null)
                  _buildChip(
                    context,
                    selection.semester!.name,
                    () => Navigator.pushNamed(context, AppRoutes.semester),
                  ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.restart_alt_rounded, size: 20),
            tooltip: 'إعادة تعيين',
            onPressed: () {
              ref.read(selectionProvider.notifier).reset();
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.major,
                (route) => route.isFirst,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChip(BuildContext context, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.edit, size: 10, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
