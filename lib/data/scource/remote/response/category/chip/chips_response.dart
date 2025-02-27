import 'package:freezed_annotation/freezed_annotation.dart';

part 'chips_response.freezed.dart';
part 'chips_response.g.dart';

@freezed
class ChipsResponse with _$ChipsResponse {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory ChipsResponse(
    List<CategoriesData>? categories,
    bool? hasChild,
    bool? hasChildImage,
    CategoriesData? parent,
  ) = _ChipsResponse;

  factory ChipsResponse.fromJson(Map<String, dynamic> json) => _$ChipsResponseFromJson(json);
}

@freezed
class CategoriesData with _$CategoriesData {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory CategoriesData(
    bool? hasChild,
    int? id,
    String? image,
    String? name,
    String? slug,
  ) = _CategoriesData;

  factory CategoriesData.fromJson(Map<String, dynamic> json) => _$CategoriesDataFromJson(json);
}
