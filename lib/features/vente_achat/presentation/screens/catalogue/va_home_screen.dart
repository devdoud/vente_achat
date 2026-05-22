import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../theme/va_theme.dart';
import '../../../domain/export.dart';
import 'annonce_detail_screen.dart';
import 'annonces_feed_screen.dart';
import 'search_screen.dart';
import '../compte/filtres_screen.dart';

//  Données statiques 

class _Cat {
  final String emoji;
  final String label;
  final Color bg;
  final AnnonceCategorie cat;
  const _Cat(this.emoji, this.label, this.bg, this.cat);
}

const _cats = [
  _Cat('', 'Téléphones', Color(0xFFD6EBFF), AnnonceCategorie.telephones),
  _Cat('', 'Mode',       Color(0xFFFFDDE9), AnnonceCategorie.mode),
  _Cat('', 'Maison',     Color(0xFFD9F2DD), AnnonceCategorie.maison),
  _Cat('', 'Auto',       Color(0xFFFFF0C2), AnnonceCategorie.auto),
  _Cat('', 'Beauté',     Color(0xFFF0DCF9), AnnonceCategorie.beaute),
  _Cat('',  'High-tech', Color(0xFFD4F0FC), AnnonceCategorie.hightech),
  _Cat('', 'Sport',      Color(0xFFD6F5E3), AnnonceCategorie.sport),
  _Cat('', 'Livres',     Color(0xFFFFEBCC), AnnonceCategorie.livres),
];


// Cycle de hauteurs d'images pour l'effet staggeré
const _imgH = [146.0, 108.0, 128.0, 116.0, 142.0, 104.0, 134.0, 118.0];

//  Écran principal 

@RoutePage()
class VAHomeScreen extends StatelessWidget {
  const VAHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final all = AnnoncesMock.all;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverSafeArea(
            bottom: false,
            sliver: SliverToBoxAdapter(child: _Header()),
          ),
          SliverToBoxAdapter(child: _SearchBar()),
          SliverToBoxAdapter(child: _CategoriesSection()),
          SliverToBoxAdapter(child: _TrustStrip()),
          SliverToBoxAdapter(child: _SpotlightSection(annonces: all)),
          SliverToBoxAdapter(child: _InfiniteMasonryFeed(annonces: all)),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}

// 
//  HEADER
// 

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
      child: Row(
        children: [
          // Titre direct, sans logo
          const Text(
            'Vente & Achat',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: VAColors.black,
              letterSpacing: -0.5,
            ),
          ),
          const Spacer(),
          // Chip localisation — l'élément utile côté droit
          _LocationChip(),
        ],
      ),
    );
  }
}

class _LocationChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [BoxShadow(color: Color(0x10000000), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_on_rounded, color: VAColors.primary, size: 14),
            const SizedBox(width: 4),
            const Text(
              'Cotonou',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: VAColors.black),
            ),
            const SizedBox(width: 3),
            const Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: VAColors.grey),
          ],
        ),
      ),
    );
  }
}


// 
//  SEARCH
// 

class _SearchBar extends StatelessWidget {
  void _openSearch(BuildContext context) => Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const SearchScreen(),
          transitionsBuilder: (_, anim, __, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: const Duration(milliseconds: 180),
        ),
      );

  void _openFilters(BuildContext context) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => const FiltresScreen(),
      );

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.fromLTRB(16, 6, 16, 0),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(color: Color(0x0D000000), blurRadius: 14, offset: Offset(0, 4))
          ],
        ),
        child: Row(
          children: [
            // Zone de recherche (tap → SearchScreen)
            Expanded(
              child: GestureDetector(
                onTap: () => _openSearch(context),
                behavior: HitTestBehavior.opaque,
                child: const Row(
                  children: [
                    SizedBox(width: 16),
                    Icon(Icons.search_rounded, color: VAColors.primary, size: 22),
                    SizedBox(width: 10),
                    Text('Que cherchez-vous ?',
                        style: TextStyle(color: Color(0xFFBBBBBB), fontSize: 14)),
                  ],
                ),
              ),
            ),
            // Bouton filtre (tap → FiltresScreen)
            GestureDetector(
              onTap: () => _openFilters(context),
              child: Container(
                margin: const EdgeInsets.all(7),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: VAColors.primary,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(Icons.tune_rounded, color: Colors.white, size: 15),
              ),
            ),
          ],
        ),
      );
}

