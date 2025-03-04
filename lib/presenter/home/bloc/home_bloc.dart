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
    late ProductResponse hitProductsResponse;
    late ProductResponse newProductsResponse;

    on<LoadDataEvent>((event, emit) async {
      try {
        final List<dynamic> result = await Future.wait<dynamic>([
          productRepository.getSpecialCategories(),
          productRepository.getHitProducts(),
          productRepository.getNewProducts(),
          productRepository.getBrends()
        ]);
        final resultSlider = await productRepository.getSlider();

        hitProductsResponse = await favouriteMapper(result[1] as ProductResponse);
        newProductsResponse = await favouriteMapper(result[2] as ProductResponse);

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
        // Toggle favorite status - bu qismni ochish kerak
        await localRepository.toggleFavourite(event.product);

        // Update both responses
        hitProductsResponse = await favouriteMapper(hitProductsResponse);
        newProductsResponse = await favouriteMapper(newProductsResponse);

        // Emit new state based on type
        switch (event.type) {
          case 'xit':
            emit(state.copyWith(
              hitProductsResponse: hitProductsResponse,
              newProductsResponse: newProductsResponse,
            ));
            break;
          case 'new':
            emit(state.copyWith(
              hitProductsResponse: hitProductsResponse,
              newProductsResponse: newProductsResponse,
            ));
            break;
        }
      } catch (e) {
        print("TTT favorite error: ${e.toString()}");
      }
    });
  }

  Future<ProductResponse> favouriteMapper(ProductResponse productResponse) async {
    final products = productResponse.data?.data ?? [];

    final updatedProducts = await Future.wait(products.map((product) async {
      final result = await localRepository.hasFavourite(product.id ?? 0);
      return product.copyWith(isLiked: result);
    }));

    final updatedProductsData = productResponse.data?.copyWith(data: updatedProducts);
    return productResponse.copyWith(data: updatedProductsData);
  }
}
