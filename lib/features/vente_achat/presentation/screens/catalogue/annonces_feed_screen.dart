import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../theme/va_theme.dart';
import '../../../domain/export.dart';
import '../compte/filtres_screen.dart';
import 'annonce_detail_screen.dart';

// ═══════════════════════════════════════════════════════════════════════════
//  FEED CATÉGORIE — masonry style Pinterest
// ═══════════════════════════════════════════════════════════════════════════

@RoutePage()
class AnnoncesFeedScreen extends StatefulWidget {
  final AnnonceCategorie? categorie;
  const AnnoncesFeedScreen({super.key, this.categorie});

  @override
  State<AnnoncesFeedScreen> createState() => _AnnoncesFeedScreenState();
}

class _AnnoncesFeedScreenState extends State<AnnoncesFeedScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _filterIndex = 0;

  static const _tabs         = ['Tout', 'Près de moi', 'Récent'];
  static const _filterLabels = ['Filtres', 'Prix ↓', 'État', 'Marque'];
  static const _imgH = [148.0, 110.0, 132.0, 118.0, 144.0, 106.0, 136.0, 120.0];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Annonce> get _annonces => widget.categorie == null
      ? AnnoncesMock.all
      : AnnoncesMock.all
          .where((a) => a.categorie == widget.categorie)
          .toList();

  void _openFilters() => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => const FiltresScreen(),
      );

  @override
  Widget build(BuildContext context) {
    final annonces = _annonces;
    final title    = widget.categorie?.label ?? 'Toutes les annonces';

    // Répartition masonry : colonnes gauche / droite
    final left  = <(Annonce, double)>[];
    final right = <(Annonce, double)>[];
    for (int i = 0; i < annonces.length; i++) {
      final h = _imgH[i % _imgH.length];
      if (i.isEven) left.add((annonces[i], h));
      else          right.add((annonces[i], h));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [

          // ── AppBar ─────────────────────────────────────────────────────
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            scrolledUnderElevation: 0.5,
            shadowColor: const Color(0x12000000),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  size: 18, color: VAColors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: VAColors.black),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.search_rounded,
                    size: 22, color: VAColors.black),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.tune_rounded,
                    size: 20, color: VAColors.black),
                onPressed: _openFilters,
              ),
            ],
            // TabBar épinglée sous l'AppBar
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: _FeedTabBar(controller: _tabController),
            ),
          ),

          // ── Filtres rapides ─────────────────────────────────────────────
          SliverToBoxAdapter(
            child: _FilterChips(
              labels: _filterLabels,
              selectedIndex: _filterIndex,
              onSelected: (i) {
                setState(() => _filterIndex = i);
                if (i == 0) _openFilters();
              },
            ),
          ),

          // ── Résultat count ──────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                      fontSize: 12, color: VAColors.greyText),
                  children: [
                    TextSpan(
                        text: '${annonces.length} résultat${annonces.length > 1 ? 's' : ''}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: VAColors.black)),
                    const TextSpan(text: '  ·  triés par pertinence'),
                  ],
                ),
              ),
            ),
          ),

          // ── Masonry grid ────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 6, 12, 32),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Colonne gauche
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (final item in left)
                          _FeedCard(annonce: item.$1, imgHeight: item.$2),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Colonne droite décalée (effet Pinterest)
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),
                        for (final item in right)
                          _FeedCard(annonce: item.$1, imgHeight: item.$2),
                      ],
                    ),
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

// ═══════════════════════════════════════════════════════════════════════════
//  CARTE MASONRY — identique au _PinCard de la home
// ═══════════════════════════════════════════════════════════════════════════

class _FeedCard extends StatefulWidget {
  final Annonce annonce;
  final double imgHeight;
  const _FeedCard({required this.annonce, required this.imgHeight});

