part of 'cat_bloc.dart';

abstract class CatEvent extends Equatable {
  const CatEvent();
}

class FetchCat extends CatEvent {
  @override
  List<Object> get props => [];
}
