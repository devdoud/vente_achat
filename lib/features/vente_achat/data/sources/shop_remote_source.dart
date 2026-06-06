import 'package:injectable/injectable.dart';
import '../../../../core/api/api_client.dart';
import '../dto/shop_dto.dart';

@lazySingleton
class ShopRemoteSource {
  final ApiClient _client;
  ShopRemoteSource(this._client);

  Future<ShopDto> createShop({
    required String name,
    String? description,
  }) async {
    final resp = await _client.call().post(
      '/api/marketplace/shops',
      data: {
        'name':        name,
        if (description != null && description.isNotEmpty)
          'description': description,
      },
    );
    return ShopDto.fromJson(resp.data as Map<String, dynamic>);
  }

  Future<ShopDto> updateShop({
    required String shopUuid,
    required String name,
    String? description,
  }) async {
    final resp = await _client.call().patch(
      '/api/marketplace/shops/$shopUuid',
      data: {
        'name': name,
        if (description != null) 'description': description,
      },
    );
    return ShopDto.fromJson(resp.data as Map<String, dynamic>);
  }
}
