part of 'fact_bloc.dart';

abstract class FactState extends Equatable {
  const FactState();
}

class FactInitial extends FactState {
  @override
  List<Object> get props => [];
}

class FactLoading extends FactState {
  @override
  List<Object> get props => [];
}

class FactLoaded extends FactState {
  final Fact fact;

  const FactLoaded({required this.fact});

  @override
  List<Object> get props => [fact];
}

class FactsLoaded extends FactState {
  final List<Fact> facts;

  const FactsLoaded({required this.facts});

  @override
  List<Object> get props => [facts];
}

class FactError extends FactState {
  final String message;

  const FactError(this.message);

  @override
  List<Object> get props => [message];
}
