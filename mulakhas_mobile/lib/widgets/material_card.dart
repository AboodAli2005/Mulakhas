import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_colors.dart';
import '../core/utils/url_launcher_helper.dart';
import '../models/summary_dto.dart';
import '../providers/favorites_provider.dart';
import '../screens/materials/material_detail_screen.dart';

class MaterialCard extends ConsumerWidget {
  final MaterialItemDto item;
  final VoidCallback? onTap;

  const MaterialCard({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFav = ref.watch(favoritesProvider).any((e) => e.id == item.id);
    final isLecture = item.type == 2;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap ??
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MaterialDetailScreen(item: item),
                ),
              );
            },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row: Badges & Favorite Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Type Chip
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: (isLecture
                                  ? AppColors.chipLectures
                                  : AppColors.chipSummaries)
                              .withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isLecture
                                  ? Icons.video_library_outlined
                                  : Icons.menu_book_rounded,
                              size: 14,
                              color: isLecture
                                  ? AppColors.chipLectures
                                  : AppColors.chipSummaries,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              isLecture ? 'محاضرة' : 'ملخص',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: isLecture
                                    ? AppColors.chipLectures
                                    : AppColors.chipSummaries,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (item.subjectName != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item.subjectName!,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      isFav ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                      color: isFav ? AppColors.primary : Colors.grey,
                    ),
                    onPressed: () {
                      ref.read(favoritesProvider.notifier).toggleFavorite(item);
                    },
                    tooltip: isFav ? 'إزالة من المفضلة' : 'حفظ في المفضلة',
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Title
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              if (item.levelName != null || item.semesterName != null) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (item.levelName != null) ...[
                      Icon(Icons.school_outlined,
                          size: 14, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        item.levelName!,
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600),
                      ),
                      const SizedBox(width: 12),
                    ],
                    if (item.semesterName != null) ...[
                      Icon(Icons.calendar_today_outlined,
                          size: 13, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        item.semesterName!,
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600),
                      ),
                    ],
                  ],
                ),
              ],

              const SizedBox(height: 14),
              const Divider(height: 1),
              const SizedBox(height: 12),

              // Action buttons row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        item.isPdf
                            ? Icons.picture_as_pdf_rounded
                            : (item.isDocx
                                ? Icons.description_rounded
                                : Icons.link_rounded),
                        size: 18,
                        color: item.isPdf ? Colors.red.shade400 : AppColors.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        item.isPdf ? 'ملف PDF' : (item.isDocx ? 'مستند Word' : 'رابط خارجي'),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: () {
                      final url = item.fullUrl;
                      if (url.isNotEmpty) {
                        UrlLauncherHelper.openUrl(url);
                      }
                    },
                    icon: const Icon(Icons.open_in_new_rounded, size: 16),
                    label: const Text(
                      'فتح المستند',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
