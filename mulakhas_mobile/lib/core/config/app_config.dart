class AppConfig {
  static const String appName = 'ملخص | Mulakhas';
  static const String appTagline = 'المعرفة في أقل كلمات';
  static const String appVersion = '1.0.0';

  /// The base ASP.NET Core API server URL
  /// Change this constant when pointing to staging or production backend
  static const String apiBaseUrl = 'https://aug-backpack.runasp.net/api/v1';

  /// The root server host for resolving uploaded document relative paths
  static const String fileServerUrl = 'https://aug-backpack.runasp.net';

  /// Request timeouts
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 20);

  /// Helper to get full file URL from relative documentPath
  static String getFullFileUrl(String? documentPath, String? driveLink) {
    if (driveLink != null && driveLink.trim().isNotEmpty) {
      return driveLink.trim();
    }
    if (documentPath == null || documentPath.trim().isEmpty) {
      return '';
    }
    final normalizedPath = documentPath.replaceAll('\\', '/');
    if (normalizedPath.startsWith('http://') || normalizedPath.startsWith('https://')) {
      return normalizedPath;
    }
    final prefix = normalizedPath.startsWith('/') ? '' : '/';
    return '$fileServerUrl$prefix$normalizedPath';
  }
}