  @override
  State<_FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<_FeedCard> {
  bool _fav = false;

  static const _catColors = {
    AnnonceCategorie.telephones: Color(0xFFD6EBFF),
    AnnonceCategorie.mode:       Color(0xFFFFDDE9),
    AnnonceCategorie.maison:     Color(0xFFD9F2DD),
    AnnonceCategorie.auto:       Color(0xFFFFF0C2),
    AnnonceCategorie.beaute:     Color(0xFFF0DCF9),
    AnnonceCategorie.hightech:   Color(0xFFD4F0FC),
    AnnonceCategorie.sport:      Color(0xFFD6F5E3),
    AnnonceCategorie.livres:     Color(0xFFFFEBCC),
  };

  Color get _bg => _catColors[widget.annonce.categorie] ?? VAColors.primaryLight;

  @override
  Widget build(BuildContext context) {
    final ann = widget.annonce;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => AnnonceDetailScreen(annonce: ann)),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
                color: Color(0x0C000000),
                blurRadius: 10,
                offset: Offset(0, 3))
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            // ── Image / placeholder ───────────────────────────────────────
            Stack(
              children: [
                Container(
                  height: widget.imgHeight,
                  width: double.infinity,
                  color: _bg,
                  child: Icon(
                    _categoryIcon(ann.categorie),
                    size: widget.imgHeight * 0.30,
                    color: _bg.withValues(alpha: 1)
                        .withRed((_bg.r * 0.55).toInt())
                        .withGreen((_bg.g * 0.55).toInt())
                        .withBlue((_bg.b * 0.55).toInt()),
                  ),
                ),

                // Badge remise
                if (ann.remisePourcent != null)
                  Positioned(
                    top: 7, left: 7,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                          color: VAColors.red,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text('-${ann.remisePourcent}%',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w800)),
                    ),
                  )
                else if (ann.isPro)
                  Positioned(
                    top: 7, left: 7,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                          color: VAColors.primary,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text('Pro',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),

                // Favori
                Positioned(
                  top: 6, right: 6,
                  child: GestureDetector(
                    onTap: () => setState(() => _fav = !_fav),
                    child: Container(
                      width: 27, height: 27,
                      decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.92),
                          shape: BoxShape.circle),
                      child: Icon(
                        _fav ? Icons.favorite : Icons.favorite_border,
                        size: 14,
                        color: _fav ? VAColors.red : VAColors.grey,
                      ),
                    ),
                  ),
                ),

                // Prix overlay
                Positioned(
                  bottom: 7, left: 7,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.52),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(ann.prixFormate,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w800)),
                  ),
                ),
              ],
            ),

            // ── Infos texte ───────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(9, 7, 9, 9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(ann.titre,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: VAColors.black,
                          height: 1.3),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  if (ann.ancienPrix != null) ...[
                    const SizedBox(height: 3),
                    Row(children: [
                      Text(ann.ancienPrixFormate!,
                          style: const TextStyle(
                              fontSize: 10,
                              color: VAColors.grey,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: VAColors.grey)),
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                            color: VAColors.redLight,
                            borderRadius: BorderRadius.circular(4)),
                        child: Text('-${ann.remisePourcent}%',
                            style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                color: VAColors.red)),
                      ),
                    ]),
                  ],
                  const SizedBox(height: 5),
                  Row(children: [
                    Container(
                      width: 16, height: 16,
                      decoration: BoxDecoration(
                          color: _bg.withValues(alpha: 0.8),
                          shape: BoxShape.circle),
                      child: Center(
                        child: Text(
                          ann.vendeur.initiales.isNotEmpty
                              ? ann.vendeur.initiales[0]
                              : '?',
                          style: const TextStyle(
                              fontSize: 8, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        ann.vendeur.nom,
                        style: const TextStyle(
                            fontSize: 10, color: VAColors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),
                  const SizedBox(height: 3),
                  Row(children: [
                    const Icon(Icons.location_on_outlined,
                        size: 10, color: VAColors.grey),
                    const SizedBox(width: 2),
                    Text(ann.localisation,
                        style: const TextStyle(
                            fontSize: 10, color: VAColors.grey)),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static IconData _categoryIcon(AnnonceCategorie cat) => switch (cat) {
        AnnonceCategorie.telephones => Icons.phone_android_outlined,
        AnnonceCategorie.mode       => Icons.checkroom_outlined,
        AnnonceCategorie.maison     => Icons.home_outlined,
        AnnonceCategorie.auto       => Icons.directions_car_outlined,
        AnnonceCategorie.beaute     => Icons.face_outlined,
        AnnonceCategorie.hightech   => Icons.computer_outlined,
        AnnonceCategorie.sport      => Icons.sports_soccer_outlined,
        AnnonceCategorie.livres     => Icons.menu_book_outlined,
      };
}

// ═══════════════════════════════════════════════════════════════════════════
//  COMPOSANTS
// ═══════════════════════════════════════════════════════════════════════════

class _FeedTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController controller;
  const _FeedTabBar({required this.controller});

  static const _tabs = ['Tout', 'Près de moi', 'Récent'];

  @override
  Size get preferredSize => const Size.fromHeight(46);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      tabAlignment: TabAlignment.fill,
      labelStyle: const TextStyle(
          fontSize: 13, fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(
          fontSize: 13, fontWeight: FontWeight.w500),
      labelColor: VAColors.primary,
      unselectedLabelColor: VAColors.greyText,
      indicatorColor: VAColors.primary,
      indicatorWeight: 2,
      dividerColor: const Color(0xFFF0F0F0),
      tabs: _tabs.map((t) => Tab(text: t)).toList(),
    );
  }
}

class _FilterChips extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  const _FilterChips(
      {required this.labels,
      required this.selectedIndex,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(14, 8, 14, 6),
        itemCount: labels.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final sel = i == selectedIndex;
          return GestureDetector(
            onTap: () => onSelected(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
              decoration: BoxDecoration(
                color: sel ? VAColors.primaryLight : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: sel ? VAColors.primary : const Color(0xFFE8E4DE),
                  width: sel ? 1.5 : 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (i == 0) ...[
                    Icon(Icons.tune_rounded,
                        size: 13,
                        color: sel ? VAColors.primary : VAColors.grey),
                    const SizedBox(width: 5),
                  ],
                  Text(labels[i],
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight:
                              sel ? FontWeight.w700 : FontWeight.w500,
                          color: sel
                              ? VAColors.primaryDark
                              : VAColors.greyText)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
