import 'package:cat_facts/bloc/cat/cat_bloc.dart';
import 'package:cat_facts/bloc/fact/fact_bloc.dart';
import 'package:cat_facts/routes.dart';
import 'package:cat_facts/utils/constants.dart';
import 'package:cat_facts/utils/shared/show_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

class FactsScreen extends StatefulWidget {
  const FactsScreen({super.key});

  @override
  State<FactsScreen> createState() => _FactsScreenState();
}

class _FactsScreenState extends State<FactsScreen> {
  @override
  void initState() {
    super.initState();
    loadCatsImagesAndFacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 500,
            height: 400,
            child: Card(
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 5.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<FactBloc, FactState>(
                    builder: (context, state) {
                      if (state is FactLoading) {
                        return const SizedBox(
                          width: 150,
                          height: 150,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (state is FactLoaded) {
                        final fact = state.fact;
                        return Container(
                          padding: const EdgeInsets.all(10),
                          width: 300,
                          height: 150,
                          child: SingleChildScrollView(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                fact.fact,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      }
                      if (state is FactError) {
                        showMessage(
                          context,
                          message: state.message,
                          messageType: MessageType.error,
                        );
                      }
                      return Container();
                    },
                  ),
                  BlocBuilder<CatBloc, CatState>(
                    builder: (context, state) {
                      if (state is CatLoading) {
                        return const SizedBox(
                          width: 200,
                          height: 200,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (state is CatLoaded) {
                        final cat = state.cat;
                        return SizedBox(
                          height: 200,
                          child: FadeInImage.memoryNetwork(
                            width: 180,
                            placeholder: kTransparentImage,
                            image: '$catImagesApiEndpoint/${cat.url}',
                          ),
                        );
                      } else if (state is CatError) {
                        showMessage(
                          context,
                          message: state.message,
                          messageType: MessageType.error,
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: loadCatsImagesAndFacts,
            child: const Text('Another fact'),
          ),
          ElevatedButton(
            onPressed: () => {
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.factsHistoryScreen,
              )
            },
            child: const Text('Fact history'),
          ),
        ],
      ),
    );
  }

  void loadCatsImagesAndFacts() {
    context.read<FactBloc>().add(FetchFactFromApi());
    context.read<CatBloc>().add(FetchCat());
  }
}
