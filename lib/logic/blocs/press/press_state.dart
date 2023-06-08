part of 'press_bloc.dart';

@immutable
abstract class PressStates extends Equatable {}

class PressLoadingSate extends PressStates {
  @override
  List<Object> get props => [];
}

class PressLoadedState extends PressStates {
  final List<Press> press;

  PressLoadedState(this.press);
  @override
  List<Object> get props => [press];
}

class PressErrorState extends PressStates {
  final String error;

  PressErrorState(this.error);
  @override
  List<Object> get props => [error];
}
