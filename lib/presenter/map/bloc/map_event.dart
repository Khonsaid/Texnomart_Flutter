part of 'map_bloc.dart';

abstract class MapEvent {}

class LoadMapData extends MapEvent{
  List<AddressData>? data;

  LoadMapData(this.data);
}