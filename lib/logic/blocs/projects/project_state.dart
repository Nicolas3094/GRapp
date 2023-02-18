part of 'project_bloc.dart';

@immutable
abstract class ProjectStates extends Equatable {}

class ProjectLoadingSate extends ProjectStates {
  @override
  List<Object> get props => [];
}

class ProjectLoadedState extends ProjectStates {
  final List<Project> projects;

  ProjectLoadedState(this.projects);
  @override
  List<Object> get props => [projects];
}

class ProjectErrorState extends ProjectStates {
  final String error;

  ProjectErrorState(this.error);
  @override
  List<Object> get props => [error];
}
