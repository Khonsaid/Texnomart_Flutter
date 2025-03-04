import 'package:bloc/bloc.dart';
import 'package:texnomart/di/di.dart';

import '../../../data/repository/AppRepository.dart';
import '../../../data/scource/remote/response/home/popup_menu/popup_menu_response.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryState()) {
    final productRepository = getIt<AppRepository>();

    on<LoadCategoryEvent>((event, emit) async {
      final response = await productRepository.getPopupMenuCatalog();
      final popupMenuData = response.data as PopupMenuResponse;
      print('TTT categry ${popupMenuData}');
      emit(state.withCopy(popupMenuData: popupMenuData.data));
    });
  }
}