// 
//  TRUST STRIP (une ligne)
// 

class _TrustStrip extends StatelessWidget {
  static const _items = [
    (Icons.verified_user_outlined,  'Paiement sécurisé'),
    (Icons.local_shipping_outlined, 'Livraison incluse'),
    (Icons.replay_rounded,          'Retour 14 jours'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F0),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: VAColors.primaryLight),
      ),
      child: Row(
        children: _items.map((e) => Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(e.$1, size: 12, color: VAColors.primaryDark),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  e.$2,
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w600, color: VAColors.primaryDark),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        )).toList(),
      ),
    );
  }
}

// 
//  SPOTLIGHT — carrousel horizontal avec gradient overlay
// 

class _SpotlightSection extends StatelessWidget {
  final List<Annonce> annonces;
  const _SpotlightSection({required this.annonces});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
          child: Row(
            children: [
              const Text('À ne pas rater ',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w900, color: VAColors.black, letterSpacing: -0.3)),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: const Text('Tout voir',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: VAColors.primary)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 195,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: annonces.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (_, i) => _SpotlightCard(
              annonce: annonces[i],
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => AnnonceDetailScreen(annonce: annonces[i])),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SpotlightCard extends StatefulWidget {
  final Annonce annonce;
  final VoidCallback onTap;
  const _SpotlightCard({required this.annonce, required this.onTap});

  @override
  State<_SpotlightCard> createState() => _SpotlightCardState();
}

class _SpotlightCardState extends State<_SpotlightCard> {
  bool _fav = false;

  Color get _bg => _catColor(widget.annonce.categorie);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 148,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 5))],
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Fond coloré + emoji
            Container(
              color: _bg,
              child: Center(
                child: Text(widget.annonce.categorie.emoji,
                    style: const TextStyle(fontSize: 56)),
              ),
            ),
            // Gradient du bas
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withValues(alpha: 0.72)],
                    stops: const [0.38, 1.0],
                  ),
                ),
              ),
            ),
            // Badge remise
            if (widget.annonce.remisePourcent != null)
              Positioned(
                top: 9,
                left: 9,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: VAColors.red, borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    '-${widget.annonce.remisePourcent}%',
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800),
                  ),
                ),
              )
            else if (widget.annonce.isPro)
              Positioned(
                top: 9,
                left: 9,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: VAColors.primary, borderRadius: BorderRadius.circular(20)),
                  child: const Text('Pro',
                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                ),
              ),
            // Favori
            Positioned(
              top: 7,
              right: 7,
              child: GestureDetector(
                onTap: () => setState(() => _fav = !_fav),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _fav ? Icons.favorite : Icons.favorite_border,
                    size: 15,
                    color: _fav ? VAColors.red : VAColors.grey,
                  ),
                ),
              ),
            ),
            // Titre + prix en bas
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.annonce.titre,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700, height: 1.25),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          widget.annonce.prixFormate,
                          style: const TextStyle(
                              color: VAColors.primary, fontSize: 13, fontWeight: FontWeight.w800),
                        ),
                        const Spacer(),
                        const Icon(Icons.location_on_outlined, size: 10, color: Colors.white54),
                        const SizedBox(width: 2),
                        Flexible(
                          child: Text(
                            widget.annonce.localisation,
                            style: const TextStyle(color: Colors.white54, fontSize: 9),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 
//  CATEGORIES — scroll horizontal premium
// 

class _CategoriesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        children: [
          //  Chip "Tout" actif (orange) — pas de navigation, déjà sur l'écran principal
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: VAColors.primary,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: VAColors.primary.withValues(alpha: 0.38),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.apps_rounded, color: Colors.white, size: 15),
                  SizedBox(width: 6),
                  Text('Tout',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
                ],
              ),
            ),
          ),

          //  Chips catégories 
          for (final c in _cats)
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => AnnoncesFeedScreen(categorie: c.cat)),
              ),
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.only(left: 5, right: 13, top: 4, bottom: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: const [
                    BoxShadow(color: Color(0x12000000), blurRadius: 6, offset: Offset(0, 2)),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Cercle coloré avec emoji
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(color: c.bg, shape: BoxShape.circle),
                      child: Center(
                        child: Text(c.emoji, style: const TextStyle(fontSize: 14)),
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      c.label,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600, color: VAColors.black),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}



// 
//  MASONRY INFINI — 8 sections thématiques × 6 produits
// 

class _InfiniteMasonryFeed extends StatelessWidget {
  final List<Annonce> annonces;
  const _InfiniteMasonryFeed({required this.annonces});

  List<Annonce> _pick({List<AnnonceCategorie>? cats, double? maxPrix,
      bool proOnly = false, bool remiseOnly = false, bool recentFirst = false}) {
    var r = annonces.where((a) {
      if (cats != null && !cats.contains(a.categorie)) return false;
      if (maxPrix != null && a.prix > maxPrix) return false;
      if (proOnly && !a.isPro) return false;
      if (remiseOnly && a.ancienPrix == null) return false;
      return true;
    }).toList();
    if (recentFirst) r.sort((a, b) => b.datePublication.compareTo(a.datePublication));
    if (r.isEmpty) r = annonces;
    return List.generate(6, (i) => r[i % r.length]);
  }

  @override
  Widget build(BuildContext context) {
    final sections = [
      (icon: '', title: 'Téléphones & Tech',    items: _pick(cats: [AnnonceCategorie.telephones, AnnonceCategorie.hightech])),
      (icon: '', title: 'Petits prix du moment', items: _pick(maxPrix: 150000)),
      (icon: '', title: 'Mode & Style',           items: _pick(cats: [AnnonceCategorie.mode, AnnonceCategorie.beaute])),
      (icon: '⭐', title: 'Bonnes affaires',        items: _pick(remiseOnly: true)),
      (icon: '', title: 'Maison & Auto',          items: _pick(cats: [AnnonceCategorie.maison, AnnonceCategorie.auto])),
      (icon: '', title: 'Derniers arrivages',     items: _pick(recentFirst: true)),
      (icon: '', title: 'Vendeurs certifiés',     items: _pick(proOnly: true)),
      (icon: '', title: 'Sport & Loisirs',        items: _pick(cats: [AnnonceCategorie.sport, AnnonceCategorie.livres])),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int s = 0; s < sections.length; s++) ...[
          _SectionTitle(icon: sections[s].icon, title: sections[s].title),
          _StaggeredGrid(annonces: sections[s].items, sectionIdx: s),
        ],
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String icon;
  final String title;
  const _SectionTitle({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 26, 16, 8),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 7),
          Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900,
              color: VAColors.black, letterSpacing: -0.4)),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const AnnoncesFeedScreen())),
            child: const Text('Tout voir',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: VAColors.primary)),
          ),
        ],
      ),
    );
  }
}

