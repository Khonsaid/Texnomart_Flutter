import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../response/base_response.dart';
import '../response/detail/available_stores/available_stores.dart';
import '../response/detail/characters/characters_response.dart';
import '../response/detail/description/description_response.dart';
import '../response/detail/detail/detail_response.dart';
import '../response/detail/info_partners/info_partners.dart';

part 'detail_api.g.dart';

@RestApi()
abstract class DetailApi {
  factory DetailApi(Dio dio, {String? baseUrl}) = _DetailApi;

  @GET('web/v1/product/characters')
  Future<BaseResponse<CharactersResponse>> getCharacters({@Query('id') required String id});

  @GET('web/v1/product/available-stores')
  Future<BaseResponse<AddressResponse>> getAvailableStores({@Query('id') required String id});

  @GET('web/v1/partners/info')
  Future<BaseResponse<InfoPlatformResponse>> getPartnersInfo({@Query('platform') String platform = 'web'});

  @GET('web/v1/product/description')
  Future<BaseResponse<DescriptionResponse>> getDescription({@Query('id') required String id});

  @GET('web/v1/product/accessories')
  Future<BaseResponse<AddressResponse>> getAccessories({@Query('id') required String id});

  @GET('web/v1/product/detail')
  Future<BaseResponse<DetailResponse>> getDetail({@Query('id') required String id});
}

//Mahsulot xususiyatlari
//  https://gw.texnomart.uz/api/web/v1/product/characters?id=355805

//detail
//https://gw.texnomart.uz/api/web/v1/product/detail?id=355805

//Muddatli to'lov rasmiylashtirayotganingizda
//https://gw.texnomart.uz/api/common/v1/partners/info?platform=web

//Do'konlarda mavjudligi
// https://gw.texnomart.uz/api/web/v1/product/available-stores?id=355805

//Tavsif
// https://gw.texnomart.uz/api/web/v1/product/description?id=355805

//Aksessuarlar
//https://gw.texnomart.uz/api/web/v1/product/accessories?id=355805
