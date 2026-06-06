import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_client.dart';
import '../dto/export.dart';

@lazySingleton
class ProductRemoteSource {
  final ApiClient _client;
  ProductRemoteSource(this._client);

  Future<PageResultDto<ProductDto>> getProducts({
    int page = 1,
    int limit = 20,
    String? query,
    String? categoryUuid,
    String? shopUuid,
    int? minPrice,
    int? maxPrice,
    bool? available,
  }) async {
    final resp = await _client.call().get('/api/marketplace/products', queryParameters: {
      'page': page,
      'limit': limit,
      if (query != null) 'q': query,
      if (categoryUuid != null) 'category': categoryUuid,
      if (shopUuid != null) 'shop': shopUuid,
      if (minPrice != null) 'min_price': minPrice,
      if (maxPrice != null) 'max_price': maxPrice,
      if (available != null) 'available': available,
    });

    if (kDebugMode) {
      final data = resp.data;
      if (data is Map) {
        final items = data['items'] as List?;
        debugPrint('[Products API] status=${resp.statusCode} count=${items?.length ?? 0}');
        if (items != null && items.isNotEmpty) {
          final first = items.first as Map<String, dynamic>?;
          if (first != null) {
            debugPrint('[Products API] first item keys: ${first.keys.toList()}');
            debugPrint('[Products API] banner: ${first['banner']}');
            debugPrint('[Products API] images: ${first['images']}');
          }
        }
      }
    }

    return PageResultDto.fromJson(
      resp.data as Map<String, dynamic>,
      ProductDto.fromJson,
    );
  }

  Future<ProductDto> getProduct(String uuid) async {
    final resp = await _client.call().get('/api/marketplace/products/$uuid');
    return ProductDto.fromJson(resp.data as Map<String, dynamic>);
  }

  /// Tous les produits du vendeur authentifié (dashboard boutique).
  Future<PageResultDto<ProductDto>> getVendorProducts({
    int page = 1, int limit = 50,
  }) async {
    final resp = await _client.call().get(
      '/api/marketplace/vendor/products',
      queryParameters: {'page': page, 'limit': limit},
    );
    return PageResultDto.fromJson(resp.data as Map<String, dynamic>, ProductDto.fromJson);
  }

  /// Produits d'une boutique spécifique pour le dashboard vendeur.
  Future<PageResultDto<ProductDto>> getShopProducts(
    String shopUuid, {
    int page  = 1,
    int limit = 50,
  }) async {
    final resp = await _client.call().get(
      '/api/marketplace/vendor/products/$shopUuid',
      queryParameters: {'page': page, 'limit': limit},
    );
    return PageResultDto.fromJson(
      resp.data as Map<String, dynamic>,
      ProductDto.fromJson,
    );
  }

  /// Supprime un produit
  Future<void> deleteProduct(String uuid) async {
    await _client.call().delete('/api/marketplace/products/$uuid');
  }
}
