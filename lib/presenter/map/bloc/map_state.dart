part of 'map_bloc.dart';

class MapState {
  List<AddressData>? data;

  MapState({this.data});

  MapState copyWith({
    List<AddressData>? data,
  }) =>
      MapState(
        data: data ?? this.data,
      );
}
