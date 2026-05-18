import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/va_theme.dart';
import '../../core/widgets/export.dart';
import '../../models/export.dart';
import '../lot2/offre_sure_screen.dart';
import 'annonces_feed_screen.dart';

// Hauteurs d'image pour l'effet staggeré (identique à l'écran Acheter)
const _dImgH = [146.0, 108.0, 128.0, 116.0, 142.0, 104.0, 134.0, 118.0];

// ─── Couleur de fond par catégorie ───────────────────────────────────────────

Color _bgColor(AnnonceCategorie c) => switch (c) {
      AnnonceCategorie.telephones => const Color(0xFFD6EBFF),
      AnnonceCategorie.mode       => const Color(0xFFFFDDE9),
      AnnonceCategorie.hightech   => const Color(0xFFD4F0FC),
      AnnonceCategorie.auto       => const Color(0xFFFFF0C2),
      AnnonceCategorie.maison     => const Color(0xFFD9F2DD),
      AnnonceCategorie.beaute     => const Color(0xFFF0DCF9),
      AnnonceCategorie.sport      => const Color(0xFFD6F5E3),
      AnnonceCategorie.livres     => const Color(0xFFFFEBCC),
    };

// ─── Écran principal ─────────────────────────────────────────────────────────

@RoutePage()
class AnnonceDetailScreen extends StatefulWidget {
  final Annonce annonce;
  const AnnonceDetailScreen({super.key, required this.annonce});

  @override
  State<AnnonceDetailScreen> createState() => _AnnonceDetailScreenState();
}

class _AnnonceDetailScreenState extends State<AnnonceDetailScreen> {
  int  _page  = 0;
  bool _isFav = false;
  bool _descExpanded = false;

  Annonce get a => widget.annonce;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    final similar = AnnoncesMock.all
        .where((x) => x.categorie == a.categorie && x.id != a.id)
        .toList();
    final related = AnnoncesMock.all
        .where((x) => x.categorie != a.categorie && x.id != a.id)
        .take(8)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3EF),
      body: CustomScrollView(
        slivers: [
          // ── Carrousel image ────────────────────────────────────────────
          SliverToBoxAdapter(
            child: _ImageCarousel(
              annonce: a,
              currentPage: _page,
              isFav: _isFav,
              onPageChanged: (i) => setState(() => _page = i),
              onFavTap: () => setState(() => _isFav = !_isFav),
            ),
          ),

          // ── Prix + titre + méta ────────────────────────────────────────
          SliverToBoxAdapter(child: _InfoSection(annonce: a)),

          // ── Bannière offre sûre ────────────────────────────────────────
          const SliverToBoxAdapter(child: _TrustBanner()),

          // ── Vendeur ────────────────────────────────────────────────────
          SliverToBoxAdapter(child: _SellerSection(vendeur: a.vendeur)),

          // ── Détails + description ──────────────────────────────────────
          SliverToBoxAdapter(
            child: _DetailsSection(
              annonce: a,
              expanded: _descExpanded,
              onToggle: () => setState(() => _descExpanded = !_descExpanded),
            ),
          ),

          // ── Produits du même vendeur ───────────────────────────────────
          if (similar.isNotEmpty)
            SliverToBoxAdapter(
              child: _ProductHScroll(
                title: 'Du même vendeur',
                annonces: similar,
              ),
            ),

          // ── Articles similaires ────────────────────────────────────────
          SliverToBoxAdapter(
            child: _ProductHScroll(
              title: 'Articles similaires',
              badge: 'Même catégorie',
              annonces: List.generate(6, (i) =>
                  AnnoncesMock.all.where((x) => x.categorie == a.categorie)
                      .toList()[i % AnnoncesMock.all.where((x) => x.categorie == a.categorie).length.clamp(1, 999)]),
            ),
          ),

          // ── Cela pourrait vous intéresser ──────────────────────────────
          if (related.isNotEmpty)
            SliverToBoxAdapter(
              child: _ProductHScroll(
                title: 'Cela pourrait vous intéresser',
                annonces: List.generate(8, (i) => related[i % related.length]),
              ),
            ),

          // ── Mêmes sections que l'écran Acheter ────────────────────────
          SliverToBoxAdapter(
            child: _DetailMasonryFeed(
              annonces: AnnoncesMock.all,
              excludeId: a.id,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 110)),
        ],
      ),
      bottomNavigationBar: _BottomBar(annonce: a),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  CARROUSEL IMAGE
