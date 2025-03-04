import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/scource/locel/hive_helper.dart';
import 'card_event.dart';
import 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(CardState()) {
    on<LoadBasketItemsEvent>((event, emit) {
      final list = HiveHelper.getBasket();
      final favouriteList = HiveHelper.getFavourite();

      final basketList = list.map((item) {
        bool isLiked = favouriteList.any((fav) => fav.productId == item.productId);
        return item.copyWith(isLiked: isLiked);
      }).toList();

      final isAllChecked = basketList.every((element) => element.isChecked == true);

      emit(state.copyWith(basketList: basketList, favouriteList: favouriteList, isCheckedAll: isAllChecked));
      add(CalculateSumEvent());
    });

    on<AddBasketItemEvent>((event, emit) {
      HiveHelper.addBasketModel(event.data);
      final list = HiveHelper.getBasket();
      emit(state.copyWith(basketList: list));
    });

    on<CalculateSumEvent>((event, emit) {
      final basketList = state.basketList ?? HiveHelper.getBasket();

      final checkedItems = basketList.where((item) => item.isChecked).toList();

      /* final sum = checkedItems.fold<int>(0, (total, item) {
        return total + (item.price ?? 0 * (item.count));
      });*/
      var sum = 0;
      for (int i = 0; i < checkedItems.length; i++) {
        sum += checkedItems[i].count * (checkedItems[i].price ?? 1);
      }
      var count = 0;
      for (int i = 0; i < checkedItems.length; i++) {
        count += checkedItems[i].count;
      }

      emit(state.copyWith(countProduct: count, sum: sum));
    });

    on<RemoveBasketItemEvent>((event, emit) {
      HiveHelper.removeBasketModel(event.id);
      final list = HiveHelper.getBasket();
      add(CalculateSumEvent());
      emit(state.copyWith(basketList: list));
    });

    on<BasketItemsUpdatedEvent>((event, emit) {
      print("TTT befor ${state.basketList?[0].count}");
      HiveHelper.updateBasketModel(event.id, event.count, event.isChecked);
      final baskets = HiveHelper.getBasket();
      add(CalculateSumEvent());

      final isAllChecked = baskets.every((element) => element.isChecked == true);
      print("TTT after ${state.basketList?[0].count}");

      emit(state.copyWith(basketList: baskets, isCheckedAll: isAllChecked));
    });

    on<SwitchPayEvent>((event, emit) {
      emit(state.copyWith(isPayNow: event.isPayNow));
    });

    on<ToggleFavouriteEvent>((event, emit) {
      HiveHelper.toggleFavourite(event.product);
      final favouriteList = HiveHelper.getFavourite();
      final basketList = state.basketList?.map((item) {
        bool isLiked = favouriteList.any((fav) => fav.productId == item.productId);
        return item.copyWith(isLiked: isLiked);
      }).toList();
      emit(state.copyWith(favouriteList: favouriteList, basketList: basketList));
    });

    on<CheckAllEvent>((event, emit) {
      final basketList = state.basketList?.map((item) {
        return item.copyWith(isChecked: state.isCheckedAll ?? false ? false : true);
      }).toList();

      emit(state.copyWith(basketList: basketList, isCheckedAll: !(state.isCheckedAll ?? false)));
      add(CalculateSumEvent());
    });
  }
}
