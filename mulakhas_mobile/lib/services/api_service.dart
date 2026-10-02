import '../core/constants/api_endpoints.dart';
import '../core/network/api_client.dart';
import '../models/api_response.dart';
import '../models/lookup_dto.dart';
import '../models/subject_dto.dart';
import '../models/summary_dto.dart';

class ApiService {
  final ApiClient _client;

  ApiService(this._client);

  /// GET /api/v1/majors
  Future<List<LookupDto>> getMajors() async {
    final response = await _client.get(ApiEndpoints.majors);
    final raw = response.data;
    if (raw is Map<String, dynamic> && raw['data'] is List) {
      return (raw['data'] as List)
          .map((item) => LookupDto.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// GET /api/v1/levels
  Future<List<LookupDto>> getLevels() async {
    final response = await _client.get(ApiEndpoints.levels);
    final raw = response.data;
    if (raw is Map<String, dynamic> && raw['data'] is List) {
      return (raw['data'] as List)
          .map((item) => LookupDto.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// GET /api/v1/semesters?levelId={levelId}
  Future<List<LookupDto>> getSemesters({required int levelId}) async {
    final response = await _client.get(
      ApiEndpoints.semesters,
      queryParameters: {'levelId': levelId},
    );
    final raw = response.data;
    if (raw is Map<String, dynamic> && raw['data'] is List) {
      return (raw['data'] as List)
          .map((item) => LookupDto.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// GET /api/v1/subjects?SpecialtyId={specialtyId}&LevelId={levelId}&SemesterId={semesterId}
  Future<List<SubjectDto>> getSubjects({
    required int specialtyId,
    required int levelId,
    required int semesterId,
  }) async {
    final response = await _client.get(
      ApiEndpoints.subjects,
      queryParameters: {
        'SpecialtyId': specialtyId,
        'LevelId': levelId,
        'SemesterId': semesterId,
      },
    );
    final raw = response.data;
    if (raw is Map<String, dynamic> && raw['data'] is Map<String, dynamic>) {
      final paged = PagedData<SubjectDto>.fromJson(
        raw['data'] as Map<String, dynamic>,
        (item) => SubjectDto.fromJson(item as Map<String, dynamic>),
      );
      return paged.items;
    }
    return [];
  }

  /// GET /api/v1/summaries
  Future<List<MaterialItemDto>> getSummaries({
    int? specialtyId,
    int? levelId,
    int? semesterId,
    int? subjectId,
    String? keyword,
    int? take,
  }) async {
    final params = <String, dynamic>{};
    if (specialtyId != null) params['SpecialtyId'] = [specialtyId];
    if (levelId != null) params['LevelId'] = levelId;
    if (semesterId != null) params['SemesterId'] = semesterId;
    if (subjectId != null) params['SubjectId'] = subjectId;
    if (keyword != null && keyword.trim().isNotEmpty) {
      params['Keyword'] = keyword.trim();
    }
    if (take != null) params['Take'] = take;

    final response = await _client.get(
      ApiEndpoints.summaries,
      queryParameters: params,
    );
    final raw = response.data;
    if (raw is Map<String, dynamic> && raw['data'] is Map<String, dynamic>) {
      final paged = PagedData<MaterialItemDto>.fromJson(
        raw['data'] as Map<String, dynamic>,
        (item) => MaterialItemDto.fromJson(item as Map<String, dynamic>),
      );
      return paged.items;
    }
    return [];
  }

  /// GET /api/v1/lectures
  Future<List<MaterialItemDto>> getLectures({
    int? specialtyId,
    int? levelId,
    int? semesterId,
    int? subjectId,
    String? keyword,
    int? take,
  }) async {
    final params = <String, dynamic>{};
    if (specialtyId != null) params['SpecialtyId'] = [specialtyId];
    if (levelId != null) params['LevelId'] = levelId;
    if (semesterId != null) params['SemesterId'] = semesterId;
    if (subjectId != null) params['SubjectId'] = subjectId;
    if (keyword != null && keyword.trim().isNotEmpty) {
      params['Keyword'] = keyword.trim();
    }
    if (take != null) params['Take'] = take;

    final response = await _client.get(
      ApiEndpoints.lectures,
      queryParameters: params,
    );
    final raw = response.data;
    if (raw is Map<String, dynamic> && raw['data'] is Map<String, dynamic>) {
      final paged = PagedData<MaterialItemDto>.fromJson(
        raw['data'] as Map<String, dynamic>,
        (item) => MaterialItemDto.fromJson(item as Map<String, dynamic>),
      );
      return paged.items;
    }
    return [];
  }
}
