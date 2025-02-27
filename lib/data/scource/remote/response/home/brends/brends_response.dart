import 'package:freezed_annotation/freezed_annotation.dart';

part 'brends_response.freezed.dart';
part 'brends_response.g.dart';

@freezed
class BrendsResponse with _$BrendsResponse {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory BrendsResponse(
    int? code,
    BrendsData? data,
    String? message,
    int? status,
    bool? success,
  ) = _BrendsResponse;

  factory BrendsResponse.fromJson(Map<String, dynamic> json) => _$BrendsResponseFromJson(json);
}

@freezed
class BrendsData with _$BrendsData {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory BrendsData(List<BrendsDataElement>? data) = _BrendsData;

  factory BrendsData.fromJson(Map<String, dynamic> json) => _$BrendsDataFromJson(json);
}

@freezed
class BrendsDataElement with _$BrendsDataElement {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory BrendsDataElement(
    String? image,
    String? imageAlt,
    MetaBrends? meta,
    String? name,
    String? slug,
  ) = _BrendsDataElement;

  factory BrendsDataElement.fromJson(Map<String, dynamic> json) => _$BrendsDataElementFromJson(json);
}

@freezed
class MetaBrends with _$MetaBrends {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory MetaBrends(
    String? description,
    String? keywords,
    String? title,
  ) = _MetaBrends;

  factory MetaBrends.fromJson(Map<String, dynamic> json) => _$MetaBrendsFromJson(json);
}
