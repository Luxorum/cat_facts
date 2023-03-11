import 'package:cat_facts/repositories/fact_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/fact.dart';

part 'fact_event.dart';
part 'fact_state.dart';

class FactBloc extends Bloc<FactEvent, FactState> {
  final FactRepository factRepository;

  FactBloc({required this.factRepository}) : super(FactInitial()) {
    on<FetchFactFromApi>((event, emit) async {
      emit(FactLoading());
      try {
        final Fact fact = await factRepository.fetchFactFromApi();
        await factRepository.saveFact(fact);
        emit(FactsLoaded(facts: [fact]));
      } catch (e) {
        String message;
        if (e is DioError) {
          message = 'Network error';
        } else {
          message = 'Unknown error';
        }
        emit(FactError(message));
      }
    });
    on<FetchFactsFromHive>((event, emit) async {
      emit(FactLoading());
      try {
        final List<Fact> facts = factRepository.fetchFactsFromHive();
        emit(FactsLoaded(facts: facts));
      } catch (e) {
        emit(FactError(e.toString()));
      }
    });
  }
}
