part of 'catalogue_bloc.dart';

@immutable
abstract class CatalogueEvent extends Equatable {
  const CatalogueEvent();
}

class LoadCatalogueEvent extends CatalogueEvent {
  @override
  List<Object> get props => [];
}
