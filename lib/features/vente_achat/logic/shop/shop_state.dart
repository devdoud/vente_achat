import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/failures.dart';

part 'shop_state.freezed.dart';

@freezed
class ShopState with _$ShopState {
  const factory ShopState.initial()                          = ShopInitial;
  const factory ShopState.loading()                         = ShopLoading;
  const factory ShopState.created({required String shopUuid}) = ShopCreated;
  const factory ShopState.updated()                          = ShopUpdated;
  const factory ShopState.failure(NetworkFailure failure)    = ShopFailure;
}
