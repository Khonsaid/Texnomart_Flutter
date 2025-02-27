import 'package:hive_ce/hive.dart';

part 'favaurite_model.g.dart';

@HiveType(typeId: 2)
class FavouriteModel extends HiveObject {
  @HiveField(0)
  String? image;
  @HiveField(1)
  String? name;
  @HiveField(2)
  int? price;
  @HiveField(3)
  String? minimalLoan;
  @HiveField(4)
  int? productId;

  FavouriteModel({
    this.productId,
    this.image,
    this.name,
    this.price,
    this.minimalLoan,
  });

  FavouriteModel copyWith({
    String? image,
    String? name,
    int? price,
    String? minimalLoan,
    int? count,
    bool? isChecked,
    int? productId,
  }) {
    return FavouriteModel(
      image: image ?? this.image,
      name: name ?? this.name,
      price: price ?? this.price,
      minimalLoan: minimalLoan ?? this.minimalLoan,
      productId: productId ?? this.productId,
    );
  }
}
