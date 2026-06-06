import 'package:injectable/injectable.dart';
import '../../../../core/api/api_client.dart';
import '../dto/notification_dto.dart';

@lazySingleton
class NotificationRemoteSource {
  final ApiClient _client;
  NotificationRemoteSource(this._client);

  Future<List<NotificationDto>> getNotifications() async {
    final resp = await _client.call().get('/api/notifications');
    final data = resp.data;

    // Support both formats : liste directe OU collection Hydra
    List<dynamic> raw;
    if (data is List) {
      raw = data;
    } else if (data is Map) {
      raw = data['hydra:member'] as List? ??
            data['items']        as List? ??
            data['data']         as List? ??
            [];
    } else {
      raw = [];
    }

    return raw
        .whereType<Map<String, dynamic>>()
        .map(NotificationDto.fromJson)
        .toList();
  }
}
