part of 'catalogue_bloc.dart';

@immutable
abstract class CatalogueStates extends Equatable {}

class CatalogueLoadingSate extends CatalogueStates {
  @override
  List<Object> get props => [];
}

class CatalogueLoadedState extends CatalogueStates {
  final List<Catalogue> catalogues;

  CatalogueLoadedState(this.catalogues);
  @override
  List<Object> get props => [catalogues];
}

class CatalogueErrorState extends CatalogueStates {
  final String error;

  CatalogueErrorState(this.error);
  @override
  List<Object> get props => [error];
}
