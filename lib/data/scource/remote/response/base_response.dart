import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response.freezed.dart';
part 'base_response.g.dart';

@Freezed(genericArgumentFactories: true)
class BaseResponse<T> with _$BaseResponse {
  const factory BaseResponse(
      int? code,
      T? data,
      String? message,
      int? status,
      bool? success,
      ) = _BaseResponse;


  factory BaseResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) =>
      _$BaseResponseFromJson(json, fromJsonT);

}
