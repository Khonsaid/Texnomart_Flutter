import 'package:freezed_annotation/freezed_annotation.dart';

part 'characters_response.freezed.dart';
part 'characters_response.g.dart';
@freezed
class CharactersResponse with _$CharactersResponse {
  const factory CharactersResponse(List<CharactersData>? data) = _CharactersResponse;

  factory CharactersResponse.fromJson(Map<String, dynamic> json) => _$CharactersResponseFromJson(json);
}

@freezed
class CharactersData with _$CharactersData {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory CharactersData(
    List<CharactersElement>? characters,
    String? name,
  ) = _CharactersData;

  factory CharactersData.fromJson(Map<String, dynamic> json) => _$CharactersDataFromJson(json);
}

@freezed
class CharactersElement with _$CharactersElement {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory CharactersElement(
    String? name,
    String? value,
  ) = _CharactersElement;

  factory CharactersElement.fromJson(Map<String, dynamic> json) => _$CharactersElementFromJson(json);
}
