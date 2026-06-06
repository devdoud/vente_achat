import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart' hide Order;
import '../../domain/repositories/i_order_repository.dart';
import 'order_state.dart';

@injectable
class OrderCubit extends Cubit<OrderState> {
  final IOrderRepository _repo;
  OrderCubit(this._repo) : super(const OrderState.initial());

  Future<void> loadOrders() async {
    emit(const OrderState.loading());
    final result = await _repo.getOrders();
    result.fold(
      (f) => emit(OrderState.failure(f)),
      (page) => emit(OrderState.loaded(
        orders: page.items,
        currentPage: page.currentPageNumber,
        hasMore: page.hasNextPage,
      )),
    );
  }

  Future<void> checkout({
    String? note,
    Map<String, dynamic>? shippingAddress,
  }) async {
    emit(const OrderState.loading());
    final result = await _repo.checkout(note: note, shippingAddress: shippingAddress);
    result.fold(
      (f) => emit(OrderState.failure(f)),
      (orders) => emit(OrderState.checkoutSuccess(orders)),
    );
  }

  Future<void> buyNow({
    required String productUuid,
    int quantity = 1,
    String? note,
    Map<String, dynamic>? shippingAddress,
  }) async {
    emit(const OrderState.loading());
    final result = await _repo.buyNow(
      productUuid:     productUuid,
      quantity:        quantity,
      note:            note,
      shippingAddress: shippingAddress,
    );
    result.fold(
      (f) => emit(OrderState.failure(f)),
      (order) => emit(OrderState.checkoutSuccess([order])),
    );
  }

  Future<void> deliverOrder({required String orderUuid}) async {
    emit(const OrderState.loading());
    final result = await _repo.deliverOrder(orderUuid: orderUuid);
    result.fold(
      (f) => emit(OrderState.failure(f)),
      (order) => emit(OrderState.deliverSuccess(order)),
    );
  }

  /// Charge les commandes lancées sur la boutique du vendeur
  Future<void> loadVendorOrders() async {
    emit(const OrderState.loading());
    final result = await _repo.getVendorOrders();
    result.fold(
      (f) => emit(OrderState.failure(f)),
      (page) => emit(OrderState.loaded(
        orders: page.items,
        currentPage: page.currentPageNumber,
        hasMore: page.hasNextPage,
      )),
    );
  }
}
