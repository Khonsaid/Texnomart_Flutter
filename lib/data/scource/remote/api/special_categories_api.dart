import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../response/base_response.dart';
import '../response/category/chip/chips_response.dart';
import '../response/filters/filters_response.dart';
import '../response/home/brends/brends_response.dart';
import '../response/home/popup_menu/popup_menu_response.dart';
import '../response/home/product/product_response.dart';
import '../response/home/special_categories/special_categories_response.dart';

part 'special_categories_api.g.dart';

@RestApi()
abstract class SpecialCategoriesApi {
  factory SpecialCategoriesApi(Dio dio, {String? baseUrl}) = _SpecialCategoriesApi;

  @GET('web/v1/home/special-categories')
  Future<SpecialCategoriesResponse> getSpecialCategories();

  @GET('web/v1/home/special-products')
  Future<ProductResponse> getHitProducts({@Query('type') String type = 'hit_products'});

  @GET('web/v1/home/special-products')
  Future<ProductResponse> getNewProducts({@Query('type') String type = 'new_products'});

  @GET('web/v1/home/special-brands')
  Future<BrendsResponse> getBrends();

  @GET('web/v1/header/popup-menu-catalog')
  Future<BaseResponse<PopupMenuResponse>> getPopupMenuCatalog();

  @GET('web/v1/category/chips')
  Future<BaseResponse<ChipsResponse>> getChips({@Query('slug') required String slug});

  @GET('common/v1/search/filters')
  Future<BaseResponse<FiltersResponse>> getFilters({
    @Query('category_all') required String slug,
    @Query('sort') required String sort,
    @Query('page') required int page,
  });
}

// https://gw.texnomart.uz/api/common/v1/search/filters?category_all=planshety&sort=-order_count&page=1
