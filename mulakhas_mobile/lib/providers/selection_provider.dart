import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/lookup_dto.dart';
import '../services/storage_service.dart';

class AcademicSelectionState {
  final LookupDto? major;
  final LookupDto? level;
  final LookupDto? semester;

  const AcademicSelectionState({
    this.major,
    this.level,
    this.semester,
  });

  bool get isComplete => major != null && level != null && semester != null;
  bool get hasAnySelection => major != null || level != null || semester != null;

  AcademicSelectionState copyWith({
    LookupDto? Function()? major,
    LookupDto? Function()? level,
    LookupDto? Function()? semester,
  }) {
    return AcademicSelectionState(
      major: major != null ? major() : this.major,
      level: level != null ? level() : this.level,
      semester: semester != null ? semester() : this.semester,
    );
  }
}

class SelectionNotifier extends StateNotifier<AcademicSelectionState> {
  final StorageService? _storageService;

  SelectionNotifier(this._storageService)
      : super(
          AcademicSelectionState(
            major: _storageService?.getSelectedMajor(),
            level: _storageService?.getSelectedLevel(),
            semester: _storageService?.getSelectedSemester(),
          ),
        );

  void setMajor(LookupDto major) {
    state = state.copyWith(
      major: () => major,
      level: () => null,
      semester: () => null,
    );
    _storageService?.setSelectedMajor(major);
    _storageService?.setSelectedLevel(null);
    _storageService?.setSelectedSemester(null);
  }

  void setLevel(LookupDto level) {
    state = state.copyWith(
      level: () => level,
      semester: () => null,
    );
    _storageService?.setSelectedLevel(level);
    _storageService?.setSelectedSemester(null);
  }

  void setSemester(LookupDto semester) {
    state = state.copyWith(
      semester: () => semester,
    );
    _storageService?.setSelectedSemester(semester);
  }

  void reset() {
    state = const AcademicSelectionState();
    _storageService?.setSelectedMajor(null);
    _storageService?.setSelectedLevel(null);
    _storageService?.setSelectedSemester(null);
  }
}
