import 'package:cat_facts/models/fact.dart';
import 'package:cat_facts/providers/fact_client.dart';
import 'package:hive/hive.dart';

abstract class FactRepository {
  Future<Fact> fetchFactFromApi();
  List<Fact> fetchFactsFromHive();
  Future<void> saveFact(Fact fact);
}

class FactRepositoryImplementation implements FactRepository {
  final FactClient restClient;

  FactRepositoryImplementation({required this.restClient});

  final _factBox = Hive.box<Map<String, dynamic>>('facts');

  @override
  Future<Fact> fetchFactFromApi() async {
    final fact = await restClient.getFact();
    return fact;
  }

  @override
  List<Fact> fetchFactsFromHive() {
    List<Fact> facts = [];

    facts = _factBox.values.map((element) {
      final fact = Fact.fromJson(element);
      return fact;
    }).toList();

    return facts;
  }

  @override
  Future<void> saveFact(Fact fact) async {
    try {
      await _factBox.add(fact.toJson());
    } catch (e) {
      await _factBox.deleteFromDisk();
    }
  }
}
