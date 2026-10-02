import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/selection_provider.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_app_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selection = ref.watch(selectionProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const CustomAppBar(title: 'ملخص | Mulakhas'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HERO BANNER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isDark
                      ? [
                          AppColors.primaryDark.withOpacity(0.3),
                          AppColors.darkBackground,
                        ]
                      : [
                          const Color(0xFFE0F2FE),
                          AppColors.lightBackground,
                        ],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                      image: const DecorationImage(
                        image: AssetImage('assets/images/favicon.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'جميع مذكراتك الجامعية في مكان واحد',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'قم بالوصول إلى الملخصات والمحاضرات والمصادر التعليمية المنظمة بناءً على تخصصك وسنتك الدراسية بكل سهولة.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (selection.isComplete) {
                        Navigator.pushNamed(context, AppRoutes.materials);
                      } else {
                        Navigator.pushNamed(context, AppRoutes.major);
                      }
                    },
                    icon: const Icon(Icons.school_rounded),
                    label: Text(
                      selection.isComplete
                          ? 'عرض المواد المختارة'
                          : 'ابدأ باختيار التخصص',
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // CURRENT SELECTION QUICK CARD
            if (selection.hasAnySelection)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'مسارك الأكاديمي الحالي',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, AppRoutes.major);
                              },
                              child: const Text('تغيير'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            if (selection.major != null)
                              Chip(
                                avatar: const Icon(Icons.school, size: 16),
                                label: Text(selection.major!.name),
                              ),
                            if (selection.level != null)
                              Chip(
                                avatar: const Icon(Icons.timeline, size: 16),
                                label: Text(selection.level!.name),
                              ),
                            if (selection.semester != null)
                              Chip(
                                avatar: const Icon(Icons.date_range, size: 16),
                                label: Text(selection.semester!.name),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 16),

            // FEATURES GRID
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'مميزات المنصة',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 14),
                  _buildFeatureCard(
                    context,
                    icon: Icons.menu_book_rounded,
                    color: AppColors.primary,
                    title: 'ملخصات شاملة وموثوقة',
                    description:
                        'تلخيصات مركزة لأهم المفاهيم لتوفير وقتك وجهدك الدراسي.',
                  ),
                  const SizedBox(height: 10),
                  _buildFeatureCard(
                    context,
                    icon: Icons.video_library_rounded,
                    color: AppColors.chipLectures,
                    title: 'محاضرات وسلايدات',
                    description:
                        'وصول مباشر للسلايدات والمحاضرات بصيغ PDF وروابط درايف سريعة.',
                  ),
                  const SizedBox(height: 10),
                  _buildFeatureCard(
                    context,
                    icon: Icons.offline_pin_rounded,
                    color: AppColors.success,
                    title: 'حفظ وقراءة دون اتصال',
                    description:
                        'إمكانية حفظ المواد في المفضلة وتنزيلها للاطلاع عليها لاحقاً.',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required String description,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 0,
      color: isDark ? AppColors.darkSurface : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
