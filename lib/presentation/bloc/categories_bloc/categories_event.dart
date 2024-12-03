part of 'categories_bloc.dart';

@immutable
abstract class CategoriesEvent {}

class GetCategoriesEvent extends CategoriesEvent {
  GetCategoriesEvent();

  @override
  List<Object?> get props => [];
}

class SelectCategoryEvent extends CategoriesEvent {
  final String id;
  final String category;

  SelectCategoryEvent(this.id, this.category);
}
