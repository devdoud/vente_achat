import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/i_favorite_repository.dart';
import 'favorite_state.dart';

@injectable
class FavoriteCubit extends Cubit<FavoriteState> {
  final IFavoriteRepository _repo;
  FavoriteCubit(this._repo) : super(const FavoriteState.initial());

  Future<void> load() async {
    emit(const FavoriteState.loading());
    final result = await _repo.getFavorites();
    result.fold(
      (f) => emit(FavoriteState.failure(f)),
      (products) => emit(FavoriteState.loaded(products)),
    );
  }

  Future<void> toggle(String productUuid, {required bool isFavorite}) async {
    final result = isFavorite
        ? await _repo.removeFavorite(productUuid)
        : await _repo.addFavorite(productUuid);
    result.fold(
      (f) => emit(FavoriteState.failure(f)),
      (_) => load(),
    );
  }
}
