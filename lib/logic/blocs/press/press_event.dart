part of 'press_bloc.dart';

@immutable
abstract class PressEvent extends Equatable {
  const PressEvent();
}

class LoadPressEvent extends PressEvent {
  @override
  List<Object> get props => [];
}
