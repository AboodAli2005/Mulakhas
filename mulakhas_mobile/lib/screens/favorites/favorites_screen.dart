import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/favorites_provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/empty_state_view.dart';
import '../../widgets/material_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: 'المفضلة والمحفوظات'),
      body: favorites.isEmpty
          ? const EmptyStateView(
              icon: Icons.bookmark_border_rounded,
              title: 'قائمة المفضلة فارغة',
              subtitle:
                  'اضغط على رمز الإشارة المرجعية بجانب أي ملخص أو محاضرة لحفظها هنا والرجوع إليها بسهولة.',
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return MaterialCard(item: favorites[index]);
              },
            ),
    );
  }
}
