part of 'catalog_bloc.dart';

class CatalogState {
  final String? title;
  final String? slug;
  final Status? status;
  final ChipsResponse? chipsResponse;
  final FiltersResponse? filtersResponse;
  final int currentPage;
  final int totalPages;
  final int selectedIndex;
  final bool sortByPopular;
  final List<ProductsFilterData> products;
  final bool isLoadingMore;

  CatalogState({
    this.sortByPopular = true,
    this.selectedIndex = -1,
    this.chipsResponse,
    this.title,
    this.slug,
    this.filtersResponse,
    this.currentPage = 1,
    this.totalPages = 1,
    this.products = const [],
    this.status = Status.loading,
    this.isLoadingMore = false,
  });

  CatalogState copyWith({
    bool? sortByPopular,
    int? selectedIndex,
    Status? status,
    String? slug,
    String? title,
    ChipsResponse? chipsResponse,
    FiltersResponse? filtersResponse,
    int? currentPage,
    int? totalPages,
    List<ProductsFilterData>? products,
    bool? isLoadingMore,
  }) =>
      CatalogState(
        sortByPopular: sortByPopular ?? this.sortByPopular,
        selectedIndex: selectedIndex ?? this.selectedIndex,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        status: status ?? this.status,
        chipsResponse: chipsResponse ?? this.chipsResponse,
        filtersResponse: filtersResponse ?? this.filtersResponse,
        currentPage: currentPage ?? this.currentPage,
        totalPages: totalPages ?? this.totalPages,
        products: products ?? this.products,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      );
}

enum Status { loading, success, error }
