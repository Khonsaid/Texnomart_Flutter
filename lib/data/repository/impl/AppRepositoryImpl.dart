import 'package:dio/dio.dart';

import '../../../di/di.dart';
import '../../scource/remote/api/detail_api.dart';
import '../../scource/remote/api/special_categories_api.dart';
import '../../scource/remote/response/base_response.dart';
import '../../scource/remote/response/category/chip/chips_response.dart';
import '../../scource/remote/response/detail/available_stores/available_stores.dart';
import '../../scource/remote/response/detail/characters/characters_response.dart';
import '../../scource/remote/response/detail/description/description_response.dart';
import '../../scource/remote/response/detail/detail/detail_response.dart';
import '../../scource/remote/response/detail/info_partners/info_partners.dart';
import '../../scource/remote/response/filters/filters_response.dart';
import '../../scource/remote/response/home/brends/brends_response.dart';
import '../../scource/remote/response/home/popup_menu/popup_menu_response.dart';
import '../../scource/remote/response/home/product/product_response.dart';
import '../../scource/remote/response/home/special_categories/special_categories_response.dart';
import '../AppRepository.dart';

class AppRepositoryImpl extends AppRepository {
  final specialCategoriesApi = getIt<SpecialCategoriesApi>();
  final detailApi = getIt<DetailApi>();

  @override
  Future<SpecialCategoriesResponse> getSpecialCategories() async {
    try {
      final response = await specialCategoriesApi.getSpecialCategories();
      return response;
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<ProductResponse> getHitProducts() async {
    try {
      final response = await specialCategoriesApi.getHitProducts();
      return response;
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<ProductResponse> getNewProducts() async {
    try {
      final response = await specialCategoriesApi.getNewProducts();
      return response;
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<BrendsResponse> getBrends() async {
    try {
      final response = await specialCategoriesApi.getBrends();
      return response;
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<List<String>> getSlider() async {
    var sliderList = [
      'https://mini-io-api.texnomart.uz/newcontent/slider/351/iG2e44fCia9jOMPPnCF6D42KLuQBI2BYyLW8Cfg6.webp',
      'https://mini-io-api.texnomart.uz/newcontent/slider/357/igGnvHGRkNb3cfEXhVTyojR5QVQvbcwCgYH28Cbi.webp',
      'https://mini-io-api.texnomart.uz/newcontent/slider/353/kZvydVfiukzNkQfHOeBvO0IJhwI7mh5aEaPge7X1.webp',
      'https://mini-io-api.texnomart.uz/newcontent/slider/350/XGWa4gRft6IR0w4rGwf8nAN8sNPrlBjtZOmCtfUs.webp',
      'https://mini-io-api.texnomart.uz/newcontent/slider/352/LEpBdIINC65QfzSpW2W3XIzDwN9VeUOQkaCBCoS1.webp',
      'https://mini-io-api.texnomart.uz/newcontent/slider/355/au6lWkuSiyHPGSWRXqysf9OCsFzWWbsFTrkwGqgW.webp',
      'https://mini-io-api.texnomart.uz/newcontent/slider/354/YqNyWLs61Wwn3lFEdJuo8VoQJfHGThp1jt0qeFB1.webp',
      'https://mini-io-api.texnomart.uz/newcontent/slider/356/WXGPApox9Sng8X0dGO87N43tLexLBXSs6IugP06O.webp',
      'https://mini-io-api.texnomart.uz/newcontent/slider/347/1VXjIZRQ8SP7gWq64Z3WDcAuGso0QKrTaaqFZ4oi.webp',
    ];
    return Future.value(sliderList);
  }

  @override
  Future<BaseResponse<CharactersResponse>> getCharacters(String id) async {
    try {
      var response = await detailApi.getCharacters(id: id);
      print("TTT repository ${response.data.toString()}");
      return response;
    } catch (e) {
      print('TTT exaption $e');
      rethrow;
    }
  }

  @override
  Future<BaseResponse<DetailResponse>> getDetail(String id) async {
    try {
      var response = await detailApi.getDetail(id: id);
      return response;
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<AddressResponse>> getAddress(String id) async {
    try {
      final response = await detailApi.getAvailableStores(id: id);
      return response;
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<InfoPlatformResponse>> getInfoPartners() async {
    try {
      final response = await detailApi.getPartnersInfo();
      return response;
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<DescriptionResponse>> getDescription(String id) async {
    try {
      final response = await detailApi.getDescription(id: id);
      return response;
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<PopupMenuResponse>> getPopupMenuCatalog() async {
    try {
      final response = await specialCategoriesApi.getPopupMenuCatalog();
      return response;
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<ChipsResponse>> getChips(String slug) async {
    try {
      final response = await specialCategoriesApi.getChips(slug: slug);
      return response;
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<BaseResponse<FiltersResponse>> getCatalogByFilter(String slug, String? sort, int? page) async {
    try {
      print('TTT getCatalogByFilter slug= $slug  sort = $sort  page = $page');
      final response =
          await specialCategoriesApi.getFilters(slug: slug, sort: sort ?? '-order_count', page: page ?? 1);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
