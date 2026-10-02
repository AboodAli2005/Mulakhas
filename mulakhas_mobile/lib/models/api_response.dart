class ApiResponse<T> {
  final bool success;
  final String? message;
  final T? data;
  final dynamic errors;

  ApiResponse({
    required this.success,
    this.message,
    this.data,
    this.errors,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String?,
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      errors: json['errors'],
    );
  }
}

class PagedData<T> {
  final List<T> items;
  final int totalCount;

  PagedData({
    required this.items,
    required this.totalCount,
  });

  factory PagedData.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    final list = json['data'] as List<dynamic>? ?? [];
    return PagedData<T>(
      items: list.map((item) => fromJsonT(item)).toList(),
      totalCount: json['totalCount'] as int? ?? list.length,
    );
  }
}
