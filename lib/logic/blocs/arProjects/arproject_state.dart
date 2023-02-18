part of 'arproject_bloc.dart';

@immutable
abstract class ARProjectStates extends Equatable {}

class ARProjectLoadingSate extends ARProjectStates {
  @override
  List<Object> get props => [];
}

class ARProjectLoadedState extends ARProjectStates {
  final List<DescriptionAR> projects;

  ARProjectLoadedState(this.projects);
  @override
  List<Object> get props => [projects];
}

class ARProjectErrorState extends ARProjectStates {
  final String error;

  ARProjectErrorState(this.error);
  @override
  List<Object> get props => [error];
}
