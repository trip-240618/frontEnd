class UrlUtils {
  static String getBaseUrl(String url) {
    final uri = Uri.parse(url);
    return uri.path;
  }
}
