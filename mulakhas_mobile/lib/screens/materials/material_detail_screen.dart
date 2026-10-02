import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/url_launcher_helper.dart';
import '../../models/summary_dto.dart';
import '../../providers/favorites_provider.dart';
import '../../services/download_service.dart';
import '../../widgets/custom_app_bar.dart';

class MaterialDetailScreen extends ConsumerStatefulWidget {
  final MaterialItemDto item;

  const MaterialDetailScreen({super.key, required this.item});

  @override
  ConsumerState<MaterialDetailScreen> createState() =>
      _MaterialDetailScreenState();
}

class _MaterialDetailScreenState extends ConsumerState<MaterialDetailScreen> {
  final DownloadService _downloadService = DownloadService();
  bool _isDownloading = false;
  double _downloadProgress = 0.0;
  String? _downloadedFilePath;

  @override
  void initState() {
    super.initState();
    _checkIfDownloaded();
  }

  Future<void> _checkIfDownloaded() async {
    final fileName = '${widget.item.title}.pdf';
    final exists = await _downloadService.isFileDownloaded(fileName);
    if (exists && mounted) {
      setState(() {
        _downloadProgress = 1.0;
      });
    }
  }

  Future<void> _downloadFile() async {
    final url = widget.item.fullUrl;
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('رابط الملف غير متاح')),
      );
      return;
    }

    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
    });

    final fileName = '${widget.item.title}.pdf';
    final savedPath = await _downloadService.downloadFile(
      fileUrl: url,
      fileName: fileName,
      onProgress: (received, total) {
        if (total > 0 && mounted) {
          setState(() {
            _downloadProgress = received / total;
          });
        }
      },
    );

    if (mounted) {
      setState(() {
        _isDownloading = false;
        _downloadedFilePath = savedPath;
      });

      if (savedPath != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم تنزيل الملف بنجاح!'),
            backgroundColor: AppColors.success,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('فشل تنزيل الملف، يرجى المحاولة مرة أخرى'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFav =
        ref.watch(favoritesProvider).any((e) => e.id == widget.item.id);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.item.type == 2 ? 'تفاصيل المحاضرة' : 'تفاصيل الملخص',
        showLogo: false,
        actions: [
          IconButton(
            icon: Icon(
              isFav ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
              color: isFav ? AppColors.primary : null,
            ),
            onPressed: () {
              ref
                  .read(favoritesProvider.notifier)
                  .toggleFavorite(widget.item);
            },
            tooltip: isFav ? 'إزالة من المفضلة' : 'حفظ في المفضلة',
          ),
          IconButton(
            icon: const Icon(Icons.share_rounded),
            onPressed: () {
              final url = widget.item.fullUrl;
              Share.share(
                'شاهد "${widget.item.title}" في تطبيق ملخص: $url',
                subject: widget.item.title,
              );
            },
            tooltip: 'مشاركة',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark
                      ? AppColors.darkCardBorder
                      : AppColors.lightCardBorder,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.item.type == 2 ? 'محاضرة' : 'ملخص',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (widget.item.subjectName != null)
                        Text(
                          widget.item.subjectName!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    widget.item.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Divider(),
                  const SizedBox(height: 10),
                  _buildMetaRow(
                    Icons.school_outlined,
                    'المستوى:',
                    widget.item.levelName ?? 'غير محدد',
                  ),
                  const SizedBox(height: 8),
                  _buildMetaRow(
                    Icons.calendar_today_outlined,
                    'الفصل الدراسي:',
                    widget.item.semesterName ?? 'غير محدد',
                  ),
                ],
              ),
            ),

            if (widget.item.notes != null &&
                widget.item.notes!.trim().isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkSurface : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark
                        ? AppColors.darkCardBorder
                        : AppColors.lightCardBorder,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.notes_rounded,
                            size: 18, color: AppColors.primary),
                        SizedBox(width: 8),
                        Text(
                          'ملاحظات إضافية',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.item.notes!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Download Progress Bar (if downloading)
            if (_isDownloading) ...[
              LinearProgressIndicator(value: _downloadProgress),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'جاري التنزيل: ${(_downloadProgress * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Action Buttons
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  final url = widget.item.fullUrl;
                  if (url.isNotEmpty) {
                    UrlLauncherHelper.openUrl(url);
                  }
                },
                icon: const Icon(Icons.open_in_new_rounded),
                label: const Text(
                  'قراءة / فتح الملف',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: _isDownloading ? null : _downloadFile,
                icon: const Icon(Icons.download_rounded),
                label: Text(
                  _downloadedFilePath != null
                      ? 'تم التنزيل (إعادة التنزيل)'
                      : 'تنزيل للاطلاع بدون إنترنت',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetaRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
