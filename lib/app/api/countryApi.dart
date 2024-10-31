import 'package:tripStory/app/config/dio_client.dart';


class ApiCountryClient {
  final DioClient dioClient;

  ApiCountryClient(this.dioClient);

  /// 다녀온 나라 가져오기
  Future<List> getCountry() async {
    try {
      final response = await dioClient.dio.get(
        '/country/visited'
      );
      if (response.statusCode == 200) {
        final data = response.data;
        if(data.length==0){
          return [];
        }
        return data;
      } else {
        throw Exception('error : ${response.statusCode}');
      }
    } catch (e) {
      print('Error during auto-login: $e');
      rethrow;
    }
  }

}
