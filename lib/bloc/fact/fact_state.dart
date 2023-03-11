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