// ═══════════════════════════════════════════════════════════════════════════

class _ImageCarousel extends StatelessWidget {
  final Annonce annonce;
  final int currentPage;
  final bool isFav;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onFavTap;

  static const int _pageCount = 4;

  const _ImageCarousel({
    required this.annonce,
    required this.currentPage,
    required this.isFav,
    required this.onPageChanged,
    required this.onFavTap,
  });

  @override
  Widget build(BuildContext context) {
    final base = _bgColor(annonce.categorie);
    final top  = MediaQuery.of(context).padding.top;

    return SizedBox(
      height: 320,
      child: Stack(
        children: [
          // ── PageView ─────────────────────────────────────────────────
          PageView.builder(
            itemCount: _pageCount,
            onPageChanged: onPageChanged,
            itemBuilder: (_, i) {
              final hsl = HSLColor.fromColor(base);
              final light = (hsl.lightness + i * 0.06).clamp(0.0, 1.0);
              return Container(
                color: hsl.withLightness(light).toColor(),
                child: Center(
                  child: Text(
                    annonce.categorie.emoji,
                    style: TextStyle(fontSize: 110 - i * 8),
                  ),
                ),
              );
            },
          ),

          // ── Bouton retour ────────────────────────────────────────────
          Positioned(
            top: top + 10,
            left: 14,
            child: _CircleBtn(
              icon: Icons.chevron_left_rounded,
              onTap: () => Navigator.of(context).pop(),
            ),
          ),

          // ── Favori + partage ─────────────────────────────────────────
          Positioned(
            top: top + 10,
            right: 14,
            child: Row(
              children: [
                _CircleBtn(
                  icon: isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? VAColors.red : VAColors.black,
                  onTap: onFavTap,
                ),
                const SizedBox(width: 8),
                _CircleBtn(icon: Icons.share_outlined, onTap: () {}),
              ],
            ),
          ),

          // ── Badge remise ─────────────────────────────────────────────
          if (annonce.remisePourcent != null)
            Positioned(
              top: top + 10,
              left: 60,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: VAColors.red, borderRadius: BorderRadius.circular(20)),
                child: Text(
                  '-${annonce.remisePourcent}%',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12),
                ),
              ),
            ),

          // ── Indicateur dots ──────────────────────────────────────────
          Positioned(
            bottom: 14,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pageCount, (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: i == currentPage ? 18 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: i == currentPage ? VAColors.primary : Colors.black26,
                  borderRadius: BorderRadius.circular(3),
                ),
              )),
            ),
          ),

          // ── Compteur pages ───────────────────────────────────────────
          Positioned(
            bottom: 14,
            right: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(12)),
              child: Text(
                '${currentPage + 1} / $_pageCount',
                style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _CircleBtn({required this.icon, this.color = VAColors.black, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Color(0x18000000), blurRadius: 8, offset: Offset(0, 2))],
          ),
          child: Icon(icon, size: 20, color: color),
        ),
      );
}

// ═══════════════════════════════════════════════════════════════════════════
//  INFO — prix, titre, méta
// ═══════════════════════════════════════════════════════════════════════════

class _InfoSection extends StatelessWidget {
  final Annonce annonce;
  const _InfoSection({required this.annonce});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Badge état (ligne seule, pas de compétition horizontale) ───
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: VAColors.greenLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Nouveau neuf',
              style: TextStyle(color: VAColors.green, fontSize: 11, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 8),

