part of 'arproject_bloc.dart';

@immutable
abstract class ARProjectEvent extends Equatable {
  const ARProjectEvent();
}

class LoadARProjectEvent extends ARProjectEvent {
  @override
  List<Object> get props => [];
}
