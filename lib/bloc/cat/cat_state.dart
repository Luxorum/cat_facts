part of 'cat_bloc.dart';

abstract class CatState extends Equatable {
  const CatState();
}

class CatInitial extends CatState {
  @override
  List<Object> get props => [];
}

class CatLoading extends CatState {
  @override
  List<Object> get props => [];
}

class CatLoaded extends CatState {
  final Cat cat;

  const CatLoaded({required this.cat});

  @override
  List<Object> get props => [Cat];
}

class CatError extends CatState {
  final String message;

  const CatError(this.message);

  @override
  List<Object> get props => [message];
}
