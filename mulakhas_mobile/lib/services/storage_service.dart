import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/lookup_dto.dart';
import '../models/summary_dto.dart';

class StorageService {
  static const String _keyDarkMode = 'is_dark_mode';
  static const String _keyFavorites = 'favorite_materials';
  static const String _keyMajor = 'selected_major';
  static const String _keyLevel = 'selected_level';
  static const String _keySemester = 'selected_semester';

  final SharedPreferences _prefs;

  StorageService(this._prefs);

  // Theme
  bool get isDarkMode => _prefs.getBool(_keyDarkMode) ?? false;
  Future<bool> setDarkMode(bool value) => _prefs.setBool(_keyDarkMode, value);

  // Favorites
  List<MaterialItemDto> getFavorites() {
    final list = _prefs.getStringList(_keyFavorites) ?? [];
    return list.map((itemStr) {
      final json = jsonDecode(itemStr) as Map<String, dynamic>;
      return MaterialItemDto.fromJson(json);
    }).toList();
  }

  Future<bool> saveFavorites(List<MaterialItemDto> items) {
    final list = items.map((item) => jsonEncode(item.toJson())).toList();
    return _prefs.setStringList(_keyFavorites, list);
  }

  // Selection Persistence
  LookupDto? getSelectedMajor() {
    final str = _prefs.getString(_keyMajor);
    if (str == null) return null;
    return LookupDto.fromJson(jsonDecode(str) as Map<String, dynamic>);
  }

  Future<bool> setSelectedMajor(LookupDto? major) {
    if (major == null) return _prefs.remove(_keyMajor);
    return _prefs.setString(_keyMajor, jsonEncode(major.toJson()));
  }

  LookupDto? getSelectedLevel() {
    final str = _prefs.getString(_keyLevel);
    if (str == null) return null;
    return LookupDto.fromJson(jsonDecode(str) as Map<String, dynamic>);
  }

  Future<bool> setSelectedLevel(LookupDto? level) {
    if (level == null) return _prefs.remove(_keyLevel);
    return _prefs.setString(_keyLevel, jsonEncode(level.toJson()));
  }

  LookupDto? getSelectedSemester() {
    final str = _prefs.getString(_keySemester);
    if (str == null) return null;
    return LookupDto.fromJson(jsonDecode(str) as Map<String, dynamic>);
  }

  Future<bool> setSelectedSemester(LookupDto? semester) {
    if (semester == null) return _prefs.remove(_keySemester);
    return _prefs.setString(_keySemester, jsonEncode(semester.toJson()));
  }
}