          // ── Prix + ancienPrix + badge remise ───────────────────────────
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            spacing: 8,
            runSpacing: 4,
            children: [
              Text(
                annonce.prixFormate,
                style: const TextStyle(
                    fontSize: 28, fontWeight: FontWeight.w900, color: VAColors.primary, letterSpacing: -0.5),
              ),
              if (annonce.ancienPrix != null) ...[
                Text(
                  annonce.ancienPrixFormate!,
                  style: const TextStyle(
                    fontSize: 15,
                    color: VAColors.grey,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: VAColors.grey,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                      color: VAColors.redLight, borderRadius: BorderRadius.circular(6)),
                  child: Text(
                    '-${annonce.remisePourcent}%',
                    style: const TextStyle(
                        color: VAColors.red, fontSize: 11, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),

          // ── Titre ───────────────────────────────────────────────────────
          Text(
            annonce.titre,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w800, color: VAColors.black, height: 1.3, letterSpacing: -0.3),
          ),
          const SizedBox(height: 10),

          // ── Méta ────────────────────────────────────────────────────────
          Wrap(
            spacing: 12,
            runSpacing: 4,
            children: [
              _MetaChip(Icons.location_on_outlined, annonce.localisation),
              _MetaChip(Icons.access_time_rounded, annonce.tempsPublication),
              if (annonce.vues > 0)
                _MetaChip(Icons.remove_red_eye_outlined, '${annonce.vues} vues'),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _MetaChip(this.icon, this.label);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: VAColors.grey),
          const SizedBox(width: 3),
          Text(label, style: const TextStyle(fontSize: 12, color: VAColors.grey)),
        ],
      );
}

// ═══════════════════════════════════════════════════════════════════════════
//  BANNIÈRE OFFRE SÛRE
// ═══════════════════════════════════════════════════════════════════════════

class _TrustBanner extends StatelessWidget {
  const _TrustBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F4FD),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFB3D9F5)),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(color: Color(0xFF2196F3), shape: BoxShape.circle),
            child: const Icon(Icons.verified_user_rounded, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Offre sûre sécurisée',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1565C0))),
                Text('Votre paiement est protégé jusqu\'à la réception',
                    style: TextStyle(fontSize: 11, color: Color(0xFF1565C0))),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: Color(0xFF1565C0), size: 18),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  SECTION VENDEUR
// ═══════════════════════════════════════════════════════════════════════════

class _SellerSection extends StatelessWidget {
  final Vendeur vendeur;
  const _SellerSection({required this.vendeur});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: VAColors.greyBorder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Identité vendeur ─────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                VAAvatarVendeur(vendeur: vendeur, size: 52, bgColor: VAColors.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(vendeur.nom,
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: VAColors.black)),
                          const SizedBox(width: 6),
                          if (vendeur.isPro) const VAProBadge(),
                          if (vendeur.isVerifie) ...[
                            const SizedBox(width: 4),
                            const Icon(Icons.verified, color: VAColors.blue, size: 14),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, color: VAColors.star, size: 13),
                          Text(' ${vendeur.note}', style: const TextStyle(fontSize: 12, color: VAColors.greyText)),
                          Text(' · ${vendeur.ventes} évaluations',
                              style: const TextStyle(fontSize: 12, color: VAColors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, color: VAColors.grey),
              ],
            ),
          ),

          // ── Stats ────────────────────────────────────────────────────
          Container(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: VAColors.greyBorder)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatCol('${vendeur.produits ?? vendeur.ventes}', 'articles'),
                _VDivider(),
                _StatCol('${vendeur.ventes * 8}', 'livraisons'),
                _VDivider(),
                _StatCol(_formatK(vendeur.abonnes ?? vendeur.ventes * 10), 'abonnés'),
              ],
            ),
          ),

          // ── Bouton boutique ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 11),
                decoration: BoxDecoration(
                  color: VAColors.greyLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.storefront_outlined, size: 16, color: VAColors.black),
                    SizedBox(width: 6),
                    Text('Voir la boutique', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: VAColors.black)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatK(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return '$n';
  }
}

