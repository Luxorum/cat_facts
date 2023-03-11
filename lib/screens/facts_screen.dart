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
      body: Builder(
        builder: (context) {
          final factState = context.watch<FactBloc>().state;
          final catState = context.watch<CatBloc>().state;
          if (factState is FactError) {
            showMessage(
              context,
              message: factState.message,
              messageType: MessageType.error,
            );
          }
          if (catState is CatError) {
            showMessage(
              context,
              message: catState.message,
              messageType: MessageType.error,
            );
          }
          return SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (factState is FactLoading) ...[
                            const SizedBox(
                              width: 150,
                              height: 150,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          ] else if (factState is FactLoaded) ...[
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: 300,
                              height: 150,
                              child: Column(
                                children: [
                                  Text(
                                      'Created at ${factState.fact.createdAt}'),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          factState.fact.fact,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                          if (catState is CatLoading) ...[
                            const SizedBox(
                              width: 200,
                              height: 200,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          ] else if (catState is CatLoaded) ...[
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight: 150,
                                maxWidth: 150,
                              ),
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image:
                                    '$catImagesApiEndpoint/${catState.cat.url}',
                              ),
                            )
                          ]
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: factState is FactLoading || catState is CatLoading
                      ? null
                      : loadCatsImagesAndFacts,
                  child: const Text('Another fact'),
                ),
                ElevatedButton(
                  onPressed: factState is FactLoading || catState is CatLoading
                      ? null
                      : () => {
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
        },
      ),
    );
  }

  void loadCatsImagesAndFacts() {
    context.read<FactBloc>().add(FetchFactFromApi());
    context.read<CatBloc>().add(FetchCat());
  }
}
