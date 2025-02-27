import 'package:freezed_annotation/freezed_annotation.dart';

part 'special_categories_response.freezed.dart';
part 'special_categories_response.g.dart';

@freezed
class SpecialCategoriesResponse with _$SpecialCategoriesResponse {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory SpecialCategoriesResponse(
    int? code,
    SpecialCategoriesData? data,
    String? message,
    int? status,
    bool? success,
  ) = _SpecialCategoriesResponse;

  factory SpecialCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$SpecialCategoriesResponseFromJson(json);
}

@freezed
class SpecialCategoriesData with _$SpecialCategoriesData {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory SpecialCategoriesData(List<SpecialCategoryDataElement>? data) = _SpecialCategoriesData;

  factory SpecialCategoriesData.fromJson(Map<String, dynamic> json) => _$SpecialCategoriesDataFromJson(json);
}

@freezed
class SpecialCategoryDataElement with _$SpecialCategoryDataElement {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory SpecialCategoryDataElement(
    String? image,
    String? slug,
    String? title,
  ) = _SpecialCategoryDataElement;

  factory SpecialCategoryDataElement.fromJson(Map<String, dynamic> json) =>
      _$SpecialCategoryDataElementFromJson(json);
}
