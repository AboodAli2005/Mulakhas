import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/debounce.dart';
import '../../models/summary_dto.dart';
import '../../providers/library_providers.dart';
import '../../providers/selection_provider.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/empty_state_view.dart';
import '../../widgets/error_view.dart';
import '../../widgets/material_card.dart';
import '../../widgets/selection_breadcrumbs.dart';

class MaterialsScreen extends ConsumerStatefulWidget {
  const MaterialsScreen({super.key});

  @override
  ConsumerState<MaterialsScreen> createState() => _MaterialsScreenState();
}

class _MaterialsScreenState extends ConsumerState<MaterialsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Debounce _debounce = Debounce();

  @override
  void dispose() {
    _searchController.dispose();
    _debounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selection = ref.watch(selectionProvider);
    final activeType = ref.watch(activeMaterialTypeProvider);
    final subjectsAsync = ref.watch(subjectsProvider);
    final selectedSubjectId = ref.watch(selectedSubjectFilterProvider);
    final materialsAsync = ref.watch(currentMaterialsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // If selection is incomplete, show guide view
    if (!selection.isComplete) {
      return Scaffold(
        appBar: const CustomAppBar(title: 'المواد الأكاديمية'),
        body: EmptyStateView(
          icon: Icons.school_outlined,
          title: 'لم يتم تحديد التخصص بعد',
          subtitle:
              'يرجى تحديد التخصص، السنة الدراسية، والفصل لعرض المواد الخاصة بك.',
          action: ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.major),
            icon: const Icon(Icons.arrow_forward_rounded),
            label: const Text('ابدأ بالاختيار الآن'),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: const CustomAppBar(title: 'المواد والمذكرات'),
      body: Column(
        children: [
          // Breadcrumbs
          const SelectionBreadcrumbs(),

          // Material Type Toggle: Summaries vs Lectures
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildTypeButton(
                      title: 'الملخصات',
                      icon: Icons.menu_book_rounded,
                      isActive: activeType == MaterialType.summary,
                      onTap: () {
                        ref.read(activeMaterialTypeProvider.notifier).state =
                            MaterialType.summary;
                      },
                    ),
                  ),
                  Expanded(
                    child: _buildTypeButton(
                      title: 'المحاضرات',
                      icon: Icons.video_library_rounded,
                      isActive: activeType == MaterialType.lecture,
                      onTap: () {
                        ref.read(activeMaterialTypeProvider.notifier).state =
                            MaterialType.lecture;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Filters row: Subject Dropdown + Search
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                // Subject Dropdown
                Expanded(
                  flex: 3,
                  child: subjectsAsync.maybeWhen(
                    data: (subjects) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.darkSurface : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isDark
                                ? AppColors.darkCardBorder
                                : AppColors.lightCardBorder,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int?>(
                            value: selectedSubjectId,
                            isExpanded: true,
                            hint: const Text('جميع المواد',
                                style: TextStyle(fontSize: 13)),
                            items: [
                              const DropdownMenuItem<int?>(
                                value: null,
                                child: Text('جميع المواد',
                                    style: TextStyle(fontSize: 13)),
                              ),
                              ...subjects.map(
                                (s) => DropdownMenuItem<int?>(
                                  value: s.id,
                                  child: Text(
                                    s.name,
                                    style: const TextStyle(fontSize: 13),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (val) {
                              ref
                                  .read(selectedSubjectFilterProvider.notifier)
                                  .state = val;
                            },
                          ),
                        ),
                      );
                    },
                    orElse: () => const SizedBox.shrink(),
                  ),
                ),
                const SizedBox(width: 8),

                // Search field
                Expanded(
                  flex: 4,
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(fontSize: 13),
                    decoration: InputDecoration(
                      hintText: 'بحث في العناوين...',
                      prefixIcon: const Icon(Icons.search, size: 20),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              onPressed: () {
                                _searchController.clear();
                                ref.read(materialKeywordProvider.notifier).state =
                                    '';
                                setState(() {});
                              },
                            )
                          : null,
                    ),
                    onChanged: (val) {
                      setState(() {});
                      _debounce.run(() {
                        ref.read(materialKeywordProvider.notifier).state = val;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 4),

          // Materials List
          Expanded(
            child: materialsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => ErrorView(
                message: err.toString(),
                onRetry: () => ref.refresh(currentMaterialsProvider),
              ),
              data: (materials) {
                if (materials.isEmpty) {
                  return EmptyStateView(
                    icon: Icons.search_off_rounded,
                    title: 'لم يتم العثور على مواد',
                    subtitle:
                        'لا توجد مواد تطابق خيارات التصفية والبحث المحددة.',
                    action: TextButton.icon(
                      onPressed: () {
                        _searchController.clear();
                        ref.read(materialKeywordProvider.notifier).state = '';
                        ref.read(selectedSubjectFilterProvider.notifier).state =
                            null;
                        setState(() {});
                      },
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('إعادة تعيين الفلاتر'),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    return ref.refresh(currentMaterialsProvider);
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 24, top: 4),
                    itemCount: materials.length,
                    itemBuilder: (context, index) {
                      return MaterialCard(item: materials[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeButton({
    required String title,
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isActive ? Colors.white : Colors.grey.shade600,
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: isActive ? Colors.white : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
