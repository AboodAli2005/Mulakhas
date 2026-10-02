import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/debounce.dart';
import '../../models/summary_dto.dart';
import '../../providers/library_providers.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/empty_state_view.dart';
import '../../widgets/error_view.dart';
import '../../widgets/material_card.dart';

final globalSearchQueryProvider = StateProvider.autoDispose<String>((ref) => '');

final globalSearchResultsProvider =
    FutureProvider.autoDispose<List<MaterialItemDto>>((ref) async {
  final query = ref.watch(globalSearchQueryProvider);
  if (query.trim().isEmpty) return [];

  final repo = ref.watch(libraryRepositoryProvider);
  final results = await Future.wait([
    repo.getSummaries(keyword: query),
    repo.getLectures(keyword: query),
  ]);

  return [...results[0], ...results[1]];
});

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final Debounce _debounce = Debounce();

  @override
  void dispose() {
    _controller.dispose();
    _debounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(globalSearchQueryProvider);
    final resultsAsync = ref.watch(globalSearchResultsProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: 'بحث شامل'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'ابحث عن أي ملخص، محاضرة، أو موضوع...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          ref.read(globalSearchQueryProvider.notifier).state = '';
                          setState(() {});
                        },
                      )
                    : null,
              ),
              onChanged: (val) {
                setState(() {});
                _debounce.run(() {
                  ref.read(globalSearchQueryProvider.notifier).state = val;
                });
              },
            ),
          ),
          Expanded(
            child: query.trim().isEmpty
                ? const EmptyStateView(
                    icon: Icons.search_rounded,
                    title: 'ابحث في كافة المحتويات',
                    subtitle:
                        'اكتب اسم المساق، رقم المحاضرة، أو الفصل للبحث في قاعدة البيانات مباشرة.',
                  )
                : resultsAsync.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (err, _) => ErrorView(
                      message: err.toString(),
                      onRetry: () => ref.refresh(globalSearchResultsProvider),
                    ),
                    data: (items) {
                      if (items.isEmpty) {
                        return EmptyStateView(
                          icon: Icons.search_off_rounded,
                          title: 'لم يتم العثور على نتائج',
                          subtitle: 'لا توجد مذكرات أو محاضرات تطابق "$query"',
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.only(bottom: 24),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return MaterialCard(item: items[index]);
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
