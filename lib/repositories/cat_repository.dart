import '../models/cat.dart';
import '../providers/cat_client.dart';

abstract class CatRepository {
  Future<Cat> getCat();
}

class CatRepositoryImplementation implements CatRepository {
  final CatClient restClient;

  CatRepositoryImplementation({required this.restClient});

  @override
  Future<Cat> getCat() async {
    return await restClient.getCat();
  }
}
