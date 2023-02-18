import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_mcp/data/Models/project.dart';
import 'package:g_mcp/data/repository/projects_rep.dart';
import 'package:meta/meta.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectStates> {
  final ProjectRepository _rep;

  ProjectBloc(this._rep) : super(ProjectLoadingSate()) {
    on<LoadProjectEvent>((event, emit) async {
      emit(ProjectLoadingSate());
      try {
        print("fetching");
        await _rep.fetch();
        print("done");
        final resp = await _rep.getAll();
        emit(ProjectLoadedState(resp));
      } catch (e) {
        emit(ProjectErrorState(e));
      }
    });
  }
}
