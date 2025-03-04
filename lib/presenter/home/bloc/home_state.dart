part of 'home_bloc.dart';

class HomeState {
  final bool isLoading;
  final String? error;
  final List<String>? sliderList;
  final SpecialCategoriesResponse? specialCategories;
  final ProductResponse? hitProductsResponse;
  final ProductResponse? newProductsResponse;
  final BrendsResponse? brendsResponse;

  HomeState({
    this.brendsResponse,
    this.isLoading = false,
    this.error,
    this.sliderList,
    this.specialCategories,
    this.hitProductsResponse,
    this.newProductsResponse,
  });

  HomeState copyWith({
    BrendsResponse? brendsResponse,
    bool? isLoading,
    String? error,
    List<String>? sliderList,
    SpecialCategoriesResponse? specialCategories,
    ProductResponse? hitProductsResponse,
    ProductResponse? newProductsResponse,
  }) =>
      HomeState(
        brendsResponse: brendsResponse ?? this.brendsResponse,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        hitProductsResponse: hitProductsResponse ?? this.hitProductsResponse,
        newProductsResponse: newProductsResponse ?? this.newProductsResponse,
        specialCategories: specialCategories ?? this.specialCategories,
        sliderList: sliderList ?? this.sliderList,
      );
}
