import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/i_product_repository.dart';
import 'product_state.dart';

@injectable
class ProductCubit extends Cubit<ProductState> {
  final IProductRepository _repo;
  ProductCubit(this._repo) : super(const ProductState.initial());

  Future<void> loadProducts({
    String? query,
    String? categoryUuid,
    int? minPrice,
    int? maxPrice,
  }) async {
    emit(const ProductState.loading());
    final result = await _repo.getProducts(
      query: query,
      categoryUuid: categoryUuid,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
    result.fold(
      (f) => emit(ProductState.failure(f)),
      (page) => emit(ProductState.loaded(
        products: page.items,
        currentPage: page.currentPageNumber,
        hasMore: page.hasNextPage,
      )),
    );
  }

  Future<void> loadMore({
    String? query,
    String? categoryUuid,
    int? minPrice,
    int? maxPrice,
  }) async {
    final current = state;
    if (current is! ProductLoaded || !current.hasMore) return;

    final result = await _repo.getProducts(
      page: current.currentPage + 1,
      query: query,
      categoryUuid: categoryUuid,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
    result.fold(
      (f) => emit(ProductState.failure(f)),
      (page) => emit(ProductState.loaded(
        products: [...current.products, ...page.items],
        currentPage: page.currentPageNumber,
        hasMore: page.hasNextPage,
      )),
    );
  }

  /// Charge tous les produits du vendeur authentifié (dashboard boutique).
  Future<void> loadVendorProducts() async {
    emit(const ProductState.loading());
    final result = await _repo.getVendorProducts();
    result.fold(
      (f) => emit(ProductState.failure(f)),
      (page) => emit(ProductState.loaded(
        products: page.items,
        currentPage: page.currentPageNumber,
        hasMore: page.hasNextPage,
      )),
    );
  }

  /// Charge les produits d'une boutique spécifique (dashboard vendeur).
  Future<void> loadShopProducts(String shopUuid) async {
    emit(const ProductState.loading());
    final result = await _repo.getShopProducts(shopUuid);
    result.fold(
      (f) => emit(ProductState.failure(f)),
      (page) => emit(ProductState.loaded(
        products: page.items,
        currentPage: page.currentPageNumber,
        hasMore: page.hasNextPage,
      )),
    );
  }

  Future<void> getProduct(String uuid) async {
    emit(const ProductState.loading());
    final result = await _repo.getProduct(uuid);
    result.fold(
      (f) => emit(ProductState.failure(f)),
      (p) => emit(ProductState.detail(p)),
    );
  }

  Future<void> deleteProduct(String uuid) async {
    final result = await _repo.deleteProduct(uuid);
    result.fold(
      (f) => emit(ProductState.failure(f)),
      (_) async {
        // Recharger les produits du vendeur après suppression
        await loadVendorProducts();
      },
    );
  }
}
