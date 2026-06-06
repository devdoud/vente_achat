import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/injection/injection.dart';
import '../../theme/va_theme.dart';
import '../../utils/cat_helpers.dart';
import '../../../domain/export.dart';
import '../../../data/mappers/product_mapper.dart';
import '../../../logic/export.dart';
import 'annonce_detail_screen.dart';
import 'annonces_feed_screen.dart';
import 'search_screen.dart';
import '../compte/filtres_screen.dart';
import '../compte/profil_screen.dart';
import '../transaction/cart_screen.dart';

const _imgH = [146.0, 108.0, 128.0, 116.0, 142.0, 104.0, 134.0, 118.0];

// ─── Écran principal ─────────────────────────────────────────────────────────

@RoutePage()
class VAHomeScreen extends StatelessWidget {
  const VAHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ProductCubit>()..loadProducts()),
        BlocProvider(create: (_) => getIt<CategoryCubit>()..load()),
      ],
      child: const _HomeBody(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (ctx, catState) {
        final catMap = catState is CategoryLoaded
            ? buildCategoryMap(catState.categories)
            : <String, AnnonceCategorie>{};

        return BlocBuilder<ProductCubit, ProductState>(
          builder: (ctx, productState) {
            final List<Annonce> annonces;
            final bool isLoading;

            if (productState is ProductLoaded) {
              annonces = productState.products
                  .map((p) => productToAnnonce(p, catMap: catMap))
                  .toList();
              isLoading = false;
            } else if (productState is ProductLoading) {
              annonces = [];
              isLoading = true;
            } else {
              annonces = [];
              isLoading = false;
            }

            final apiCategories = catState is CategoryLoaded
                ? catState.categories
                : <Category>[];

            return Scaffold(
              backgroundColor: Colors.white,
              body: RefreshIndicator(
                color: VAColors.primary,
                onRefresh: () async {
                  ctx.read<ProductCubit>().loadProducts();
                  ctx.read<CategoryCubit>().load();
                  // Attendre que l'état passe en loading puis en loaded
                  await Future.delayed(const Duration(milliseconds: 800));
                },
                child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
                slivers: [
                  SliverSafeArea(
                    bottom: false,
                    sliver: SliverToBoxAdapter(child: _Header(isLoading: isLoading)),
                  ),
                  const SliverToBoxAdapter(child: _SearchBar()),
                  SliverToBoxAdapter(
                    child: _CategoriesSection(
                      categories: apiCategories,
                      catMap: catMap,
                    ),
                  ),
                  const SliverToBoxAdapter(child: _TrustStrip()),
                  if (isLoading)
                    const SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(color: VAColors.primary, strokeWidth: 2),
                            SizedBox(height: 16),
                            Text('Chargement des annonces...',
                                style: VATextStyles.caption),
                          ],
                        ),
                      ),
                    )
                  else ...[
                    SliverToBoxAdapter(child: _SpotlightSection(annonces: annonces)),
                    SliverToBoxAdapter(child: _InfiniteMasonryFeed(annonces: annonces)),
                    const SliverToBoxAdapter(child: SizedBox(height: 32)),
                  ],
                ],
              ),
              ), // CustomScrollView
            );  // Scaffold
          },
        );
      },
    );
  }
}

// ─── HEADER ──────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  final bool isLoading;
  const _Header({required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
      child: Row(
        children: [
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
          if (isLoading)
            const SizedBox(
              width: 16, height: 16,
              child: CircularProgressIndicator(strokeWidth: 2, color: VAColors.primary),
            )
          else ...[
            _UserIconButton(),
            const SizedBox(width: 6),
            _CartIconButton(),
            const SizedBox(width: 8),
            _LocationChip(),
          ],
        ],
      ),
    );
  }
}

