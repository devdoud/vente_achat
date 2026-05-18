import 'vendeur.dart';

enum AnnonceStatus { active, enAttente, vendue, enLigne }

enum AnnonceCategorie {
  telephones,
  mode,
  maison,
  auto,
  beaute,
  hightech,
  sport,
  livres,
}

extension AnnonceCategorieExt on AnnonceCategorie {
  String get label => switch (this) {
        AnnonceCategorie.telephones => 'Téléphones',
        AnnonceCategorie.mode       => 'Mode',
        AnnonceCategorie.maison     => 'Maison',
        AnnonceCategorie.auto       => 'Auto',
        AnnonceCategorie.beaute     => 'Beauté',
        AnnonceCategorie.hightech   => 'High-tech',
        AnnonceCategorie.sport      => 'Sport',
        AnnonceCategorie.livres     => 'Livres',
      };

  String get emoji => switch (this) {
        AnnonceCategorie.telephones => '📱',
        AnnonceCategorie.mode       => '👜',
        AnnonceCategorie.maison     => '🏠',
        AnnonceCategorie.auto       => '🚗',
        AnnonceCategorie.beaute     => '💄',
        AnnonceCategorie.hightech   => '🖥',
        AnnonceCategorie.sport      => '⚽',
        AnnonceCategorie.livres     => '📚',
      };
}

extension AnnonceStatusExt on AnnonceStatus {
  String get label => switch (this) {
        AnnonceStatus.active    => 'ACTIVE',
        AnnonceStatus.enAttente => 'EN MODÉRATION',
        AnnonceStatus.vendue    => 'VENDUE',
        AnnonceStatus.enLigne   => 'EN LIGNE',
      };
}

class Annonce {
  final String id;
  final String titre;
  final double prix;
  final double? ancienPrix;
  final String localisation;
  final AnnonceCategorie categorie;
  final AnnonceStatus status;
  final Vendeur vendeur;
  final String description;
  final List<String> photos;
  final int vues;
  final DateTime datePublication;
  final bool isPro;

  const Annonce({
    required this.id,
    required this.titre,
    required this.prix,
    this.ancienPrix,
    required this.localisation,
    required this.categorie,
    required this.status,
    required this.vendeur,
    required this.description,
    required this.photos,
    this.vues = 0,
    required this.datePublication,
    this.isPro = false,
  });

  String get prixFormate => '${_formatPrix(prix)} F';
  String? get ancienPrixFormate =>
      ancienPrix != null ? '${_formatPrix(ancienPrix!)} F' : null;

  int? get remisePourcent {
    if (ancienPrix == null) return null;
    return (((ancienPrix! - prix) / ancienPrix!) * 100).round();
  }

  static String _formatPrix(double prix) {
    if (prix >= 1000000) {
      return '${(prix / 1000000).toStringAsFixed(1)}M';
    }
    if (prix >= 1000) {
      final int entier = prix ~/ 1000;
      final int reste  = (prix % 1000).round();
      if (reste == 0) return '$entier 000';
      return '$entier ${reste.toString().padLeft(3, '0')}';
    }
    return prix.toInt().toString();
  }

  String get tempsPublication {
    final diff = DateTime.now().difference(datePublication);
    if (diff.inMinutes < 60) return 'il y a ${diff.inMinutes} min';
    if (diff.inHours < 24)   return 'il y a ${diff.inHours}h';
    if (diff.inDays == 1)    return 'hier';
    return 'il y a ${diff.inDays}j';
  }
}

// ─── Données mock ─────────────────────────────────────────────────────────────

abstract final class AnnoncesMock {

  // ── Téléphones ─────────────────────────────────────────────────────────────

