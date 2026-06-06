import 'package:injectable/injectable.dart';
import '../../../../core/api/api_client.dart';
import '../dto/export.dart';

@lazySingleton
class FavoriteRemoteSource {
  final ApiClient _client;
  FavoriteRemoteSource(this._client);

  Future<List<ProductDto>> getFavorites() async {
    final resp = await _client.call().get('/api/v1/favorites');
    final list = resp.data as List;
    return list.map((e) => ProductDto.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> addFavorite(String productUuid) async {
    await _client.call().post('/api/v1/favorite', data: {'product_uuid': productUuid});
  }

  Future<void> removeFavorite(String productUuid) async {
    await _client.call().delete('/api/v1/favorite', data: {'product_uuid': productUuid});
  }
}
