import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/export.dart';
import '../../../../core/utils/failures.dart';

part 'order_state.freezed.dart';

@freezed
class OrderState with _$OrderState {
  const factory OrderState.initial() = OrderInitial;
  const factory OrderState.loading() = OrderLoading;
  const factory OrderState.loaded({
    required List<Order> orders,
    required bool hasMore,
    required int currentPage,
  }) = OrderLoaded;
  const factory OrderState.checkoutSuccess(List<Order> orders) = OrderCheckoutSuccess;
  const factory OrderState.deliverSuccess(Order order) = OrderDeliverSuccess;
  const factory OrderState.failure(NetworkFailure failure) = OrderFailure;
}