  static final Annonce iphone13 = Annonce(
    id: '1',
    titre: 'iPhone 13 Pro 128Go Sierra Blue',
    prix: 450000,
    ancienPrix: 530000,
    localisation: 'Cadjehoun',
    categorie: AnnonceCategorie.telephones,
    status: AnnonceStatus.active,
    vendeur: VendeursMock.adjoa,
    description:
        'iPhone 13 Pro en excellent état, utilisé moins d\'un an. '
        'Capacité 128Go, couleur Sierra Blue. Vendu avec boîte d\'origine, '
        'chargeur et facture. Batterie 92%, aucune rayure.',
    photos: [],
    vues: 234,
    datePublication: DateTime.now().subtract(const Duration(hours: 2)),
    isPro: true,
  );

  static final Annonce samsung = Annonce(
    id: '2',
    titre: 'Samsung Galaxy S22 Ultra 256Go',
    prix: 320000,
    localisation: 'Akpakpa',
    categorie: AnnonceCategorie.telephones,
    status: AnnonceStatus.active,
    vendeur: VendeursMock.yves,
    description: 'Samsung S22 Ultra en très bon état. Écran impeccable, batterie tient bien.',
    photos: [],
    vues: 89,
    datePublication: DateTime.now().subtract(const Duration(hours: 5)),
    isPro: false,
  );

  static final Annonce tecno = Annonce(
    id: '3b',
    titre: 'Tecno Camon 20 Pro — Neuf scellé',
    prix: 145000,
    ancienPrix: 175000,
    localisation: 'Godomey',
    categorie: AnnonceCategorie.telephones,
    status: AnnonceStatus.active,
    vendeur: VendeursMock.brice,
    description: 'Tecno Camon 20 Pro neuf, boîte scellée. Garantie 12 mois distributeur.',
    photos: [],
    vues: 312,
    datePublication: DateTime.now().subtract(const Duration(minutes: 45)),
    isPro: false,
  );

  static final Annonce iphone12 = Annonce(
    id: '4',
    titre: 'iPhone 12 64Go Rouge',
    prix: 230000,
    localisation: 'Porto-Novo',
    categorie: AnnonceCategorie.telephones,
    status: AnnonceStatus.active,
    vendeur: VendeursMock.stephane,
    description: 'iPhone 12 en bon état. Quelques micro-griffures sur le dos, invisible à l\'usage.',
    photos: [],
    vues: 120,
    datePublication: DateTime.now().subtract(const Duration(days: 3)),
    isPro: false,
  );

  // ── High-tech ──────────────────────────────────────────────────────────────

  static final Annonce canon = Annonce(
    id: '3',
    titre: 'Canon EOS R6 Mark II + objectif 24-105mm',
    prix: 1200000,
    ancienPrix: 1450000,
    localisation: 'Haie Vive',
    categorie: AnnonceCategorie.hightech,
    status: AnnonceStatus.active,
    vendeur: VendeursMock.adjoa,
    description: 'Appareil photo professionnel Canon EOS R6 Mark II avec objectif L-series. Très peu utilisé.',
    photos: [],
    vues: 56,
    datePublication: DateTime.now().subtract(const Duration(days: 1)),
    isPro: true,
  );

  static final Annonce laptop = Annonce(
    id: '7',
    titre: 'MacBook Pro M1 2021 — 8Go/256Go',
    prix: 950000,
    ancienPrix: 1100000,
    localisation: 'Fidjrossè',
    categorie: AnnonceCategorie.hightech,
    status: AnnonceStatus.active,
    vendeur: VendeursMock.fatou,
    description: 'MacBook Pro M1 en parfait état. Batterie : 85 cycles. Vendu avec chargeur original.',
    photos: [],
    vues: 178,
    datePublication: DateTime.now().subtract(const Duration(hours: 18)),
    isPro: false,
  );

  // ── Mode ───────────────────────────────────────────────────────────────────

