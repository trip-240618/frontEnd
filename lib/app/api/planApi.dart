import 'package:http/http.dart' as http;

class ApiPlanClient {
  final http.Client httpClient;

  ApiPlanClient({http.Client? httpClient}) : httpClient = httpClient ?? http.Client();

  Future<void> checkPlanIndex(String roomId) async {
    final url = 'https://trip-story.site/plan/${roomId}/update/order/possible';
    final response = await httpClient.get(Uri.parse(url));
  }

  Future<void> cancelPlanIndex(String roomId) async {
    final url = 'https://trip-story.site/plan/${roomId}/update/order/cancel';
    final response = await httpClient.get(Uri.parse(url));
  }
}

