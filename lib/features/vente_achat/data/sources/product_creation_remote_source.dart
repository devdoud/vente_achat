import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_client.dart';
import '../../domain/models/product_creation_data.dart';

@lazySingleton
class ProductCreationRemoteSource {
  final ApiClient _client;
  ProductCreationRemoteSource(this._client);

  Future<Map<String, dynamic>> createProduct(ProductCreationData data) async {
    final formData = FormData();

    formData.fields.addAll([
      MapEntry('name',          data.name),
      MapEntry('price',         data.price.toString()),
      MapEntry('description',   data.description.isEmpty ? data.name : data.description),
      MapEntry('category_uuid', data.categoryUuid),
      MapEntry('stock',         data.stock.toString()),
      if (data.location.isNotEmpty) MapEntry('location', data.location),
    ]);

    // Features de catégorie : objet JSON encodé en string (format attendu par l'API)
    if (data.features != null && data.features!.isNotEmpty) {
      formData.fields.add(MapEntry('features', jsonEncode(data.features)));
    }

    // Image principale (banner)
    if (data.photos.isNotEmpty) {
      formData.files.add(MapEntry('banner',
          await MultipartFile.fromFile(
            data.photos.first.path,
            filename: 'banner.jpg',
            contentType: DioMediaType('image', 'jpeg'),
          )));
    }

    // Images secondaires (max 2)
    for (final photo in data.photos.skip(1).take(2)) {
      formData.files.add(MapEntry('images[]',
          await MultipartFile.fromFile(
            photo.path,
            filename: 'image.jpg',
            contentType: DioMediaType('image', 'jpeg'),
          )));
    }

    final resp = await _client.call().post(
      '/api/marketplace/shops/${data.shopUuid}/products',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    return _normalize(resp.data as Map<String, dynamic>);
  }

  Future<Map<String, dynamic>> updateProduct({
    required String productUuid,
    required Map<String, dynamic> fields,
  }) async {
    final resp = await _client.call().patch(
      '/api/marketplace/products/$productUuid',
      data: fields,
    );
    return _normalize(resp.data as Map<String, dynamic>);
  }

  Future<void> deleteProduct({required String productUuid}) async {
    await _client.call().delete('/api/marketplace/products/$productUuid');
  }

  static Map<String, dynamic> _normalize(Map<String, dynamic> j) {
    final category    = j['category']     as Map<String, dynamic>?;
    final banner      = j['banner']       as Map<String, dynamic>?;
    final stockDetail = j['stock_detail'] as Map<String, dynamic>?;
    final rawImages   = j['images']       as List?;
    // Si l'API ne renvoie pas de statut, on suppose draft (plus sûr)
    final status = j['status'] as String? ?? 'draft';
    debugPrint('[ProductCreation] API status="$status" uuid=${j['uuid']}');

    return {
      'uuid':             j['uuid'],
      'name':             j['name'],
      'description':      j['description'] ?? '',
      'price':            j['price'] ?? 0,
      'discounted_price': j['discounted_price'],
      'status':           status,
      'stock':            stockDetail?['stock'] ?? 0,
      'category_uuid':    category?['uuid'] ?? '',
      'shop_uuid':        j['shop_uuid'] ?? j['shop']?['uuid'] ?? '',
      'features':         null,
      'images': rawImages
          ?.whereType<Map>()
          .map((img) => img['image'] as String?)
          .whereType<String>()
          .toList(),
      if (banner?['image'] != null) 'banner_url': banner!['image'],
    };
  }
}