  static final Annonce sacMain = Annonce(
    id: '5',
    titre: 'Sac à main cuir véritable — Marron',
    prix: 35000,
    localisation: 'Fidjrossè',
    categorie: AnnonceCategorie.mode,
    status: AnnonceStatus.active,
    vendeur: VendeursMock.fatou,
    description: 'Sac à main en cuir véritable, couleur marron caramel. Très bon état, peu utilisé.',
    photos: [],
    vues: 45,
    datePublication: DateTime.now().subtract(const Duration(hours: 1)),
    isPro: false,
  );

  static final Annonce robe = Annonce(
    id: '8',
    titre: 'Robe pagne Ankara — Taille 40',
    prix: 22000,
    ancienPrix: 28000,
    localisation: 'Dantokpa',
    categorie: AnnonceCategorie.mode,
    status: AnnonceStatus.active,
    vendeur: VendeursMock.marie,
    description: 'Belle robe pagne Ankara cousue sur mesure. Jamais portée. Taille 40.',
    photos: [],
    vues: 67,
    datePublication: DateTime.now().subtract(const Duration(hours: 4)),
    isPro: false,
  );

  // ── Sport ──────────────────────────────────────────────────────────────────

  static final Annonce sneakers = Annonce(
    id: '6',
    titre: 'Nike Air Max 90 — Taille 42',
    prix: 85000,
    localisation: 'Abomey-Calavi',
    categorie: AnnonceCategorie.sport,
    status: AnnonceStatus.active,
    vendeur: VendeursMock.adjoa,
    description: 'Nike Air Max 90 neuves, jamais portées. Taille 42. Coloris blanc/noir.',
    photos: [],
    vues: 0,
    datePublication: DateTime.now().subtract(const Duration(hours: 3)),
    isPro: false,
  );

  static final Annonce velo = Annonce(
    id: '9',
    titre: 'Vélo VTT Trek 26 pouces',
    prix: 180000,
    ancienPrix: 220000,
    localisation: 'Bohicon',
    categorie: AnnonceCategorie.sport,
    status: AnnonceStatus.active,
    vendeur: VendeursMock.yves,
    description: 'Vélo VTT Trek en bon état. Pneus récents, freins révisés. Idéal pour terrain varié.',
    photos: [],
    vues: 33,
    datePublication: DateTime.now().subtract(const Duration(days: 2)),
    isPro: false,
  );

  // ── Maison ─────────────────────────────────────────────────────────────────

  static final Annonce clim = Annonce(
    id: '10',
    titre: 'Climatiseur Samsung 1.5 CV — Très bon état',
    prix: 120000,
    ancienPrix: 160000,
    localisation: 'Agla, Cotonou',
    categorie: AnnonceCategorie.maison,
    status: AnnonceStatus.active,
    vendeur: VendeursMock.stephane,
    description: 'Climatiseur Samsung inverter 1.5 CV. Fonctionne parfaitement. Démontage et transport à la charge de l\'acheteur.',
    photos: [],
    vues: 91,
    datePublication: DateTime.now().subtract(const Duration(hours: 8)),
    isPro: false,
  );

  // ── Auto ───────────────────────────────────────────────────────────────────

  static final Annonce moto = Annonce(
    id: '11',
    titre: 'Moto Jakarta 200cc — 2022',
    prix: 420000,
    localisation: 'Parakou',
    categorie: AnnonceCategorie.auto,
    status: AnnonceStatus.active,
    vendeur: VendeursMock.brice,
    description: 'Moto Jakarta 200cc, année 2022. Très bien entretenue, kilométrage modéré. Carte grise à jour.',
    photos: [],
    vues: 145,
    datePublication: DateTime.now().subtract(const Duration(days: 1)),
    isPro: false,
  );

  // ── Liste complète ─────────────────────────────────────────────────────────

  static List<Annonce> get all => [
        iphone13, samsung,  tecno,    iphone12,
        canon,    laptop,   sacMain,  robe,
        sneakers, velo,     clim,     moto,
      ];

  static List<Annonce> get telephones =>
      all.where((a) => a.categorie == AnnonceCategorie.telephones).toList();
}
