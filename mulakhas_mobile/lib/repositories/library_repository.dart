import '../models/lookup_dto.dart';
import '../models/subject_dto.dart';
import '../models/summary_dto.dart';
import '../services/api_service.dart';

class LibraryRepository {
  final ApiService _apiService;

  LibraryRepository(this._apiService);

  Future<List<LookupDto>> getMajors() => _apiService.getMajors();

  Future<List<LookupDto>> getLevels() => _apiService.getLevels();

  Future<List<LookupDto>> getSemesters({required int levelId}) =>
      _apiService.getSemesters(levelId: levelId);

  Future<List<SubjectDto>> getSubjects({
    required int specialtyId,
    required int levelId,
    required int semesterId,
  }) =>
      _apiService.getSubjects(
        specialtyId: specialtyId,
        levelId: levelId,
        semesterId: semesterId,
      );

  Future<List<MaterialItemDto>> getSummaries({
    int? specialtyId,
    int? levelId,
    int? semesterId,
    int? subjectId,
    String? keyword,
    int? take,
  }) =>
      _apiService.getSummaries(
        specialtyId: specialtyId,
        levelId: levelId,
        semesterId: semesterId,
        subjectId: subjectId,
        keyword: keyword,
        take: take,
      );

  Future<List<MaterialItemDto>> getLectures({
    int? specialtyId,
    int? levelId,
    int? semesterId,
    int? subjectId,
    String? keyword,
    int? take,
  }) =>
      _apiService.getLectures(
        specialtyId: specialtyId,
        levelId: levelId,
        semesterId: semesterId,
        subjectId: subjectId,
        keyword: keyword,
        take: take,
      );
}
