part of 'categories_bloc.dart';

class CategoriesState extends Equatable {
  final List<Category> categories;
  final bool isLoading;
  final String? selectedCategoryId;

  const CategoriesState({
    this.categories = const [],
    this.isLoading = false,
    this.selectedCategoryId = '',
  });

  CategoriesState copyWith(
      {List<Category>? categories,
      bool? isLoading,
      String? selectedCategoryId}) {
    return CategoriesState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
    );
  }

  @override
  List<Object?> get props => [
        categories,
        isLoading,
        selectedCategoryId,
      ];
}
