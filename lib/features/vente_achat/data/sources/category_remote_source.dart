import 'package:injectable/injectable.dart';
import '../../../../core/api/api_client.dart';
import '../dto/export.dart';

@lazySingleton
class CategoryRemoteSource {
  final ApiClient _client;
  CategoryRemoteSource(this._client);

  Future<List<CategoryDto>> getCategories() async {
    final resp = await _client.call().get('/api/marketplace/categories');
    final list = resp.data as List;
    return list.map((e) => CategoryDto.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<CategoryFeatureDto>> getCategoryFeatures(String uuid) async {
    final resp = await _client.call().get('/api/marketplace/categories/$uuid/features');
    final list = resp.data as List;
    return list.map((e) => CategoryFeatureDto.fromJson(e as Map<String, dynamic>)).toList();
  }
}
