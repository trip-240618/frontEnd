import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tripStory/data/models/response/country_visited_response.dart';

part 'country_data_source.g.dart';

@RestApi(baseUrl: "https://tripstory.shop/country")
abstract class CountryDataSource {
  factory CountryDataSource(Dio dio, {String baseUrl}) = _CountryDataSource;

  @GET("/visited")
  Future<List<CountryVisitedResponse>> fetchVisitedCountry();

  @GET("/search")
  Future<List<CountryVisitedResponse>> fetchSearchCountry();

  @GET("/search/autocomplete")
  Future<List<CountryVisitedResponse>> fetchAutoCountry();
}
