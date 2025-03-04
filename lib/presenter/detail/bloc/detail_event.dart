part of 'detail_bloc.dart';

abstract class DetailEvent {}

class LoadDetailDataEvent extends DetailEvent {
  final String productId;
  final String name;

  LoadDetailDataEvent(this.productId, this.name);
}

class ClickLikeEvent extends DetailEvent {
  final FavouriteModel product;

  ClickLikeEvent(this.product);
}

class ClickAddEvent extends DetailEvent {}
