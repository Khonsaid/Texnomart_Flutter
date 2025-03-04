part of 'category_bloc.dart';

abstract class CategoryEvent {}

class LoadCategoryEvent extends CategoryEvent {}

class ClickCategoryEvent extends CategoryEvent{
  String slug;

  ClickCategoryEvent(this.slug);
}