class _StatCol extends StatelessWidget {
  final String value;
  final String label;
  const _StatCol(this.value, this.label);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: VAColors.black)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 11, color: VAColors.grey)),
        ],
      );
}

class _VDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 32, color: VAColors.greyBorder);
}

// ═══════════════════════════════════════════════════════════════════════════
//  DÉTAILS + DESCRIPTION
// ═══════════════════════════════════════════════════════════════════════════

class _DetailsSection extends StatelessWidget {
  final Annonce annonce;
  final bool expanded;
  final VoidCallback onToggle;
  const _DetailsSection({required this.annonce, required this.expanded, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final desc = annonce.description;
    final isLong = desc.length > 120;
    final shown = expanded || !isLong ? desc : '${desc.substring(0, 120)}...';

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: VAColors.greyBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Détails', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: VAColors.black)),
          const SizedBox(height: 10),
          // Condition row
          _DetailRow('État', 'Nouveau neuf'),
          _DetailRow('Catégorie', annonce.categorie.label),
          _DetailRow('Localisation', annonce.localisation),
          const Divider(height: 20, color: VAColors.greyBorder),
          // Description
          const Text('Description', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: VAColors.black)),
          const SizedBox(height: 6),
          Text(shown, style: const TextStyle(fontSize: 13, color: VAColors.greyText, height: 1.55)),
          if (isLong) ...[
            const SizedBox(height: 6),
            GestureDetector(
              onTap: onToggle,
              child: Text(
                expanded ? 'Voir moins ▲' : 'Voir plus ▼',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: VAColors.primary),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(label, style: const TextStyle(fontSize: 12, color: VAColors.grey)),
            ),
            Expanded(
              child: Text(value,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: VAColors.black)),
            ),
          ],
        ),
      );
}

// ═══════════════════════════════════════════════════════════════════════════
//  SCROLL HORIZONTAL DE PRODUITS (réutilisable)
// ═══════════════════════════════════════════════════════════════════════════

class _ProductHScroll extends StatelessWidget {
  final String title;
  final String? badge;
  final List<Annonce> annonces;
  const _ProductHScroll({required this.title, required this.annonces, this.badge});

