import 'package:bloc/bloc.dart';
import '../../../../di/di.dart';
import '../../../data/repository/AppRepository.dart';
import '../../../data/scource/remote/response/base_response.dart';
import '../../../data/scource/remote/response/category/chip/chips_response.dart';
import '../../../data/scource/remote/response/filters/filters_response.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc() : super(CatalogState()) {
    final productRepository = getIt<AppRepository>();

    on<LoadCatalogEvent>((event, emit) async {
      ChipsResponse? chipsResponse;
      FiltersResponse? filtersResponse;

      try {
        emit(state.copyWith(status: Status.loading));
        final List<dynamic> result = await Future.wait<dynamic>([
          productRepository.getChips(event.slug).catchError((e) {
            print("TTT Chips API error: $e");
            return null; // Xatolik bo'lsa, null qaytaramiz
          }),
          productRepository.getCatalogByFilter(event.slug, '-order_count', 1).catchError((e) {
            print("TTT Filters API error: $e");
            return null;
          }),
        ]);

        if (result[0] != null) {
          chipsResponse = (result[0] as BaseResponse<ChipsResponse>).data;
        }
        if (result[1] != null) {
          filtersResponse = (result[1] as BaseResponse<FiltersResponse>).data;
        }

        emit(state.copyWith(
          status: Status.success,
          chipsResponse: chipsResponse,
          filtersResponse: filtersResponse,
          products: filtersResponse?.products ?? [],
          currentPage: 1,
          title: chipsResponse?.parent?.name,
          totalPages: filtersResponse?.pagination?.totalPage ?? 1,
        ));
      } catch (e) {
        emit(state.copyWith(status: Status.error));
      }
    });
  }
}
