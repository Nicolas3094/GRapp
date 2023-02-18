import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_mcp/data/repository/catalogue_rep.dart';
import 'package:meta/meta.dart';

import '../../../data/Models/catalogue.dart';

part 'catalogue_event.dart';
part 'catalogue_state.dart';

class CatalogueBloc extends Bloc<CatalogueEvent, CatalogueStates> {
  final CatalogueRepository _rep;

  CatalogueBloc(this._rep) : super(CatalogueLoadingSate()) {
    on<LoadCatalogueEvent>((event, emit) async {
      emit(CatalogueLoadingSate());
      try {
        await _rep.fetch();
        final resp = await _rep.getAll();
        emit(CatalogueLoadedState(resp));
      } catch (e) {
        emit(CatalogueErrorState(e));
      }
    });
  }
}