  @override
  Widget build(BuildContext context) {
    if (annonces.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
          child: Row(
            children: [
              Text(title,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: VAColors.black)),
              if (badge != null) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(color: VAColors.primaryLight, borderRadius: BorderRadius.circular(20)),
                  child: Text(badge!,
                      style: const TextStyle(color: VAColors.primaryDark, fontSize: 10, fontWeight: FontWeight.w700)),
                ),
              ],
            ],
          ),
        ),
        SizedBox(
          height: 190,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: annonces.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (_, i) => _MiniCard(
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

class _MiniCard extends StatefulWidget {
  final Annonce annonce;
  final VoidCallback onTap;
  const _MiniCard({required this.annonce, required this.onTap});

  @override
  State<_MiniCard> createState() => _MiniCardState();
}

class _MiniCardState extends State<_MiniCard> {
  bool _fav = false;

  @override
  Widget build(BuildContext context) {
    final bg = _bgColor(widget.annonce.categorie);
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 3))],
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  height: 116,
                  width: double.infinity,
                  color: bg,
                  child: Center(
                    child: Text(widget.annonce.categorie.emoji,
                        style: const TextStyle(fontSize: 44)),
                  ),
                ),
                if (widget.annonce.remisePourcent != null)
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(color: VAColors.red, borderRadius: BorderRadius.circular(20)),
                      child: Text('-${widget.annonce.remisePourcent}%',
                          style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800)),
                    ),
                  ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () => setState(() => _fav = !_fav),
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: Icon(_fav ? Icons.favorite : Icons.favorite_border,
                          size: 14, color: _fav ? VAColors.red : VAColors.grey),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 6,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(20)),
                    child: Text(widget.annonce.prixFormate,
                        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(widget.annonce.titre,
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: VAColors.black, height: 1.3),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    if (widget.annonce.ancienPrix != null)
                      Text(widget.annonce.ancienPrixFormate!,
                          style: const TextStyle(fontSize: 9, color: VAColors.grey,
                              decoration: TextDecoration.lineThrough, decorationColor: VAColors.grey)),
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

// ═══════════════════════════════════════════════════════════════════════════
//  BOTTOM BAR — Ajouter panier + Acheter
// ═══════════════════════════════════════════════════════════════════════════

// ═══════════════════════════════════════════════════════════════════════════
//  CATÉGORIES (scroll horizontal — mêmes que l'écran Acheter)
// ═══════════════════════════════════════════════════════════════════════════

// ═══════════════════════════════════════════════════════════════════════════
//  MASONRY THÉMATIQUE — mêmes sections que l'écran Acheter
// ═══════════════════════════════════════════════════════════════════════════

class _DetailMasonryFeed extends StatelessWidget {
  final List<Annonce> annonces;
  final String excludeId;
  const _DetailMasonryFeed({required this.annonces, required this.excludeId});

  List<Annonce> _pick({List<AnnonceCategorie>? cats, double? maxPrix,
      bool proOnly = false, bool remiseOnly = false, bool recentFirst = false}) {
    var r = annonces.where((a) {
      if (a.id == excludeId) return false;
      if (cats != null && !cats.contains(a.categorie)) return false;
      if (maxPrix != null && a.prix > maxPrix) return false;
      if (proOnly && !a.isPro) return false;
      if (remiseOnly && a.ancienPrix == null) return false;
      return true;
    }).toList();
    if (recentFirst) r.sort((a, b) => b.datePublication.compareTo(a.datePublication));
    if (r.isEmpty) r = annonces.where((a) => a.id != excludeId).toList();
    if (r.isEmpty) r = annonces;
    return List.generate(6, (i) => r[i % r.length]);
  }

  @override
  Widget build(BuildContext context) {
    final sections = [
      (icon: '📱', title: 'Téléphones & Tech',    items: _pick(cats: [AnnonceCategorie.telephones, AnnonceCategorie.hightech])),
      (icon: '💰', title: 'Petits prix du moment', items: _pick(maxPrix: 150000)),
      (icon: '👜', title: 'Mode & Style',           items: _pick(cats: [AnnonceCategorie.mode, AnnonceCategorie.beaute])),
      (icon: '⭐', title: 'Bonnes affaires',        items: _pick(remiseOnly: true)),
      (icon: '🏠', title: 'Maison & Auto',          items: _pick(cats: [AnnonceCategorie.maison, AnnonceCategorie.auto])),
      (icon: '🆕', title: 'Derniers arrivages',     items: _pick(recentFirst: true)),
      (icon: '✅', title: 'Vendeurs certifiés',     items: _pick(proOnly: true)),
      (icon: '⚽', title: 'Sport & Loisirs',        items: _pick(cats: [AnnonceCategorie.sport, AnnonceCategorie.livres])),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int s = 0; s < sections.length; s++) ...[
          _DSectionTitle(icon: sections[s].icon, title: sections[s].title),
          _DStaggeredGrid(annonces: sections[s].items, sectionIdx: s),
        ],
      ],
    );
  }
}

