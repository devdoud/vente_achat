import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/export.dart';
import '../../../../core/utils/failures.dart';

part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const factory CartState.initial() = CartInitial;
  const factory CartState.loading() = CartLoading;
  const factory CartState.loaded(Cart cart) = CartLoaded;
  const factory CartState.failure(NetworkFailure failure) = CartFailure;
}
