import 'package:hive_ce/hive.dart';

part 'basket_model.g.dart';

@HiveType(typeId: 1)
class BasketModel extends HiveObject {
  @HiveField(0)
  String? image;
  @HiveField(1)
  String? name;
  @HiveField(2)
  int? price;
  @HiveField(3)
  String? minimalLoan;
  @HiveField(4)
  int count;
  @HiveField(5)
  bool isChecked;
  @HiveField(6)
  int? productId;
  @HiveField(7)
  bool isLiked;

  BasketModel({
    this.productId,
    this.image,
    this.name,
    this.price,
    this.minimalLoan,
    this.count = 1,
    this.isChecked = false,
    this.isLiked = false,
  });

  BasketModel copyWith(
      {String? image,
      String? name,
      int? price,
      String? minimalLoan,
      int? count,
      bool? isChecked,
      int? productId,
      bool? isLiked}) {
    return BasketModel(
      image: image ?? this.image,
      name: name ?? this.name,
      price: price ?? this.price,
      minimalLoan: minimalLoan ?? this.minimalLoan,
      count: count ?? this.count,
      isLiked: isLiked ?? this.isLiked,
      isChecked: isChecked ?? this.isChecked,
      productId: productId ?? this.productId,
    );
  }
}
