import '../../domain/message.dart';

class NotificationDto {
  final String  id;
  final String  title;
  final String  message;
  final String  type;
  final bool    read;
  final String? createdAt;

  const NotificationDto({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.read,
    this.createdAt,
  });

  factory NotificationDto.fromJson(Map<String, dynamic> json) {
    return NotificationDto(
      id:        json['id']?.toString()      ?? json['@id']?.toString() ?? '',
      title:     json['title']    as String? ?? json['titre']     as String? ?? '',
      message:   json['message']  as String? ?? json['content']   as String?
                 ?? json['body']  as String? ?? json['description'] as String? ?? '',
      type:      json['type']     as String? ?? 'action',
      read:      json['read']     as bool?   ?? json['isRead'] as bool? ?? false,
      createdAt: json['createdAt'] as String? ?? json['created_at'] as String?,
    );
  }

  ActivityItem toActivityItem() {
    final dt = createdAt != null
        ? DateTime.tryParse(createdAt!) ?? DateTime.now()
        : DateTime.now();

    return ActivityItem(
      id:        id,
      titre:     title,
      sousTitre: message,
      heure:     dt,
      type:      _mapType(type),
      isLu:      read,
    );
  }

  static MessageType _mapType(String t) {
    final lower = t.toLowerCase();
    if (lower.contains('message') || lower.contains('chat'))        return MessageType.message;
    if (lower.contains('livr') || lower.contains('delivery'))       return MessageType.livraison;
    if (lower.contains('pay') || lower.contains('paiement'))        return MessageType.paiement;
    if (lower.contains('price') || lower.contains('prix'))          return MessageType.alertePrix;
    return MessageType.action;
  }
}
