part of 'catalog_bloc.dart';

class CatalogState {
  final String? title;
  final Status? status;
  final ChipsResponse? chipsResponse;
  final FiltersResponse? filtersResponse;
  final int currentPage;
  final int totalPages;
  final List<ProductsFilterData> products;
  final bool isLoadingMore;

  CatalogState({
    this.chipsResponse,
    this.title,
    this.filtersResponse,
    this.currentPage = 1,
    this.totalPages = 1,
    this.products = const [],
    this.status = Status.loading,
    this.isLoadingMore = false,
  });

  CatalogState copyWith({
    Status? status,
    String? title,
    ChipsResponse? chipsResponse,
    FiltersResponse? filtersResponse,
    int? currentPage,
    int? totalPages,
    List<ProductsFilterData>? products,
    bool? isLoadingMore,
  }) =>
      CatalogState(
        title: title ?? this.title,
        status: status ?? this.status,
        chipsResponse: chipsResponse ?? this.chipsResponse,
        filtersResponse: filtersResponse ?? this.filtersResponse,
        currentPage: currentPage ?? this.currentPage,
        totalPages: totalPages ?? this.totalPages,
        products: products ?? this.products,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,);
}

enum Status { loading, success, error }
