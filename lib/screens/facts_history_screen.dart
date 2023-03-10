import 'package:cat_facts/bloc/fact/fact_bloc.dart';
import 'package:cat_facts/routes.dart';
import 'package:cat_facts/utils/shared/show_message.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class FactsHistoryScreen extends StatefulWidget {
  const FactsHistoryScreen({super.key});

  @override
  State<FactsHistoryScreen> createState() => _FactsHistoryScreenState();
}

class _FactsHistoryScreenState extends State<FactsHistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FactBloc>().add(FetchFactsFromHive());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => {
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.factsScreen,
            )
          },
        ),
      ),
      body: BlocBuilder<FactBloc, FactState>(
        builder: (context, state) {
          if (state is FactLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FactsLoaded) {
            final facts = state.facts;
            return ListView.builder(
              itemCount: facts.length,
              itemBuilder: (context, index) => ListTile(
                key: Key(facts[index].key),
                leading: const Icon(Icons.favorite),
                title: Text(facts[index].fact),
              ),
            );
          } else if (state is FactError) {
            showMessage(
              context,
              message: state.message,
              messageType: MessageType.error,
            );
          }
          return Container();
        },
      ),
    );
  }
}
