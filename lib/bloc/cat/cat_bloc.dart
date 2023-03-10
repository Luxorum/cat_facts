import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/cat.dart';
import '../../repositories/cat_repository.dart';

part 'cat_event.dart';
part 'cat_state.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  final CatRepository catRepository;

  CatBloc({required this.catRepository}) : super(CatInitial()) {
    on<FetchCat>((event, emit) async {
      emit(CatLoading());
      try {
        final Cat cat = await catRepository.getCat();
        emit(CatLoaded(cat: cat));
      } catch (e) {
        String message;
        if (e is DioError) {
          message = 'Network error';
        } else {
          message = 'Unknown error';
        }
        emit(CatError(message));
      }
    });
  }
}
