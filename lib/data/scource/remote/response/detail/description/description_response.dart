import 'package:freezed_annotation/freezed_annotation.dart';

part 'description_response.freezed.dart';
part 'description_response.g.dart';
@freezed
class DescriptionResponse with _$DescriptionResponse {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory DescriptionResponse(String? data) = _DescriptionResponse;

  factory DescriptionResponse.fromJson(Map<String, dynamic> json) => _$DescriptionResponseFromJson(json);
}
