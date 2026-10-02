import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/network/api_client.dart';
import '../models/lookup_dto.dart';
import '../models/subject_dto.dart';
import '../models/summary_dto.dart';
import '../repositories/library_repository.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import 'selection_provider.dart';

// SharedPreferences instance holder
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Initialize in main.dart');
});

// Services & Core
final storageServiceProvider = Provider<StorageService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return StorageService(prefs);
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

final apiServiceProvider = Provider<ApiService>((ref) {
  final client = ref.watch(apiClientProvider);
  return ApiService(client);
});

final libraryRepositoryProvider = Provider<LibraryRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return LibraryRepository(apiService);
});

// Selection State
final selectionProvider =
    StateNotifierProvider<SelectionNotifier, AcademicSelectionState>((ref) {
  final storage = ref.watch(storageServiceProvider);
  return SelectionNotifier(storage);
});

// Lookups Providers
final majorsProvider = FutureProvider<List<LookupDto>>((ref) async {
  final repo = ref.watch(libraryRepositoryProvider);
  return await repo.getMajors();
});

final levelsProvider = FutureProvider<List<LookupDto>>((ref) async {
  final repo = ref.watch(libraryRepositoryProvider);
  return await repo.getLevels();
});

final semestersProvider =
    FutureProvider.family<List<LookupDto>, int>((ref, levelId) async {
  final repo = ref.watch(libraryRepositoryProvider);
  return await repo.getSemesters(levelId: levelId);
});

final subjectsProvider = FutureProvider<List<SubjectDto>>((ref) async {
  final selection = ref.watch(selectionProvider);
  if (selection.major == null ||
      selection.level == null ||
      selection.semester == null) {
    return [];
  }
  final repo = ref.watch(libraryRepositoryProvider);
  return await repo.getSubjects(
    specialtyId: selection.major!.id,
    levelId: selection.level!.id,
    semesterId: selection.semester!.id,
  );
});

// Active Material Type tab (Summary vs Lecture)
final activeMaterialTypeProvider = StateProvider<MaterialType>((ref) {
  return MaterialType.summary;
});

// Subject filter on materials screen
final selectedSubjectFilterProvider = StateProvider<int?>((ref) => null);

// Search keyword in materials screen
final materialKeywordProvider = StateProvider<String>((ref) => '');

// Combined Materials Provider for Current Selection
final currentMaterialsProvider =
    FutureProvider.autoDispose<List<MaterialItemDto>>((ref) async {
  final selection = ref.watch(selectionProvider);
  final materialType = ref.watch(activeMaterialTypeProvider);
  final subjectId = ref.watch(selectedSubjectFilterProvider);
  final keyword = ref.watch(materialKeywordProvider);
  final repo = ref.watch(libraryRepositoryProvider);

  if (materialType == MaterialType.summary) {
    return await repo.getSummaries(
      specialtyId: selection.major?.id,
      levelId: selection.level?.id,
      semesterId: selection.semester?.id,
      subjectId: subjectId,
      keyword: keyword.isEmpty ? null : keyword,
    );
  } else {
    return await repo.getLectures(
      specialtyId: selection.major?.id,
      levelId: selection.level?.id,
      semesterId: selection.semester?.id,
      subjectId: subjectId,
      keyword: keyword.isEmpty ? null : keyword,
    );
  }
});
