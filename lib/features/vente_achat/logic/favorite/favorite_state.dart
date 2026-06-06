import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/export.dart';
import '../../../../core/utils/failures.dart';

part 'favorite_state.freezed.dart';

@freezed
class FavoriteState with _$FavoriteState {
  const factory FavoriteState.initial() = FavoriteInitial;
  const factory FavoriteState.loading() = FavoriteLoading;
  const factory FavoriteState.loaded(List<Product> products) = FavoriteLoaded;
  const factory FavoriteState.failure(NetworkFailure failure) = FavoriteFailure;
}
