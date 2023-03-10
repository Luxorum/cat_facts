import 'package:cat_facts/models/fact.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'fact_service.g.dart';

@RestApi(baseUrl: 'https://catfact.ninja')
abstract class FactClient {
  factory FactClient(Dio dio, {String baseUrl}) = _FactClient;

  @GET('/fact')
  Future<Fact> getFact();
}
