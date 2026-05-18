class Vendeur {
  final String id;
  final String nom;
  final String initiales;
  final String? avatar;
  final double note;
  final int ventes;
  final String tempsReponse;
  final bool isPro;
  final bool isVerifie;
  final String? localisation;
  final String? username;
  final String? description;
  final int? produits;
  final int? abonnes;

  const Vendeur({
    required this.id,
    required this.nom,
    required this.initiales,
    this.avatar,
    required this.note,
    required this.ventes,
    required this.tempsReponse,
    this.isPro = false,
    this.isVerifie = false,
    this.localisation,
    this.username,
    this.description,
    this.produits,
    this.abonnes,
  });
}

abstract final class VendeursMock {
  static const Vendeur adjoa = Vendeur(
    id: 'v1',
    nom: 'Adjoa Agossou',
    initiales: 'AA',
    note: 4.9,
    ventes: 87,
    tempsReponse: '~2h',
    isPro: true,
    isVerifie: true,
    localisation: 'Cadjehoun, Cotonou',
    username: '@adjoaagossou',
    description: 'Spécialiste téléphones et accessoires neufs et reconditionnés.',
    produits: 42,
    abonnes: 1200,
  );

  static const Vendeur yves = Vendeur(
    id: 'v2',
    nom: 'Yves Dossou',
    initiales: 'YD',
    note: 4.6,
    ventes: 34,
    tempsReponse: '~30min',
    isPro: false,
    isVerifie: true,
    localisation: 'Akpakpa, Cotonou',
    username: '@yvesdossou',
  );

  static const Vendeur stephane = Vendeur(
    id: 'v3',
    nom: 'Stéphane Azonsi',
    initiales: 'SA',
    note: 4.3,
    ventes: 12,
    tempsReponse: '~1h',
    isPro: false,
    isVerifie: false,
    localisation: 'Porto-Novo',
  );

  static const Vendeur fatou = Vendeur(
    id: 'v4',
    nom: 'Fatou Bello',
    initiales: 'FB',
    note: 4.8,
    ventes: 56,
    tempsReponse: '~45min',
    isPro: false,
    isVerifie: true,
    localisation: 'Fidjrossè, Cotonou',
  );

  static const Vendeur marie = Vendeur(
    id: 'v5',
    nom: 'Marie Amoussou',
    initiales: 'MA',
    note: 4.7,
    ventes: 23,
    tempsReponse: '~2h',
    isPro: false,
    isVerifie: false,
    localisation: 'Haie Vive, Cotonou',
  );

  static const Vendeur mobileStore = Vendeur(
    id: 'v6',
    nom: 'Mobile Store BJ',
    initiales: 'MB',
    note: 4.9,
    ventes: 347,
    tempsReponse: '~15min',
    isPro: true,
    isVerifie: true,
    localisation: 'Ganhi, Cotonou',
    username: '@mobilestorebj',
    description:
        'Spécialiste téléphones et accessoires neufs et reconditionnés. Garantie 6 mois sur tous les produits.',
    produits: 42,
    abonnes: 1200,
  );

  // Alias pour compatibilité ascendante avec l'ancienne clé "kouadio"
  static const Vendeur kouadio = stephane;

  static const Vendeur brice = Vendeur(
    id: 'v7',
    nom: 'Brice Da Costa',
    initiales: 'BC',
    note: 4.5,
    ventes: 18,
    tempsReponse: '~3h',
    isPro: false,
    isVerifie: false,
    localisation: 'Godomey, Abomey-Calavi',
  );
}
