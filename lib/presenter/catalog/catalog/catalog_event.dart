part of 'catalog_bloc.dart';

abstract class CatalogEvent {}

class LoadCatalogEvent extends CatalogEvent {
  String slug;

  LoadCatalogEvent(this.slug);
}
