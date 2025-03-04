import '../../../../data/model/basket_model.dart';
import '../../../../data/model/favaurite_model.dart';

class CardState {
  List<BasketModel>? basketList;
  List<FavouriteModel>? favouriteList;
  int? countProduct;
  int? sum;
  int? totalSum;
  bool? isPayNow;
  bool? isCheckedAll;

  CardState(
      {this.basketList = const [],
      this.isCheckedAll,
      this.sum = 0,
      this.totalSum = 0,
      this.countProduct = 0,
      this.isPayNow = true,
      this.favouriteList = const []});

  CardState copyWith(
      {List<BasketModel>? basketList,
      int? countProduct,
      int? totalSum,
      int? sum,
      bool? isPayNow,
      bool? isCheckedAll,
      List<FavouriteModel>? favouriteList}) {
    return CardState(
        totalSum: totalSum ?? this.totalSum,
        isCheckedAll: isCheckedAll ?? this.isCheckedAll,
        favouriteList: favouriteList ?? this.favouriteList,
        basketList: basketList ?? this.basketList,
        countProduct: countProduct ?? this.countProduct,
        isPayNow: isPayNow ?? this.isPayNow,
        sum: sum ?? this.sum);
  }
}
