import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/i_category_repository.dart';
import 'category_state.dart';

@injectable
class CategoryCubit extends Cubit<CategoryState> {
  final ICategoryRepository _repo;

  CategoryCubit(this._repo) : super(const CategoryState.initial());

  Future<void> load() async {
    emit(const CategoryState.loading());
    final result = await _repo.getCategories();
    result.fold(
      (f) => emit(CategoryState.failure(f)),
      (cats) => emit(CategoryState.loaded(cats)),
    );
  }

  Future<void> loadFeatures(String categoryUuid) async {
    emit(CategoryState.featuresLoading(categoryUuid));
    final result = await _repo.getCategoryFeatures(categoryUuid);
    result.fold(
      (f) {
        // En cas d'erreur, on remet l'état loaded avec les catégories en cache
        // pour ne pas casser l'affichage
        emit(CategoryState.featuresLoaded(
            categoryUuid: categoryUuid, features: []));
      },
      (features) => emit(CategoryState.featuresLoaded(
          categoryUuid: categoryUuid, features: features)),
    );
  }
}
