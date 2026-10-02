class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic details;

  ApiException({
    required this.message,
    this.statusCode,
    this.details,
  });

  @override
  String toString() => 'ApiException(statusCode: $statusCode, message: $message)';
}

class NetworkException extends ApiException {
  NetworkException({String message = 'لا يوجد اتصال بالإنترنت، يرجى التحقق من الشبكة'})
      : super(message: message, statusCode: 0);
}

class ServerException extends ApiException {
  ServerException({String message = 'حدث خطأ في الخادم، يرجى المحاولة لاحقاً', int? statusCode})
      : super(message: message, statusCode: statusCode);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException({String message = 'غير مصرح بالوصول'})
      : super(message: message, statusCode: 401);
}

class NotFoundException extends ApiException {
  NotFoundException({String message = 'المحتوى المطلوب غير موجود'})
      : super(message: message, statusCode: 404);
}
