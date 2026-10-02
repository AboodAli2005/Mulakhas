class LookupDto {
  final int id;
  final String name;

  const LookupDto({
    required this.id,
    required this.name,
  });

  factory LookupDto.fromJson(Map<String, dynamic> json) {
    return LookupDto(
      id: json['id'] as int? ?? 0,
      name: (json['name'] as String? ?? '').trim(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LookupDto && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'LookupDto(id: $id, name: $name)';
}
