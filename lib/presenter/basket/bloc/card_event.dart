import '../../../../data/model/basket_model.dart';
import '../../../../data/model/favaurite_model.dart';

abstract class CardEvent {}

class LoadBasketItemsEvent extends CardEvent {}

class AddBasketItemEvent extends CardEvent {
  final BasketModel data;

  AddBasketItemEvent(this.data);
}

class RemoveBasketItemEvent extends CardEvent {
  int id;

  RemoveBasketItemEvent(this.id);
}

class BasketItemsUpdatedEvent extends CardEvent {
  final int? id;
  final int? count;
  final bool? isChecked;

  BasketItemsUpdatedEvent({this.id, this.count, this.isChecked});
}

class SwitchPayEvent extends CardEvent {
  final bool isPayNow;

  SwitchPayEvent(this.isPayNow);
}

class ToggleFavouriteEvent extends CardEvent {
  FavouriteModel product;

  ToggleFavouriteEvent(this.product);
}

class ToggleCheckBocEvent extends CardEvent {
  BasketModel product;

  ToggleCheckBocEvent(this.product);
}

class CalculateSumEvent extends CardEvent{}

class CheckAllEvent extends CardEvent{}