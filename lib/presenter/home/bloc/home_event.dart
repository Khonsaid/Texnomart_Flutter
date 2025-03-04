part of 'home_bloc.dart';

abstract class HomeEvent {}

class LoadDataEvent extends HomeEvent {}

class ClickProductEvent extends HomeEvent {
  final String id;

  ClickProductEvent(this.id);
}

class ClickFavouriteEvent extends HomeEvent {
  final String type;
  final FavouriteModel product;

  ClickFavouriteEvent({required this.type, required this.product});
}
