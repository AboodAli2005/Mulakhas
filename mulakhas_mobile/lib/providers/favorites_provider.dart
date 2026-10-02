import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/summary_dto.dart';
import 'library_providers.dart';

class FavoritesNotifier extends StateNotifier<List<MaterialItemDto>> {
  final Ref _ref;

  FavoritesNotifier(this._ref) : super([]) {
    _load();
  }

  void _load() {
    final storage = _ref.read(storageServiceProvider);
    state = storage.getFavorites();
  }

  void toggleFavorite(MaterialItemDto item) {
    final exists = state.any((e) => e.id == item.id);
    if (exists) {
      state = state.where((e) => e.id != item.id).toList();
    } else {
      state = [item, ...state];
    }
    _ref.read(storageServiceProvider).saveFavorites(state);
  }

  bool isFavorite(int id) {
    return state.any((e) => e.id == id);
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<MaterialItemDto>>((ref) {
  return FavoritesNotifier(ref);
});