class _DSectionTitle extends StatelessWidget {
  final String icon, title;
  const _DSectionTitle({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) => Padding(
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

class _DStaggeredGrid extends StatelessWidget {
  final List<Annonce> annonces;
  final int sectionIdx;
  const _DStaggeredGrid({required this.annonces, required this.sectionIdx});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(6, (i) {
      final ann = annonces[(i + sectionIdx * 2) % annonces.length];
      final hIdx = (i + sectionIdx * 3) % _dImgH.length;
      return (ann, _dImgH[hIdx]);
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
          Expanded(child: Column(mainAxisSize: MainAxisSize.min,
            children: [for (int i = 0; i < left.length; i++)
              _DPinCard(annonce: left[i].$1, imgHeight: left[i].$2)])),
          const SizedBox(width: 8),
          Expanded(child: Column(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(height: offset),
            for (int i = 0; i < right.length; i++)
              _DPinCard(annonce: right[i].$1, imgHeight: right[i].$2),
          ])),
        ],
      ),
    );
  }
}

class _DPinCard extends StatefulWidget {
  final Annonce annonce;
  final double imgHeight;
  const _DPinCard({required this.annonce, required this.imgHeight});

  @override
  State<_DPinCard> createState() => _DPinCardState();
}

class _DPinCardState extends State<_DPinCard> {
  bool _fav = false;

  Color get _bg => _bgColor(widget.annonce.categorie);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => AnnonceDetailScreen(annonce: widget.annonce)),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14),
            boxShadow: const [BoxShadow(color: Color(0x0C000000), blurRadius: 10, offset: Offset(0, 3))]),
        clipBehavior: Clip.hardEdge,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,
          children: [
            Stack(children: [
              Container(height: widget.imgHeight, width: double.infinity, color: _bg,
                child: Center(child: Text(widget.annonce.categorie.emoji,
                    style: TextStyle(fontSize: widget.imgHeight * 0.28)))),
              if (widget.annonce.remisePourcent != null)
                Positioned(top: 7, left: 7, child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(color: VAColors.red, borderRadius: BorderRadius.circular(20)),
                  child: Text('-${widget.annonce.remisePourcent}%',
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800))))
              else if (widget.annonce.isPro)
                Positioned(top: 7, left: 7, child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(color: VAColors.primary, borderRadius: BorderRadius.circular(20)),
                  child: const Text('✓ Pro',
                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)))),
              Positioned(top: 6, right: 6, child: GestureDetector(
                onTap: () => setState(() => _fav = !_fav),
                child: Container(width: 27, height: 27,
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.92), shape: BoxShape.circle),
                  child: Icon(_fav ? Icons.favorite : Icons.favorite_border,
                      size: 14, color: _fav ? VAColors.red : VAColors.grey)))),
              Positioned(bottom: 7, left: 7, child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.52),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(widget.annonce.prixFormate,
                    style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)))),
            ]),
            Padding(padding: const EdgeInsets.fromLTRB(9, 7, 9, 9),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,
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
                            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: VAColors.red))),
                    ]),
                  ],
                  const SizedBox(height: 5),
                  Row(children: [
                    Container(width: 16, height: 16,
                      decoration: BoxDecoration(color: _bg.withValues(alpha: 0.8), shape: BoxShape.circle),
                      child: Center(child: Text(widget.annonce.vendeur.initiales[0],
                          style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w800, color: VAColors.greyText)))),
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
                ])),
          ]),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final Annonce annonce;
  const _BottomBar({required this.annonce});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
      color: const Color(0xFFF5F3EF),
      child: Row(
        children: [
          // ── Ajouter au panier ────────────────────────────────────────
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: VAColors.primary, width: 1.5),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart_outlined, color: VAColors.primary, size: 18),
                    SizedBox(width: 7),
                    Text('Ajouter au panier',
                        style: TextStyle(color: VAColors.primary, fontWeight: FontWeight.w700, fontSize: 13)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // ── Acheter ──────────────────────────────────────────────────
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => OffreSureScreen(annonce: annonce)),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: VAColors.primary,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: VAColors.primary.withValues(alpha: 0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.flash_on_rounded, color: Colors.white, size: 18),
                    SizedBox(width: 6),
                    Text('Acheter',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
