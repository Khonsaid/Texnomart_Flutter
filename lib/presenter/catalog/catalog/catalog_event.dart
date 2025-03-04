part of 'catalog_bloc.dart';

abstract class CatalogEvent {}

class LoadCatalogEvent extends CatalogEvent {
  String slug;
  String title;
  int index;

  LoadCatalogEvent(this.slug, this.title, {this.index = -1});
}

class SetSelectedIndexEvent extends CatalogEvent {
  int index;

  SetSelectedIndexEvent(this.index);
}
class FilterChangeEvent extends CatalogEvent {}