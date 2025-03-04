import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:texnomart/data/model/basket_model.dart';

import '../../model/favaurite_model.dart';

class HiveHelper {
  static String favourite = 'favourite';
  static String basket = 'basket';

  static Future<void> init() async {
    final dir = await getApplicationCacheDirectory();
    Hive.init(dir.path);

    Hive.registerAdapter(BasketModelAdapter());
    Hive.registerAdapter(FavouriteModelAdapter());
    await Hive.openBox<BasketModel>(basket);
    await Hive.openBox<FavouriteModel>(favourite);
  }

  static void addFavourite(FavouriteModel product) {
    final favouriteBox = Hive.box<FavouriteModel>(favourite);
    favouriteBox.put(product.productId, product);
  }

  static List<FavouriteModel> getFavourite() {
    final favouriteBox = Hive.box<FavouriteModel>(favourite);
    return favouriteBox.values.toList();
  }

  static void removeFavourite(FavouriteModel product) {
    final box = Hive.box<FavouriteModel>(favourite);
    box.delete(product.productId);
  }

  static bool hasFavourite(int productId) {
    final box = Hive.box<FavouriteModel>(favourite);
    return box.containsKey(productId);
  }

  static void toggleFavourite(FavouriteModel product) {
    if (hasFavourite(product.productId??0)) {
      removeFavourite(product);
    } else {
      addFavourite(product);
    }
  }

  static void saveBasket(List<BasketModel> data) {
    final basketBox = Hive.box<BasketModel>(basket);
    basketBox.addAll(data);
  }

  static List<BasketModel> getBasket() {
    final basketBox = Hive.box<BasketModel>(basket);
    return basketBox.values.toList();
  }

  static hasBasketModel(int id) {
    final basketBox = Hive.box<BasketModel>(basket);
    return basketBox.containsKey(id);
  }

  static void addBasketModel(BasketModel data) {
    final basketBox = Hive.box<BasketModel>(basket);
    if (!basketBox.containsKey(data.productId)) {
      basketBox.put(data.productId, data); // Faqat mavjud bo‘lmasa qo‘shadi
    }
  }

  static void removeBasketModel(int id) {
    final basketBox = Hive.box<BasketModel>(basket);
    basketBox.delete(id);
  }

  static void updateBasketModel(int? productId, int? count, bool? isChecked) {
    final basketBox = Hive.box<BasketModel>(basket);
    final basketItem = basketBox.get(productId);

    if (basketItem != null) {
      if (count != null) basketItem.count = count;
      if (isChecked != null) basketItem.isChecked = !isChecked;
      basketItem.save(); // Faqat o‘zgargan qiymatlarni saqlaydi
    }
  }
}
