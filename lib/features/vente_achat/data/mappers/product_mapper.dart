import '../../domain/annonce.dart';
import '../../domain/models/export.dart';
import '../../domain/vendeur.dart';

/// Construit une map UUID → AnnonceCategorie depuis la liste de catégories API.
Map<String, AnnonceCategorie> buildCategoryMap(List<Category> categories) {
  final map = <String, AnnonceCategorie>{};
  for (final cat in categories) {
    map[cat.uuid] = _guessFromSlugOrName(cat.slug, cat.name);
    for (final sub in cat.children) {
      map[sub.uuid] = _guessFromSlugOrName(sub.slug, sub.name);
    }
  }
  return map;
}

/// Utilise le slug en priorité (plus fiable) puis le nom en fallback.
AnnonceCategorie _guessFromSlugOrName(String? slug, String name) {
  if (slug != null) {
    final s = slug.toLowerCase();
    if (s.contains('phone') || s.contains('mobile') || s.contains('gsm') || s.contains('télé')) return AnnonceCategorie.telephones;
    if (s.contains('mode') || s.contains('vetement') || s.contains('fashion') || s.contains('sac')) return AnnonceCategorie.mode;
    if (s.contains('maison') || s.contains('meuble') || s.contains('home') || s.contains('jardin')) return AnnonceCategorie.maison;
    if (s.contains('auto') || s.contains('moto') || s.contains('vehicule') || s.contains('voiture')) return AnnonceCategorie.auto;
    if (s.contains('beaute') || s.contains('cosmet') || s.contains('soin') || s.contains('parfum')) return AnnonceCategorie.beaute;
    if (s.contains('tech') || s.contains('info') || s.contains('electro') || s.contains('high-tech')) return AnnonceCategorie.hightech;
    if (s.contains('sport') || s.contains('loisir') || s.contains('fitness')) return AnnonceCategorie.sport;
    if (s.contains('livre') || s.contains('book') || s.contains('educ')) return AnnonceCategorie.livres;
  }
  return _guessFromName(name);
}

AnnonceCategorie _guessFromName(String name) {
  final n = name.toLowerCase();
  if (n.contains('télé') || n.contains('phone') || n.contains('mobile') || n.contains('gsm')) return AnnonceCategorie.telephones;
  if (n.contains('mode') || n.contains('vêt') || n.contains('habit') || n.contains('fashion') || n.contains('sac')) return AnnonceCategorie.mode;
  if (n.contains('maison') || n.contains('meuble') || n.contains('décor') || n.contains('jardin')) return AnnonceCategorie.maison;
  if (n.contains('auto') || n.contains('moto') || n.contains('voiture') || n.contains('véhicule') || n.contains('transport')) return AnnonceCategorie.auto;
  if (n.contains('beauté') || n.contains('cosm') || n.contains('soins') || n.contains('parfum') || n.contains('cheveux')) return AnnonceCategorie.beaute;
  if (n.contains('tech') || n.contains('info') || n.contains('électro') || n.contains('ordinateur') || n.contains('high')) return AnnonceCategorie.hightech;
  if (n.contains('sport') || n.contains('loisir') || n.contains('fitness') || n.contains('gym')) return AnnonceCategorie.sport;
  if (n.contains('livre') || n.contains('book') || n.contains('éduc') || n.contains('scolaire')) return AnnonceCategorie.livres;
  return AnnonceCategorie.telephones;
}

/// Convertit un [Product] API en [Annonce] UI.
Annonce productToAnnonce(
  Product product, {
  Map<String, AnnonceCategorie> catMap = const {},
}) {
  // Catégorie : utilise le nom du produit si la map est vide
  final cat = catMap[product.categoryUuid]
      ?? (product.categoryName.isNotEmpty ? _guessFromName(product.categoryName) : AnnonceCategorie.telephones);

  // Toutes les URLs d'images disponibles : banner en premier, puis les autres
  final allPhotos = [
    if (product.bannerUrl != null) product.bannerUrl!,
    ...product.imageUrls,
  ];

  return Annonce(
    id:           product.uuid,
    titre:        product.name,
    prix:         product.price.toDouble(),
    ancienPrix:   product.discountedPrice?.toDouble(),
    localisation: 'Bénin',
    categorie:    cat,
    status:       product.status == 'active' ? AnnonceStatus.active : AnnonceStatus.enAttente,
    vendeur:      _shopVendeur(product),
    description:  product.description,
    photos:       allPhotos,
    vues:         0,
    datePublication: product.createdAt ?? DateTime.now(),
    isPro:        product.status == 'active',
  );
}

/// Crée un Vendeur depuis les infos du shop du produit.
Vendeur _shopVendeur(Product p) {
  final name = p.shopName ?? 'Boutique';
  final initials = name.isNotEmpty
      ? name.split(' ').map((w) => w.isNotEmpty ? w[0].toUpperCase() : '').take(2).join()
      : 'B';
  return Vendeur(
    id:          p.shopUuid.isEmpty ? 'shop' : p.shopUuid,
    nom:         name,
    initiales:   initials,
    note:        p.avgRating ?? 0,
    ventes:      p.reviewCount ?? 0,
    tempsReponse: '?',
    isPro:       false,
    isVerifie:   false,
    avatar:      p.shopLogo,
  );
}
