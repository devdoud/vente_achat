import 'vendeur.dart';

enum MessageType { message, livraison, paiement, alertePrix, action }

class Conversation {
  final String id;
  final Vendeur interlocuteur;
  final String dernierMessage;
  final DateTime heure;
  final int nonLus;
  final bool isEnLigne;
  final bool isLu;

  const Conversation({
    required this.id,
    required this.interlocuteur,
    required this.dernierMessage,
    required this.heure,
    this.nonLus = 0,
    this.isEnLigne = false,
    this.isLu = false,
  });

  String get heureFormatee {
    final now = DateTime.now();
    final diff = now.difference(heure);
    if (diff.inDays == 0) {
      return '${heure.hour.toString().padLeft(2, '0')}:${heure.minute.toString().padLeft(2, '0')}';
    }
    if (diff.inDays == 1) return 'Hier';
    if (diff.inDays <= 7) {
      const jours = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
      return jours[heure.weekday - 1];
    }
    return '${heure.day}/${heure.month}';
  }
}

class ChatMessage {
  final String id;
  final String contenu;
  final DateTime heure;
  final bool isMe;
  final bool isLu;

  const ChatMessage({
    required this.id,
    required this.contenu,
    required this.heure,
    required this.isMe,
    this.isLu = false,
  });
}

class ActivityItem {
  final String id;
  final String titre;
  final String sousTitre;
  final DateTime heure;
  final MessageType type;
  final bool isLu;

  const ActivityItem({
    required this.id,
    required this.titre,
    required this.sousTitre,
    required this.heure,
    required this.type,
    this.isLu = false,
  });

  String get heureFormatee {
    final now = DateTime.now();
    final diff = now.difference(heure);
    if (diff.inMinutes < 60) return 'il y a ${diff.inMinutes} min';
    if (diff.inHours < 24) return 'il y a ${diff.inHours}h';
    if (diff.inDays == 1) {
      return 'Hier, ${heure.hour.toString().padLeft(2, '0')}:${heure.minute.toString().padLeft(2, '0')}';
    }
    return '${heure.day}/${heure.month}';
  }
}

abstract final class ConversationsMock {
  static final List<Conversation> all = [
    Conversation(
      id: 'c1',
      interlocuteur: VendeursMock.adjoa,
      dernierMessage: 'Ça marche ! On fait une Offr...',
      heure: DateTime.now().subtract(const Duration(minutes: 2)),
      nonLus: 2,
      isEnLigne: true,
    ),
    Conversation(
      id: 'c2',
      interlocuteur: VendeursMock.yves,
      dernierMessage: 'Bonjour, je suis intéressé p...',
      heure: DateTime.now().subtract(const Duration(hours: 1, minutes: 15)),
      nonLus: 1,
      isEnLigne: true,
    ),
    Conversation(
      id: 'c3',
      interlocuteur: VendeursMock.kouadio,
      dernierMessage: 'Vous : Merci pour la transactio...',
      heure: DateTime.now().subtract(const Duration(hours: 3)),
      nonLus: 0,
      isLu: true,
    ),
    Conversation(
      id: 'c4',
      interlocuteur: VendeursMock.fatou,
      dernierMessage: 'Vous : Le produit a été livré',
      heure: DateTime.now().subtract(const Duration(days: 1)),
      nonLus: 0,
      isLu: true,
    ),
    Conversation(
      id: 'c5',
      interlocuteur: VendeursMock.marie,
      dernierMessage: 'Excellent vendeur, je recom...',
      heure: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      nonLus: 1,
    ),
  ];

  static final List<ChatMessage> chatMessages = [
    ChatMessage(
      id: 'm1',
      contenu: 'Bonjour ! Le téléphone est toujours disponible 😊',
      heure: DateTime.now().subtract(const Duration(hours: 2, minutes: 2)),
      isMe: false,
    ),
    ChatMessage(
      id: 'm2',
      contenu: 'Bonjour, oui il est dispo. Vous voulez le voir aujourd\'hui ?',
      heure: DateTime.now().subtract(const Duration(hours: 2, minutes: 1)),
      isMe: true,
      isLu: true,
    ),
    ChatMessage(
      id: 'm3',
      contenu: 'Parfait ! Vous pouvez baisser le prix à 420k ?',
      heure: DateTime.now().subtract(const Duration(hours: 2)),
      isMe: false,
    ),
    ChatMessage(
      id: 'm4',
      contenu: 'Je peux faire 440 000 F maximum 🙂',
      heure: DateTime.now().subtract(const Duration(minutes: 90)),
      isMe: true,
      isLu: true,
    ),
    ChatMessage(
      id: 'm5',
      contenu: 'Ça marche ! On fait une Offre Sûre alors',
      heure: DateTime.now().subtract(const Duration(minutes: 5)),
      isMe: false,
    ),
  ];

  static final List<ActivityItem> activities = [
    ActivityItem(
      id: 'a1',
      titre: 'Nouveau message d\'Adjoa Kouassi',
      sousTitre: '"Ça marche ! On fait une Offre Sûre alors"',
      heure: DateTime.now().subtract(const Duration(minutes: 5)),
      type: MessageType.message,
    ),
    ActivityItem(
      id: 'a2',
      titre: 'Votre commande est en route',
      sousTitre: 'Le livreur Yao K. arrive dans 15 min',
      heure: DateTime.now().subtract(const Duration(minutes: 22)),
      type: MessageType.livraison,
    ),
    ActivityItem(
      id: 'a3',
      titre: 'Baisse de prix sur vos favoris',
      sousTitre: 'iPhone 13 Pro est à 450 000 F (-15%)',
      heure: DateTime.now().subtract(const Duration(hours: 1)),
      type: MessageType.alertePrix,
    ),
    ActivityItem(
      id: 'a4',
      titre: 'Paiement reçu',
      sousTitre: '+35 000 F pour "Sac à main cuir"',
      heure: DateTime.now().subtract(const Duration(hours: 2)),
      type: MessageType.paiement,
    ),
    ActivityItem(
      id: 'a5',
      titre: 'Annonce validée !',
      sousTitre: '"Sneakers Nike Air Max" est en ligne',
      heure: DateTime.now().subtract(const Duration(days: 1, hours: 8, minutes: 37)),
      type: MessageType.action,
      isLu: true,
    ),
    ActivityItem(
      id: 'a6',
      titre: 'Nouvelle évaluation 5 ⭐',
      sousTitre: 'Marie D. : "Très bon vendeur !"',
      heure: DateTime.now().subtract(const Duration(days: 1, hours: 11, minutes: 52)),
      type: MessageType.message,
      isLu: true,
    ),
    ActivityItem(
      id: 'a7',
      titre: 'Vérification d\'identité requise',
      sousTitre: 'Complétez votre profil pour publier plus',
      heure: DateTime.now().subtract(const Duration(days: 1, hours: 14, minutes: 15)),
      type: MessageType.action,
      isLu: true,
    ),
  ];
}
