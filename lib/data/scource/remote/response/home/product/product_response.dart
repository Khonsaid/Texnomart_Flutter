import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_response.freezed.dart';
part 'product_response.g.dart';

@freezed
class ProductResponse with _$ProductResponse {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory ProductResponse(
    int? code,
    ProductsData? data,
    String? message,
    int? status,
    bool? success,
  ) = _ProductResponse;

  factory ProductResponse.fromJson(Map<String, dynamic> json) => _$ProductResponseFromJson(json);
}

@freezed
class ProductsData with _$ProductsData {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory ProductsData(
    List<ProductsElementData>? data,
  ) = _ProductsData;

  factory ProductsData.fromJson(Map<String, dynamic> json) => _$ProductsDataFromJson(json);
}

@freezed
class ProductsElementData with _$ProductsElementData {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory ProductsElementData(
    int? allCount,
    String? availability,
    String? axiomMonthlyPrice,
    int? benefit,
    int? discountPrice,
    int? id,
    String? image,
    int? isCanLoanOrder,
    String? name,
    int? oldPrice,
    int? reviewsAverage,
    int? reviewsCount,
    // List<int>? saleMonths,
    int? salePrice,
    List<StickersProductsElementData>? stickers,
    bool? isLiked,
  ) = _ProductsElementData;

  factory ProductsElementData.fromJson(Map<String, dynamic> json) => _$ProductsElementDataFromJson(json);
}

@freezed
class StickersProductsElementData with _$StickersProductsElementData {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory StickersProductsElementData(
    String? backgroundColor,
    String? image,
    bool? isImage,
    String? name,
    bool? showInCard,
    String? textColor,
  ) = _StickersProductsElementData;

  factory StickersProductsElementData.fromJson(Map<String, dynamic> json) =>
      _$StickersProductsElementDataFromJson(json);
}
