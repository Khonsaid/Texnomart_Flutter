import '../scource/remote/response/base_response.dart';
import '../scource/remote/response/category/chip/chips_response.dart';
import '../scource/remote/response/detail/available_stores/available_stores.dart';
import '../scource/remote/response/detail/characters/characters_response.dart';
import '../scource/remote/response/detail/description/description_response.dart';
import '../scource/remote/response/detail/detail/detail_response.dart';
import '../scource/remote/response/detail/info_partners/info_partners.dart';
import '../scource/remote/response/filters/filters_response.dart';
import '../scource/remote/response/home/brends/brends_response.dart';
import '../scource/remote/response/home/popup_menu/popup_menu_response.dart';
import '../scource/remote/response/home/product/product_response.dart';
import '../scource/remote/response/home/special_categories/special_categories_response.dart';

abstract class AppRepository{
  Future<List<String>> getSlider();

  Future<SpecialCategoriesResponse> getSpecialCategories();

  Future<ProductResponse> getHitProducts();
  Future<ProductResponse> getNewProducts();
  Future<BrendsResponse> getBrends();

  //detail
  Future<BaseResponse<CharactersResponse>> getCharacters(String id);
  Future<BaseResponse<DetailResponse>> getDetail(String id);
  Future<BaseResponse<AddressResponse>> getAddress(String id);
  Future<BaseResponse<InfoPlatformResponse>> getInfoPartners();
  Future<BaseResponse<DescriptionResponse>> getDescription(String id);

  //catalog
  Future<BaseResponse<PopupMenuResponse>> getPopupMenuCatalog();
  Future<BaseResponse<ChipsResponse>> getChips(String slug);
  Future<BaseResponse<FiltersResponse>> getCatalogByFilter(String slug, String sort, int page);
}