class _StaggeredGrid extends StatelessWidget {
  final List<Annonce> annonces;
  final int sectionIdx;
  const _StaggeredGrid({required this.annonces, required this.sectionIdx});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(6, (i) {
      final ann = annonces[(i + sectionIdx * 2) % annonces.length];
      final hIdx = (i + sectionIdx * 3) % _imgH.length;
      return (ann, _imgH[hIdx]);
    });

    final left  = <(Annonce, double)>[];
    final right = <(Annonce, double)>[];
    for (int i = 0; i < items.length; i++) {
      if (i.isEven) left.add(items[i]); else right.add(items[i]);
    }
    final offset = sectionIdx.isEven ? 22.0 : 8.0;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [for (int i = 0; i < left.length; i++)
                _PinCard(annonce: left[i].$1, imgHeight: left[i].$2)],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: offset),
                for (int i = 0; i < right.length; i++)
                  _PinCard(annonce: right[i].$1, imgHeight: right[i].$2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PinCard extends StatefulWidget {
  final Annonce annonce;
  final double imgHeight;
  const _PinCard({required this.annonce, required this.imgHeight});

  @override
  State<_PinCard> createState() => _PinCardState();
}

class _PinCardState extends State<_PinCard> {
  bool _fav = false;

  @override
  Widget build(BuildContext context) {
    final bg = _catColor(widget.annonce.categorie);
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => AnnonceDetailScreen(annonce: widget.annonce)),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [BoxShadow(color: Color(0x0C000000), blurRadius: 10, offset: Offset(0, 3))],
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  height: widget.imgHeight,
                  width: double.infinity,
                  color: bg,
                  child: Center(child: Text(widget.annonce.categorie.emoji,
                      style: TextStyle(fontSize: widget.imgHeight * 0.28))),
                ),
                if (widget.annonce.remisePourcent != null)
                  Positioned(top: 7, left: 7,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(color: VAColors.red, borderRadius: BorderRadius.circular(20)),
                      child: Text('-${widget.annonce.remisePourcent}%',
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800)),
                    ))
                else if (widget.annonce.isPro)
                  Positioned(top: 7, left: 7,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(color: VAColors.primary, borderRadius: BorderRadius.circular(20)),
                      child: const Text('Pro',
                          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                    )),
                Positioned(top: 6, right: 6,
                  child: GestureDetector(
                    onTap: () => setState(() => _fav = !_fav),
                    child: Container(
                      width: 27, height: 27,
                      decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.92), shape: BoxShape.circle),
                      child: Icon(_fav ? Icons.favorite : Icons.favorite_border,
                          size: 14, color: _fav ? VAColors.red : VAColors.grey),
                    ),
                  )),
                Positioned(bottom: 7, left: 7,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.52),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(widget.annonce.prixFormate,
                        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
                  )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(9, 7, 9, 9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.annonce.titre,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700,
                          color: VAColors.black, height: 1.3),
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                  if (widget.annonce.ancienPrix != null) ...[
                    const SizedBox(height: 3),
                    Row(children: [
                      Text(widget.annonce.ancienPrixFormate!,
                          style: const TextStyle(fontSize: 10, color: VAColors.grey,
                              decoration: TextDecoration.lineThrough, decorationColor: VAColors.grey)),
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(color: VAColors.redLight, borderRadius: BorderRadius.circular(4)),
                        child: Text('-${widget.annonce.remisePourcent}%',
                            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: VAColors.red)),
                      ),
                    ]),
                  ],
                  const SizedBox(height: 5),
                  Row(children: [
                    Container(
                      width: 16, height: 16,
                      decoration: BoxDecoration(color: bg.withValues(alpha: 0.8), shape: BoxShape.circle),
                      child: Center(child: Text(widget.annonce.vendeur.initiales[0],
                          style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w800, color: VAColors.greyText))),
                    ),
                    const SizedBox(width: 4),
                    Expanded(child: Text(widget.annonce.vendeur.nom.split(' ').first,
                        style: const TextStyle(fontSize: 10, color: VAColors.greyText, fontWeight: FontWeight.w500),
                        maxLines: 1, overflow: TextOverflow.ellipsis)),
                    const Icon(Icons.location_on_outlined, size: 9, color: VAColors.grey),
                    const SizedBox(width: 2),
                    Flexible(child: Text(widget.annonce.localisation,
                        style: const TextStyle(fontSize: 9, color: VAColors.grey),
                        maxLines: 1, overflow: TextOverflow.ellipsis)),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 
//  UTILITAIRES
// 

Color _catColor(AnnonceCategorie cat) => switch (cat) {
      AnnonceCategorie.telephones => const Color(0xFFD6EBFF),
      AnnonceCategorie.mode       => const Color(0xFFFFDDE9),
      AnnonceCategorie.hightech   => const Color(0xFFD4F0FC),
      AnnonceCategorie.auto       => const Color(0xFFFFF0C2),
      AnnonceCategorie.maison     => const Color(0xFFD9F2DD),
      AnnonceCategorie.beaute     => const Color(0xFFF0DCF9),
      AnnonceCategorie.sport      => const Color(0xFFD6F5E3),
      AnnonceCategorie.livres     => const Color(0xFFFFEBCC),
    };