class _CartIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (ctx, state) {
        final count = state is CartLoaded ? state.cart.itemCount : 0;
        return GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const CartScreen()),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 38, height: 38,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(19),
                  boxShadow: const [BoxShadow(
                      color: Color(0x10000000), blurRadius: 8, offset: Offset(0, 2))],
                ),
                child: const Icon(Icons.shopping_cart_outlined,
                    size: 19, color: VAColors.black),
              ),
              if (count > 0)
                Positioned(
                  top: -3, right: -3,
                  child: Container(
                    width: 17, height: 17,
                    decoration: const BoxDecoration(
                        color: VAColors.primary, shape: BoxShape.circle),
                    child: Center(
                      child: Text('$count',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800)),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _UserIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const ProfilScreen()),
      ),
      child: Container(
        width: 38, height: 38,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(19),
          boxShadow: const [BoxShadow(
              color: Color(0x10000000), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: const Icon(Icons.person_outline_rounded,
            size: 20, color: VAColors.black),
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [BoxShadow(color: Color(0x10000000), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_on_rounded, color: VAColors.primary, size: 16),
            SizedBox(width: 2),
            Icon(Icons.keyboard_arrow_down_rounded, size: 14, color: VAColors.grey),
          ],
        ),
      ),
    );
  }
}

// ─── SEARCH ───────────────────────────────────────────────────────────────────

class _SearchBar extends StatelessWidget {
  const _SearchBar();

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

// ─── TRUST STRIP ──────────────────────────────────────────────────────────────

class _TrustStrip extends StatelessWidget {
  const _TrustStrip();

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
                child: Text(e.$2,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: VAColors.primaryDark),
                  maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        )).toList(),
      ),
    );
  }
}

// ─── SPOTLIGHT ────────────────────────────────────────────────────────────────

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
              const Text('À ne pas rater',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: VAColors.black, letterSpacing: -0.3)),
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
            // Image réelle si disponible, sinon placeholder coloré
            _buildSpotlightImage(widget.annonce, _bg),
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
            if (widget.annonce.remisePourcent != null)
              Positioned(top: 9, left: 9,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: VAColors.red, borderRadius: BorderRadius.circular(20)),
                  child: Text('-${widget.annonce.remisePourcent}%',
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800)),
                ))
            else if (widget.annonce.isPro)
              Positioned(top: 9, left: 9,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: VAColors.primary, borderRadius: BorderRadius.circular(20)),
                  child: const Text('Pro', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                )),
            Positioned(top: 7, right: 7,
              child: GestureDetector(
                onTap: () => setState(() => _fav = !_fav),
                child: Container(
                  width: 28, height: 28,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9), shape: BoxShape.circle),
                  child: Icon(_fav ? Icons.favorite : Icons.favorite_border,
                      size: 15, color: _fav ? VAColors.red : VAColors.grey),
                ),
              )),
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(widget.annonce.titre,
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700, height: 1.25),
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 5),
                    Row(children: [
                      Text(widget.annonce.prixFormate,
                          style: const TextStyle(color: VAColors.primary, fontSize: 13, fontWeight: FontWeight.w800)),
                      const Spacer(),
                      const Icon(Icons.location_on_outlined, size: 10, color: Colors.white54),
                      const SizedBox(width: 2),
                      Flexible(child: Text(widget.annonce.localisation,
                          style: const TextStyle(color: Colors.white54, fontSize: 9),
                          maxLines: 1, overflow: TextOverflow.ellipsis)),
                    ]),
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

// ─── CATEGORIES ───────────────────────────────────────────────────────────────

class _CategoriesSection extends StatelessWidget {
  final List<Category> categories;
  final Map<String, AnnonceCategorie> catMap;

