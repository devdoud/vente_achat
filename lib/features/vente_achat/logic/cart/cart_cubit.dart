import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/models/export.dart';
import '../../domain/repositories/i_cart_repository.dart';
import 'cart_state.dart';

@Singleton()
class CartCubit extends Cubit<CartState> {
  final ICartRepository _repo;
  CartCubit(this._repo) : super(const CartState.initial());

  Future<void> load() async {
    emit(const CartState.loading());
    final result = await _repo.getCart();
    result.fold(
      (f) => emit(CartState.failure(f)),
      (cart) => emit(CartState.loaded(cart)),
    );
  }

  Future<void> addItem({required String productUuid, int quantity = 1}) async {
    final result = await _repo.addItem(productUuid: productUuid, quantity: quantity);
    result.fold(
      (f) => emit(CartState.failure(f)),
      (cart) => emit(CartState.loaded(cart)),
    );
  }

  Future<void> updateItem({required String itemUuid, required int quantity}) async {
    final result = await _repo.updateItem(itemUuid: itemUuid, quantity: quantity);
    result.fold(
      (f) => emit(CartState.failure(f)),
      (cart) => emit(CartState.loaded(cart)),
    );
  }

  Future<void> removeItem(String itemUuid) async {
    final result = await _repo.removeItem(itemUuid);
    result.fold(
      (f) => emit(CartState.failure(f)),
      (cart) => emit(CartState.loaded(cart)),
    );
  }

  Future<void> clear() async {
    final result = await _repo.clearCart();
    result.fold(
      (f) => emit(CartState.failure(f)),
      (_) => emit(CartState.loaded(Cart(uuid: '', items: const [], itemCount: 0, total: 0))),
    );
  }
}
