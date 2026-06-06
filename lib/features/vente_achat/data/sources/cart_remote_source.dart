import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_client.dart';
import '../dto/export.dart';

@lazySingleton
class CartRemoteSource {
  final ApiClient _client;
  CartRemoteSource(this._client);

  Future<CartDto> getCart() async {
    final resp = await _client.call().get('/api/marketplace/cart');
    if (kDebugMode) {
      final data = resp.data;
      debugPrint('[Cart GET] status=${resp.statusCode} data=$data');
    }
    return CartDto.fromJson(resp.data as Map<String, dynamic>);
  }

  Future<CartDto> addItem({required String productUuid, required int quantity}) async {
    final resp = await _client.call().post('/api/marketplace/cart/items', data: {
      'product_uuid': productUuid,
      'quantity': quantity,
    });
    return CartDto.fromJson(resp.data as Map<String, dynamic>);
  }

  Future<CartDto> updateItem({required String itemUuid, required int quantity}) async {
    final resp = await _client.call().put('/api/marketplace/cart/items/$itemUuid', data: {
      'quantity': quantity,
    });
    return CartDto.fromJson(resp.data as Map<String, dynamic>);
  }

  Future<CartDto> removeItem(String itemUuid) async {
    final resp = await _client.call().delete('/api/marketplace/cart/items/$itemUuid');
    return CartDto.fromJson(resp.data as Map<String, dynamic>);
  }

  Future<void> clearCart() async {
    await _client.call().delete('/api/marketplace/cart');
  }
}
