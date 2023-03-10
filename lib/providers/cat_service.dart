import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../models/cat.dart';

part 'cat_service.g.dart';

@RestApi(baseUrl: 'https://cataas.com')
abstract class CatClient {
  factory CatClient(Dio dio, {String baseUrl}) = _CatClient;

  @GET('/cat?json=true')
  Future<Cat> getCat();
}
