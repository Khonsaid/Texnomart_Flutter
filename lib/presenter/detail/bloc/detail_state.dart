part of 'detail_bloc.dart';

class DetailState {
  final CharactersResponse? charactersResponse;
  final DetailResponse? detailResponse;
  final AddressResponse? addressResponse;
  final InfoPlatformResponse? partnersInfoResponse;
  final DescriptionResponse? descriptionResponse;
  final bool? isLiked;
  final String? title;
  final bool? isLikedChanged;
  final bool? isAdded;

  DetailState(
      {this.descriptionResponse,
      this.isLiked,
      this.title,
      this.isAdded = false,
      this.isLikedChanged = false,
      this.partnersInfoResponse,
      this.addressResponse,
      this.charactersResponse,
      this.detailResponse});

  DetailState copyWith({
    CharactersResponse? charactersResponse,
    bool? isLiked,
    bool? isAdded,
    String? title,
    bool? isLikedChanged,
    DescriptionResponse? descriptionResponse,
    InfoPlatformResponse? partnersInfoResponse,
    AddressResponse? addressResponse,
    DetailResponse? detailResponse,
  }) =>
      DetailState(
        descriptionResponse: descriptionResponse ?? this.descriptionResponse,
        title: title ?? this.title,
        isLiked: isLiked ?? this.isLiked,
        isAdded: isAdded ?? this.isAdded,
        isLikedChanged: isLikedChanged ?? this.isLikedChanged,
        partnersInfoResponse: partnersInfoResponse ?? this.partnersInfoResponse,
        addressResponse: addressResponse ?? this.addressResponse,
        charactersResponse: charactersResponse ?? this.charactersResponse,
        detailResponse: detailResponse ?? this.detailResponse,
      );
}