  const _CategoriesSection({
    required this.categories,
    required this.catMap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        children: [
          // Chip "Tout"
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: VAColors.primary,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [BoxShadow(
                  color: VAColors.primary.withValues(alpha: 0.38),
                  blurRadius: 8, offset: const Offset(0, 3),
                )],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.apps_rounded, color: Colors.white, size: 15),
                  SizedBox(width: 6),
                  Text('Tout', style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
                ],
              ),
            ),
          ),

          // Catégories réelles de l'API
          if (categories.isNotEmpty)
            for (final cat in categories)
              _CategoryChip(
                category:   cat,
                annonceCat: catMap[cat.uuid] ?? AnnonceCategorie.telephones,
              )
          else
            // Fallback : skeleton chips gris pendant le chargement
            for (int i = 0; i < 5; i++)
              Container(
                margin: const EdgeInsets.only(right: 8),
                width: 90, height: 30,
                decoration: BoxDecoration(
                  color: VAColors.greyLight,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final Category         category;
  final AnnonceCategorie annonceCat;

  const _CategoryChip({required this.category, required this.annonceCat});

  @override
  Widget build(BuildContext context) {
    final bg         = catBg(annonceCat);
    final iconColor  = catIconColor(annonceCat);
    final apiIcon    = category.icon;
    final isUrl      = apiIcon != null &&
        (apiIcon.startsWith('http://') || apiIcon.startsWith('https://'));

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => AnnoncesFeedScreen(categorie: annonceCat),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.only(left: 5, right: 13, top: 4, bottom: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            BoxShadow(color: Color(0x12000000), blurRadius: 6, offset: Offset(0, 2))
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 28, height: 28,
              decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
              clipBehavior: Clip.hardEdge,
              child: isUrl
                  ? CachedNetworkImage(
                      imageUrl: apiIcon,
                      width: 28, height: 28,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Icon(
                          catIcon(annonceCat), size: 14, color: iconColor),
                      errorWidget: (_, __, ___) => Icon(
                          catIcon(annonceCat), size: 14, color: iconColor),
                    )
                  : Center(
                      child: Icon(catIcon(annonceCat), size: 14, color: iconColor),
                    ),
            ),
            const SizedBox(width: 7),
            Text(
              category.name,
              style: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w600, color: VAColors.black),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── MASONRY INFINI ───────────────────────────────────────────────────────────

/// Feed multi-sections : chaque produit apparaît une seule fois,
/// réparti en sections thématiques avec titres captivants fixes.
class _InfiniteMasonryFeed extends StatelessWidget {
  final List<Annonce> annonces;
  const _InfiniteMasonryFeed({required this.annonces});

  @override
  Widget build(BuildContext context) {
    if (annonces.isEmpty) return const SizedBox.shrink();

    // ── Titre principal : dérivé du PREMIER produit uniquement (ne grandit pas)
    final firstWord = annonces.first.titre.split(' ').first;
    final mainTitle = '$firstWord & bien plus';

    // ── Sections thématiques (chaque produit dans 1 seule section)
    final sorted  = List<Annonce>.from(annonces);
    final byPrice = List<Annonce>.from(annonces)
      ..sort((a, b) => a.prix.compareTo(b.prix));
    final byRecent = List<Annonce>.from(annonces)
      ..sort((a, b) => b.datePublication.compareTo(a.datePublication));

    // Section 1 : présentation (tous les produits dans l'ordre API)
    // Section 2 : les 6 moins chers (différents produits mis en avant)
    // Section 3 : les plus récents (différents produits)
    final sections = [
      (title: mainTitle,              sub: 'Notre sélection du moment',  items: sorted),
      (title: 'Les petits prix',       sub: 'Le meilleur rapport qualité-prix', items: byPrice),
      (title: 'Derniers arrivages',    sub: 'Tout juste ajoutés',              items: byRecent),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int s = 0; s < sections.length; s++) ...[
          _SectionHeader(
            title: sections[s].title,
            sub:   sections[s].sub,
            topPadding: s == 0 ? 16.0 : 28.0,
          ),
          _MasonryBlock(annonces: sections[s].items),
        ],
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title, sub;
  final double topPadding;
  const _SectionHeader({required this.title, required this.sub, this.topPadding = 28});

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.fromLTRB(16, topPadding, 16, 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.w900,
                    color: VAColors.black, letterSpacing: -0.5, height: 1.15)),
            const SizedBox(height: 2),
            Text(sub, style: VATextStyles.caption),
          ],
        ),
      );
}

class _MasonryBlock extends StatelessWidget {
  final List<Annonce> annonces;
  const _MasonryBlock({required this.annonces});

