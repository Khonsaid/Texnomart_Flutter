import 'package:bloc/bloc.dart';
import 'package:texnomart/data/model/favaurite_model.dart';
import 'package:texnomart/data/repository/AppRepository.dart';

import '../../../../di/di.dart';
import '../../../data/scource/remote/response/home/brends/brends_response.dart';
import '../../../data/scource/remote/response/home/product/product_response.dart';
import '../../../data/scource/remote/response/home/special_categories/special_categories_response.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final localRepository = getIt<AppRepository>();
  final productRepository = getIt<AppRepository>();

  HomeBloc() : super(HomeState()) {
    on<LoadDataEvent>((event, emit) async {
      try {
        final List<dynamic> result = await Future.wait<dynamic>([
          productRepository.getSpecialCategories(),
          productRepository.getHitProducts(),
          productRepository.getNewProducts(),
          productRepository.getBrends()
        ]);
        final resultSlider = await productRepository.getSlider();

        final hitProductsResponse = await favouriteMapper(result[1] as ProductResponse);
        final newProductsResponse = await favouriteMapper(result[2] as ProductResponse);

        emit(state.copyWith(
            sliderList: resultSlider,
            specialCategories: result[0] as SpecialCategoriesResponse,
            hitProductsResponse: hitProductsResponse,
            newProductsResponse: newProductsResponse,
            brendsResponse: result[3] as BrendsResponse));
      } catch (e) {
        print("TTT error ${e.toString()}");
      }
    });
    on<ClickFavouriteEvent>((event, emit) async {
      try {
        await localRepository.toggleFavourite(event.product);

        final hitProductsResponse = await favouriteMapper(state.hitProductsResponse);
        final newProductsResponse = await favouriteMapper(state.newProductsResponse);

        emit(state.copyWith(
          hitProductsResponse: hitProductsResponse,
          newProductsResponse: newProductsResponse,
        ));
      } catch (e) {
        print("TTT favorite error: ${e.toString()}");
      }
    });
  }

  Future<ProductResponse?> favouriteMapper(ProductResponse? productResponse) async {
    final products = productResponse?.data?.data ?? [];

    final updatedProducts = await Future.wait(products.map((product) async {
      final result = await localRepository.hasFavourite(product.id ?? 0);
      return product.copyWith(isLiked: result);
    }));

    final updatedProductsData = productResponse?.data?.copyWith(data: updatedProducts);
    return productResponse?.copyWith(data: updatedProductsData);
  }
}
