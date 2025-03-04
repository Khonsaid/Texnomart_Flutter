import 'package:bloc/bloc.dart';

import '../../../data/scource/remote/response/detail/available_stores/available_stores.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState()) {
    on<LoadMapData>((event, emit) {
      print("TTT LoadMapData ${event.data}");
      emit(state.copyWith(data: event.data));
    });
  }
}
