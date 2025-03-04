part of 'category_bloc.dart';

class CategoryState {
  final List<PopupMenuData>? popupMenuData;

  CategoryState({this.popupMenuData});

  CategoryState withCopy({List<PopupMenuData>? popupMenuData}) => CategoryState(
        popupMenuData: popupMenuData ?? this.popupMenuData,
      );
}