  @override
  Widget build(BuildContext context) {
    final left  = <(Annonce, double)>[];
    final right = <(Annonce, double)>[];
    for (int i = 0; i < annonces.length; i++) {
      final h = _imgH[i % _imgH.length];
      if (i.isEven) left.add((annonces[i], h));
      else          right.add((annonces[i], h));
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [for (final e in left) _PinCard(annonce: e.$1, imgHeight: e.$2)],
          )),
          const SizedBox(width: 8),
          Expanded(child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 22),
              for (final e in right) _PinCard(annonce: e.$1, imgHeight: e.$2),
            ],
          )),
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
            Stack(children: [
              _buildProductImage(widget.annonce, widget.imgHeight, bg),
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
                    child: const Text('Pro', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                  )),
              Positioned(top: 6, right: 6,
                child: GestureDetector(
                  onTap: () => setState(() => _fav = !_fav),
                  child: Container(
                    width: 27, height: 27,
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.92), shape: BoxShape.circle),
                    child: Icon(_fav ? Icons.favorite : Icons.favorite_border,
                        size: 14, color: _fav ? VAColors.red : VAColors.grey),
                  ))),
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
            ]),
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
                      child: Center(child: Text(
                        widget.annonce.vendeur.initiales.isNotEmpty ? widget.annonce.vendeur.initiales[0] : 'V',
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

// ─── UTILITAIRES ─────────────────────────────────────────────────────────────

const _kBaseUrl = 'https://app.beninrestoo.com';

/// Résout une URL image.
/// L'API retourne maintenant des URLs complètes (https://...) directement.
String? _resolveUrl(String? url) {
  if (url == null || url.isEmpty) return null;
  if (url.startsWith('http://') || url.startsWith('https://')) return url;
  if (url.startsWith('/')) return '$_kBaseUrl$url';
  return null; // nom de fichier seul sans chemin → pas affichable
}

/// Image pour les cards Spotlight (cover full)
Widget _buildSpotlightImage(Annonce annonce, Color bg) {
  final url = _resolveUrl(annonce.photos.isNotEmpty ? annonce.photos.first : null);
  if (url != null) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (_, __) => Container(color: bg),
      errorWidget: (_, __, ___) => _iconPlaceholder(annonce.categorie, 195, bg, title: annonce.titre),
    );
  }
  return _iconPlaceholder(annonce.categorie, 195, bg, title: annonce.titre);
}

/// Affiche la vraie image produit (absolue ou relative), sinon placeholder coloré.
Widget _buildProductImage(Annonce annonce, double height, Color bg) {
  final raw  = annonce.photos.isNotEmpty ? annonce.photos.first : null;
  final url  = _resolveUrl(raw);

  if (url != null) {
    return CachedNetworkImage(
      imageUrl: url,
      height: height, width: double.infinity,
      fit: BoxFit.cover,
      fadeInDuration: Duration.zero,   // affichage instantané si en cache
      fadeOutDuration: Duration.zero,
      placeholder: (_, __) => Container(        // fond coloré simple pendant le chargement
          height: height, color: bg),
      errorWidget: (_, __, ___) => _iconPlaceholder(   // lettre seulement si erreur
          annonce.categorie, height, bg, title: annonce.titre),
    );
  }
  return _iconPlaceholder(annonce.categorie, height, bg, title: annonce.titre);
}

/// Placeholder avec initiale du titre — plus expressif qu'une icône générique.
Widget _iconPlaceholder(AnnonceCategorie cat, double height, Color bg, {String? title}) {
  final letter = (title?.isNotEmpty == true) ? title![0].toUpperCase() : '?';
  final textColor = Color.fromRGBO(
    (bg.r * 0.45).toInt(),
    (bg.g * 0.45).toInt(),
    (bg.b * 0.45).toInt(),
    1,
  );
  return Container(
    height: height, width: double.infinity, color: bg,
    child: Center(
      child: Text(letter,
        style: TextStyle(
          fontSize: height * 0.35,
          fontWeight: FontWeight.w900,
          color: textColor,
        ),
      ),
    ),
  );
}

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

IconData _catIcon(AnnonceCategorie cat) => switch (cat) {
      AnnonceCategorie.telephones => Icons.phone_android_outlined,
      AnnonceCategorie.mode       => Icons.checkroom_outlined,
      AnnonceCategorie.maison     => Icons.home_outlined,
      AnnonceCategorie.auto       => Icons.directions_car_outlined,
      AnnonceCategorie.beaute     => Icons.face_outlined,
      AnnonceCategorie.hightech   => Icons.computer_outlined,
      AnnonceCategorie.sport      => Icons.sports_soccer_outlined,
      AnnonceCategorie.livres     => Icons.menu_book_outlined,
    };
