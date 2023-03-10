import 'package:cat_facts/bloc/cat/cat_bloc.dart';
import 'package:cat_facts/bloc/fact/fact_bloc.dart';
import 'package:cat_facts/models/fact.dart';
import 'package:cat_facts/providers/cat_client.dart';
import 'package:cat_facts/providers/fact_client.dart';
import 'package:cat_facts/repositories/cat_repository.dart';
import 'package:cat_facts/repositories/fact_repository.dart';
import 'package:cat_facts/routes.dart';
import 'package:cat_facts/screens/facts_history_screen.dart';
import 'package:cat_facts/screens/facts_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.deleteFromDisk();
  Hive.registerAdapter(FactAdapter());
  await Hive.openBox<Fact>('facts');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FactBloc(
            factRepository: FactRepositoryImplementation(
              restClient: FactClient(Dio()),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => CatBloc(
            catRepository: CatRepositoryImplementation(
              restClient: CatClient(Dio()),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          AppRoutes.factsScreen: (context) => const FactsScreen(),
          AppRoutes.factsHistoryScreen: (context) => const FactsHistoryScreen(),
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
