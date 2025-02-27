import 'package:freezed_annotation/freezed_annotation.dart';

part 'info_partners.freezed.dart';
part 'info_partners.g.dart';

@freezed
class InfoPlatformResponse with _$InfoPlatformResponse {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory InfoPlatformResponse(List<InfoPartnersData>? data) = _InfoPlatformResponse;

  factory InfoPlatformResponse.fromJson(Map<String, dynamic> json) => _$InfoPlatformResponseFromJson(json);
}

@freezed
class InfoPartnersData with _$InfoPartnersData {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory InfoPartnersData(
    String? description,
    bool? isOnlyStore,
    String? logo,
    String? name,
    String? type,
  ) = _InfoPartnersData;

  factory InfoPartnersData.fromJson(Map<String, dynamic> json) => _$InfoPartnersDataFromJson(json);
}
