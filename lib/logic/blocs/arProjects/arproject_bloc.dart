import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_mcp/data/repository/arPorjects_repository.dart';

import 'package:meta/meta.dart';

import '../../../data/Models/DescriptionAR.dart';

part 'arproject_event.dart';
part 'arproject_state.dart';

class ARProjectBloc extends Bloc<ARProjectEvent, ARProjectStates> {
  final ARProjectRepository _rep;

  ARProjectBloc(this._rep) : super(ARProjectLoadingSate()) {
    on<LoadARProjectEvent>((event, emit) async {
      emit(ARProjectLoadingSate());
      try {
        await _rep.fetch();
        final resp = await _rep.getAll();
        emit(ARProjectLoadedState(resp));
      } catch (e) {
        emit(ARProjectErrorState(e));
      }
    });
  }
}
