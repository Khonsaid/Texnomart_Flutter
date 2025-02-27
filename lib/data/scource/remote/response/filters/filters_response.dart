import 'package:freezed_annotation/freezed_annotation.dart';

part 'filters_response.freezed.dart';
part 'filters_response.g.dart';

@freezed
class FiltersResponse with _$FiltersResponse {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory FiltersResponse(
    List<BrandsFiltersData>? brands,
    List<FilterData>? filter,
    PaginationFilterData? pagination,
    PriceFilterData? price,
    List<ProductsFilterData>? products,
    List<dynamic>? saleMonths,
    List<StickersData>? stickers,
    int? total,
  ) = _FiltersResponse;

  factory FiltersResponse.fromJson(Map<String, dynamic> json) => _$FiltersResponseFromJson(json);
}

@freezed
class BrandsFiltersData with _$BrandsFiltersData {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory BrandsFiltersData(
    int? count,
    int? id,
    String? name,
  ) = _BrandsFiltersData;

  factory BrandsFiltersData.fromJson(Map<String, dynamic> json) => _$BrandsFiltersDataFromJson(json);
}

@freezed
class FilterData with _$FilterData {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory FilterData(
    int? count,
    int? id,
    String? name,
    List<ValuesFilterData>? values,
  ) = _FilterData;

  factory FilterData.fromJson(Map<String, dynamic> json) => _$FilterDataFromJson(json);
}

@freezed
class ValuesFilterData with _$ValuesFilterData {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory ValuesFilterData(
    int? count,
    int? id,
    String? value,
  ) = _ValuesFilterData;

  factory ValuesFilterData.fromJson(Map<String, dynamic> json) => _$ValuesFilterDataFromJson(json);
}

@freezed
class PaginationFilterData with _$PaginationFilterData {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory PaginationFilterData(
    int? currentPage,
    int? pageSize,
    int? totalCount,
    int? totalPage,
  ) = _PaginationFilterData;

  factory PaginationFilterData.fromJson(Map<String, dynamic> json) => _$PaginationFilterDataFromJson(json);
}

@freezed
class PriceFilterData with _$PriceFilterData {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory PriceFilterData(int? maxPrice, int? minPrice) = _PriceFilterData;

  factory PriceFilterData.fromJson(Map<String, dynamic> json) => _$PriceFilterDataFromJson(json);
}

@freezed
class ProductsFilterData with _$ProductsFilterData {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory ProductsFilterData(
    int? allCount,
    String? availability,
    String? axiomMonthlyPrice,
    int? benefit,
    String? code,
    int? discount,
    int? id,
    String? image,
    int? isCanLoanOrder,
    List<MainCharactersFilterData>? mainCharacters,
    String? name,
    int? oldPrice,
    int? reviewsAverage,
    int? reviewsCount,
    List<dynamic>? saleMonths,
    int? salePrice,
    List<StickersData>? stickers,
  ) = _ProductsFilterData;

  factory ProductsFilterData.fromJson(Map<String, dynamic> json) => _$ProductsFilterDataFromJson(json);
}

@freezed
class MainCharactersFilterData with _$MainCharactersFilterData {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory MainCharactersFilterData(String? name, int? order, String? value) = _MainCharactersFilterData;

  factory MainCharactersFilterData.fromJson(Map<String, dynamic> json) =>
      _$MainCharactersFilterDataFromJson(json);
}

@freezed
class StickersData with _$StickersData {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory StickersData(
    String? backgroundColor,
    String? image,
    bool? isImage,
    String? name,
    bool? showInCard,
    String? textColor,
  ) = _StickersData;

  factory StickersData.fromJson(Map<String, dynamic> json) => _$StickersDataFromJson(json);
}
