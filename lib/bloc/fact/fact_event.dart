part of 'fact_bloc.dart';

abstract class FactEvent extends Equatable {
  const FactEvent();
}

class FetchFactFromApi extends FactEvent {
  @override
  List<Object> get props => [];
}

class FetchFactsFromHive extends FactEvent {
  @override
  List<Object> get props => [];
}
