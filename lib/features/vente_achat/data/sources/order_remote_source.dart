import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_client.dart';
import '../dto/export.dart';

@lazySingleton
class OrderRemoteSource {
  final ApiClient _client;
  OrderRemoteSource(this._client);

  Future<PageResultDto<OrderDto>> getOrders({int page = 1, int limit = 20}) async {
    final resp = await _client.call().get('/api/marketplace/orders', queryParameters: {
      'page': page,
      'limit': limit,
    });
    return PageResultDto.fromJson(resp.data as Map<String, dynamic>, OrderDto.fromJson);
  }

  Future<List<OrderDto>> checkout({
    String? note,
    Map<String, dynamic>? shippingAddress,
  }) async {
    final body = <String, dynamic>{
      'shipping_address': shippingAddress ?? {},
    };
    if (note != null && note.isNotEmpty) body['note'] = note;
    if (kDebugMode) debugPrint('[Order checkout] body=$body');
    final resp = await _client.call().post('/api/marketplace/orders', data: body);
    final list = resp.data as List;
    return list.map((e) => OrderDto.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<OrderDto> buyNow({
    required String productUuid,
    int quantity = 1,
    String? note,
    Map<String, dynamic>? shippingAddress,
  }) async {
    final body = <String, dynamic>{
      'product_uuid':     productUuid,
      'quantity':         quantity,
      'shipping_address': shippingAddress ?? {},
    };
    if (note != null && note.isNotEmpty) body['note'] = note;
    if (kDebugMode) debugPrint('[BuyNow] body=$body');
    final resp = await _client.call().post('/api/marketplace/orders/buy-now', data: body);
    return OrderDto.fromJson(resp.data as Map<String, dynamic>);
  }

  Future<OrderDto> deliverOrder({required String orderUuid}) async {
    final resp = await _client.call()
        .patch('/api/marketplace/orders/$orderUuid/deliver');
    return OrderDto.fromJson(resp.data as Map<String, dynamic>);
  }

  /// Récupère les commandes lancées sur la boutique du vendeur
  Future<PageResultDto<OrderDto>> getVendorOrders({int page = 1, int limit = 50}) async {
    final resp = await _client.call().get('/api/marketplace/vendor/orders', queryParameters: {
      'page': page,
      'limit': limit,
    });
    return PageResultDto.fromJson(resp.data as Map<String, dynamic>, OrderDto.fromJson);
  }
}
