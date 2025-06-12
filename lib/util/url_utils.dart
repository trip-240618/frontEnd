class UrlUtils {
  static String getBaseUrl(String url) {
    return url.split("?").first;
  }
}
