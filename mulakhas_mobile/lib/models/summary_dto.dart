import '../config/app_config.dart';

enum MaterialType {
  summary,
  lecture;

  String get displayName => this == MaterialType.summary ? 'ملخص' : 'محاضرة';
}

class MaterialItemDto {
  final int id;
  final int subjectId;
  final String title;
  final String? subjectName;
  final String? levelName;
  final String? semesterName;
  final int type;
  final String? driveLink;
  final String? documentPath;
  final String? notes;
  final String? keyword;

  const MaterialItemDto({
    required this.id,
    required this.subjectId,
    required this.title,
    this.subjectName,
    this.levelName,
    this.semesterName,
    required this.type,
    this.driveLink,
    this.documentPath,
    this.notes,
    this.keyword,
  });

  factory MaterialItemDto.fromJson(Map<String, dynamic> json) {
    return MaterialItemDto(
      id: json['id'] as int? ?? 0,
      subjectId: json['subjectId'] as int? ?? 0,
      title: (json['title'] as String? ?? '').trim(),
      subjectName: json['subjectName'] as String?,
      levelName: json['levelName'] as String?,
      semesterName: json['semesterName'] as String?,
      type: json['type'] as int? ?? 1,
      driveLink: json['driveLink'] as String?,
      documentPath: json['documentPath'] as String?,
      notes: json['notes'] as String?,
      keyword: json['keyword'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'subjectId': subjectId,
        'title': title,
        'subjectName': subjectName,
        'levelName': levelName,
        'semesterName': semesterName,
        'type': type,
        'driveLink': driveLink,
        'documentPath': documentPath,
        'notes': notes,
        'keyword': keyword,
      };

  /// Computes full resolvable URL for this document
  String get fullUrl => AppConfig.getFullFileUrl(documentPath, driveLink);

  /// Checks if file is PDF
  bool get isPdf {
    final lower = (documentPath ?? driveLink ?? '').toLowerCase();
    return lower.contains('.pdf');
  }

  /// Checks if file is Word / Docx
  bool get isDocx {
    final lower = (documentPath ?? driveLink ?? '').toLowerCase();
    return lower.contains('.doc') || lower.contains('.docx');
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MaterialItemDto &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
