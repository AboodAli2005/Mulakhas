class SubjectDto {
  final int id;
  final String name;
  final String? levelName;
  final String? semesterName;

  const SubjectDto({
    required this.id,
    required this.name,
    this.levelName,
    this.semesterName,
  });

  factory SubjectDto.fromJson(Map<String, dynamic> json) {
    return SubjectDto(
      id: json['id'] as int? ?? 0,
      name: (json['name'] as String? ?? '').trim(),
      levelName: json['levelName'] as String?,
      semesterName: json['semesterName'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'levelName': levelName,
        'semesterName': semesterName,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectDto && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'SubjectDto(id: $id, name: $name)';
}
