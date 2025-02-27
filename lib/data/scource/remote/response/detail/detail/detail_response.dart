import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_response.freezed.dart';
part 'detail_response.g.dart';

@freezed
class DetailResponse with _$DetailResponse {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory DetailResponse(DetailData? data) = _DetailResponse;

  factory DetailResponse.fromJson(Map<String, dynamic> json) => _$DetailResponseFromJson(json);
}

@freezed
class DetailData with _$DetailData {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory DetailData(
    String? availability,
    int? benefit,
    String? brand,
    List<BreadcrumbsData>? breadcrumbs,
    String? code,
    String? guarantee,
    int? id,
    int? installmentPrice,
    int? isCanLoanOrder,
    List<String>? largeImages,
    int? loanPrice,
    List<MainCharactersDetail>? mainCharacters,
    MinimalLoanPriceData? minimalLoanPrice,
    String? model,
    String? name,
    List<OffersByCharacter>? offersByCharacter,
    List<OffersByImage>? offersByImage,
    int? oldPrice,
    int? promotion0012Price,
    int? reviewsCount,
    double? reviewsMiddleRating,
    List<int>? saleMonths,
    int? salePrice,
    List<String>? smallImages,
    List<StickerDetail>? stickers,
  ) = _DetailData;

  factory DetailData.fromJson(Map<String, dynamic> json) => _$DetailDataFromJson(json);
}

@freezed
class MainCharactersDetail with _$MainCharactersDetail {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory MainCharactersDetail(String? name, String? value) = _MainCharactersDetail;

  factory MainCharactersDetail.fromJson(Map<String, dynamic> json) => _$MainCharactersDetailFromJson(json);
}

@freezed
class StickerDetail with _$StickerDetail {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory StickerDetail(
    String? backgroundColor,
    String? image,
    bool? isImage,
    String? name,
    bool? showInCard,
    String? textColor,
  ) = _StickerDetail;

  factory StickerDetail.fromJson(Map<String, dynamic> json) => _$StickerDetailFromJson(json);
}

@freezed
class OffersByCharacter with _$OffersByCharacter {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory OffersByCharacter(
    int? characterId,
    String? name,
    List<Offers>? offers,
  ) = _OffersByCharacter;

  factory OffersByCharacter.fromJson(Map<String, dynamic> json) => _$OffersByCharacterFromJson(json);
}

@freezed
class Offers with _$Offers {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory Offers(
      int? offerId,
      String? text,
      ) = _Offers;

  factory Offers.fromJson(Map<String, dynamic> json) => _$OffersFromJson(json);
}

@freezed
class OffersByImage with _$OffersByImage {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory OffersByImage(
    int? id,
    String? image,
    String? name,
  ) = _OffersByImage;

  factory OffersByImage.fromJson(Map<String, dynamic> json) => _$OffersByImageFromJson(json);
}

@freezed
class BreadcrumbsData with _$BreadcrumbsData {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory BreadcrumbsData(String? name, String? slug) = _BreadcrumbsData;

  factory BreadcrumbsData.fromJson(Map<String, dynamic> json) => _$BreadcrumbsDataFromJson(json);
}

@freezed
class MainCharactersData with _$MainCharactersData {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory MainCharactersData(String? name, String? value) = _MainCharactersData;

  factory MainCharactersData.fromJson(Map<String, dynamic> json) => _$MainCharactersDataFromJson(json);
}

@freezed
class MinimalLoanPriceData with _$MinimalLoanPriceData {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  factory MinimalLoanPriceData.fromJson(Map<String, dynamic> json) => _$MinimalLoanPriceDataFromJson(json);

  const factory MinimalLoanPriceData(
    String? description,
    String? minLoanType,
    String? minMonthlyPrice,
    int? monthNumber,
  ) = _MinimalLoanPriceData;
}
