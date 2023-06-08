import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/Models/press_model.dart';
import '../../../data/repository/press_repository.dart';

part 'press_event.dart';
part 'press_state.dart';

class PressBloc extends Bloc<PressEvent, PressStates> {
  final PressRepository _rep;

  PressBloc(this._rep) : super(PressLoadingSate()) {
    on<LoadPressEvent>((event, emit) async {
      emit(PressLoadingSate());
      try {
        print("fetching");
        await _rep.fetch();
        print("done");
        final resp = await _rep.getAll();
        emit(PressLoadedState(resp));
      } catch (e) {
        emit(PressErrorState(e));
      }
    });
  }
}
