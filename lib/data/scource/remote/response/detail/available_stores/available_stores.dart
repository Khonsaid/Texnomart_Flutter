import 'package:freezed_annotation/freezed_annotation.dart';

part 'available_stores.freezed.dart';
part 'available_stores.g.dart';

@freezed
class AddressResponse with _$AddressResponse {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory AddressResponse(
    List<AddressData>? data,
  ) = _AddressResponse;

  factory AddressResponse.fromJson(Map<String, dynamic> json) => _$AddressResponseFromJson(json);
}

@freezed
class AddressData with _$AddressData {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory AddressData(
    String? address,
    String? description,
    int? id,
    String? lat,
    String? long,
    String? name,
    String? phone,
    String? workTime,
  ) = _AddressData;

  factory AddressData.fromJson(Map<String, dynamic> json) => _$AddressDataFromJson(json);
}
