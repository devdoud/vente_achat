import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../../core/injection/injection.dart';
import '../transaction/cart_screen.dart';
import '../../../../../core/utils/failures.dart';
import '../../theme/va_theme.dart';
import '../../widgets/export.dart';
import '../../../domain/export.dart';
import '../../../data/mappers/product_mapper.dart';
import '../../../logic/export.dart';
import '../transaction/offre_sure_screen.dart';


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

IconData _catIcon(AnnonceCategorie c) => switch (c) {
      AnnonceCategorie.telephones => Icons.phone_android_outlined,
      AnnonceCategorie.mode       => Icons.checkroom_outlined,
      AnnonceCategorie.maison     => Icons.home_outlined,
      AnnonceCategorie.auto       => Icons.directions_car_outlined,
      AnnonceCategorie.beaute     => Icons.face_outlined,
      AnnonceCategorie.hightech   => Icons.computer_outlined,
      AnnonceCategorie.sport      => Icons.sports_soccer_outlined,
      AnnonceCategorie.livres     => Icons.menu_book_outlined,
    };

// ─────────────────────────────────────────────────────────────────────────────

@RoutePage()
class AnnonceDetailScreen extends StatefulWidget {
  final Annonce annonce;
  const AnnonceDetailScreen({super.key, required this.annonce});

  @override
  State<AnnonceDetailScreen> createState() => _AnnonceDetailScreenState();
}

class _AnnonceDetailScreenState extends State<AnnonceDetailScreen> {
  int     _page  = 0;
  bool    _isFav = false;
  bool    _descExpanded    = false;
  bool    _justAddedToCart = false;

  late final CartCubit    _cartCubit;
  late final ProductCubit _productCubit;
  late final ProductCubit _relatedCubit;  // charge le feed pour les suggestions

  late Annonce _annonce;
  Annonce get a => _annonce;

  @override
  void initState() {
    super.initState();
    _annonce      = widget.annonce;
    _cartCubit    = getIt<CartCubit>()..load();
    _productCubit = getIt<ProductCubit>()..getProduct(widget.annonce.id);
    _relatedCubit = getIt<ProductCubit>()..loadProducts();
  }

  @override
  void dispose() {

    _productCubit.close();
    _relatedCubit.close();
    super.dispose();
  }

  /// Ouvre le sélecteur de quantité — l'ajout API se fait depuis le sheet.
  void _addToCart() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(VARadius.xl))),
      builder: (_) => BlocProvider.value(
        value: _cartCubit,
        child: _QuantitySheet(annonce: a),
      ),
    );
  }

  void _onCartChanged(BuildContext context, CartState state) {}

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _cartCubit),
        BlocProvider.value(value: _productCubit),
        BlocProvider<ProductCubit>.value(value: _relatedCubit),
      ],
      child: BlocListener<ProductCubit, ProductState>(
        listener: (ctx, state) {
          if (state is ProductDetail && mounted) {
            setState(() {
              _annonce = productToAnnonce(state.product);
            });
          }
        },
        child: BlocListener<CartCubit, CartState>(
        listener: _onCartChanged,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _ImageCarousel(
                  annonce: a,
                  currentPage: _page,
                  isFav: _isFav,
                  onPageChanged: (i) => setState(() => _page = i),
                  onFavTap: () => setState(() => _isFav = !_isFav),
                ),
              ),
              SliverToBoxAdapter(child: _InfoSection(annonce: a)),
              const SliverToBoxAdapter(child: _TrustBanner()),
              SliverToBoxAdapter(child: _SellerSection(vendeur: a.vendeur)),
              SliverToBoxAdapter(
                child: _DetailsSection(
                  annonce: a,
                  expanded: _descExpanded,
                  onToggle: () => setState(() => _descExpanded = !_descExpanded),
                ),
              ),
              // Sections produits suggérés avec scroll infini
              BlocBuilder<ProductCubit, ProductState>(
                bloc: _relatedCubit,
                builder: (ctx, state) {
                  if (state is! ProductLoaded) return const SliverToBoxAdapter(child: SizedBox.shrink());
                  final all = state.products
                      .where((p) => p.uuid != a.id)
                      .map((p) => productToAnnonce(p))
                      .toList();
                  if (all.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());

                  final sameCat = all.where((x) => x.categorie == a.categorie).toList();
                  final cheaper = List<Annonce>.from(all)
                      ..sort((x, y) => x.prix.compareTo(y.prix));
                  final recent  = List<Annonce>.from(all)
                      ..sort((x, y) => y.datePublication.compareTo(x.datePublication));

                  return SliverList(
                    delegate: SliverChildListDelegate([
                      if (sameCat.isNotEmpty)
                        _RelatedSection(
                          title: 'Dans la même catégorie',
                          sub:   '${sameCat.length} article${sameCat.length > 1 ? 's' : ''} similaire${sameCat.length > 1 ? 's' : ''}',
                          items: sameCat,
                        ),
                      if (cheaper.isNotEmpty)
                        _RelatedSection(
                          title: 'Les petits prix',
                          sub:   'Dépense moins, découvre plus',
                          items: cheaper,
                        ),
                      if (recent.isNotEmpty)
                        _RelatedSection(
                          title: 'Derniers arrivages',
                          sub:   'Tout juste ajoutés pour toi',
                          items: recent,
                        ),
                      const SizedBox(height: 8),
                    ]),
                  );
                },
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 130)),
            ],
          ),
          bottomNavigationBar: _BottomBar(
            annonce: a,
            isAddingToCart: _justAddedToCart,
            onAddToCart: _addToCart,
          ),
        ),
        ),   // BlocListener<CartCubit>
      ),     // BlocListener<ProductCubit>
    );       // MultiBlocProvider
  }
}

// ─── IMAGE CAROUSEL ───────────────────────────────────────────────────────────

class _ImageCarousel extends StatefulWidget {
  final Annonce annonce;
  final int currentPage;
  final bool isFav;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onFavTap;

  const _ImageCarousel({
    required this.annonce, required this.currentPage,
    required this.isFav, required this.onPageChanged, required this.onFavTap,
  });

  @override
  State<_ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<_ImageCarousel> {
  late PageController _ctrl;

  List<String> get _photos => widget.annonce.photos
      .where((p) => p.isNotEmpty)
      .toList();

  String? _resolve(String p) => p.startsWith('http') ? p
      : p.startsWith('/') ? 'https://app.beninrestoo.com$p' : null;

  @override
  void initState() {
    super.initState();
    _ctrl = PageController();
  }

  @override
  void didUpdateWidget(_ImageCarousel old) {
    super.didUpdateWidget(old);
    // Reset contrôleur si la liste de photos change
    if (old.annonce.photos != widget.annonce.photos) {
      _ctrl.dispose();
      _ctrl = PageController();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base      = _bgColor(widget.annonce.categorie);
    final top       = MediaQuery.of(context).padding.top;
    final photos    = _photos;
    final pageCount = photos.isNotEmpty ? photos.length : 1;

    return SizedBox(
      height: 340,
      child: Stack(
        children: [
          // Carousel principal
          SizedBox(
            height: 300,
            child: PageView.builder(
              controller: _ctrl,
              itemCount: pageCount,
              onPageChanged: widget.onPageChanged,
              itemBuilder: (_, i) {
                final url = i < photos.length ? _resolve(photos[i]) : null;
                if (url != null) {
                  return CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    fadeInDuration: Duration.zero,
                    fadeOutDuration: Duration.zero,
                    placeholder: (_, __) => Container(color: base),
                    errorWidget: (_, __, ___) => _placeholder(base, i),
                  );
                }
                return _placeholder(base, i);
              },
            ),
          ),

          // Miniatures en bas (si plusieurs images)
          if (photos.length > 1)
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: Container(
                height: 44,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: photos.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 6),
                  itemBuilder: (_, i) {
                    final url = _resolve(photos[i]);
                    final isActive = widget.currentPage == i;
                    return GestureDetector(
                      onTap: () => _ctrl.animateToPage(i,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOut),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: isActive ? 44 : 36,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: isActive ? VAColors.primary : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: url != null
                            ? CachedNetworkImage(
                                imageUrl: url, fit: BoxFit.cover,
                                errorWidget: (_, __, ___) =>
                                    Container(color: base))
                            : Container(color: base),
                      ),
                    );
                  },
                ),
              ),
            ),
          Positioned(top: top + 10, left: 14,
            child: _CircleBtn(icon: Icons.chevron_left_rounded, onTap: () => Navigator.of(context).pop())),
          Positioned(
            top: top + 10, right: 14,
            child: Row(children: [
              _CircleBtn(
                icon: widget.isFav ? Icons.favorite : Icons.favorite_border,
                color: widget.isFav ? VAColors.red : VAColors.black,
                onTap: widget.onFavTap,
              ),
              const SizedBox(width: 8),
              _CircleBtn(icon: Icons.share_outlined, onTap: () {}),
            ]),
          ),
          if (widget.annonce.remisePourcent != null)
            Positioned(top: top + 10, left: 60,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: VAColors.red, borderRadius: BorderRadius.circular(20)),
                child: Text('-${widget.annonce.remisePourcent}%',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12)),
              )),
          // Dots (seulement si plusieurs images)
          if (pageCount > 1)
            Positioned(
              bottom: photos.length > 1 ? 52 : 14,
              left: 0, right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(pageCount, (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: i == widget.currentPage ? 18 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: i == widget.currentPage ? VAColors.primary : Colors.black26,
                    borderRadius: BorderRadius.circular(3),
                  ),
                )),
              ),
            ),
          // Compteur
          Positioned(
            bottom: photos.length > 1 ? 52 : 14, right: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(12)),
              child: Text('${widget.currentPage + 1} / $pageCount',
                  style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _placeholder(Color base, int i) {
    final hsl   = HSLColor.fromColor(base);
    final light = (hsl.lightness + i * 0.06).clamp(0.0, 1.0);
    final bg    = hsl.withLightness(light).toColor();
    return Container(color: bg);
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
          width: 36, height: 36,
          decoration: const BoxDecoration(
            color: Colors.white, shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Color(0x18000000), blurRadius: 8, offset: Offset(0, 2))],
          ),
          child: Icon(icon, size: 20, color: color),
        ),
      );
}

// ─── INFO SECTION ─────────────────────────────────────────────────────────────

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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: VAColors.greenLight, borderRadius: BorderRadius.circular(20)),
            child: const Text('Nouveau neuf',
                style: TextStyle(color: VAColors.green, fontSize: 11, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 8),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            spacing: 8, runSpacing: 4,
            children: [
              Text(annonce.prixFormate,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: VAColors.primary, letterSpacing: -0.5)),
              if (annonce.ancienPrix != null) ...[
                Text(annonce.ancienPrixFormate!,
                    style: const TextStyle(fontSize: 15, color: VAColors.grey,
                        decoration: TextDecoration.lineThrough, decorationColor: VAColors.grey)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(color: VAColors.redLight, borderRadius: BorderRadius.circular(6)),
                  child: Text('-${annonce.remisePourcent}%',
                      style: const TextStyle(color: VAColors.red, fontSize: 11, fontWeight: FontWeight.w800)),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          Text(annonce.titre,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: VAColors.black, height: 1.3, letterSpacing: -0.3)),
          const SizedBox(height: 8),
          // Nom de la boutique
          if (annonce.vendeur.nom.isNotEmpty && annonce.vendeur.nom != 'Boutique')
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.storefront_outlined, size: 14, color: VAColors.grey),
                  const SizedBox(width: 4),
                  Text(annonce.vendeur.nom,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: VAColors.greyText)),
                ],
              ),
            ),
          Wrap(
            spacing: 12, runSpacing: 4,
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

// ─── TRUST BANNER ─────────────────────────────────────────────────────────────

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
            width: 32, height: 32,
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

// ─── SELLER SECTION ───────────────────────────────────────────────────────────

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
                      Row(children: [
                        Text(vendeur.nom,
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: VAColors.black)),
                        const SizedBox(width: 6),
                        if (vendeur.isPro) const VAProBadge(),
                        if (vendeur.isVerifie) ...[
                          const SizedBox(width: 4),
                          const Icon(Icons.verified, color: VAColors.blue, size: 14),
                        ],
                      ]),
                      const SizedBox(height: 4),
                      Row(children: [
                        const Icon(Icons.star_rounded, color: VAColors.star, size: 13),
                        const SizedBox(width: 3),
                        Text(
                          vendeur.note > 0 ? vendeur.note.toStringAsFixed(1) : 'Nouveau',
                          style: const TextStyle(fontSize: 12, color: VAColors.greyText),
                        ),
                        if (vendeur.ventes > 0) ...[
                          Text(' · ${vendeur.ventes} avis',
                              style: const TextStyle(fontSize: 12, color: VAColors.grey)),
                        ],
                      ]),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, color: VAColors.grey),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(border: Border(top: BorderSide(color: VAColors.greyBorder))),
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatCol(
                  vendeur.note > 0 ? vendeur.note.toStringAsFixed(1) : '–',
                  'note',
                  icon: Icons.star_rounded,
                  iconColor: VAColors.star,
                ),
                _VDivider(),
                _StatCol(
                  vendeur.ventes > 0 ? '${vendeur.ventes}' : '–',
                  'évaluations',
                ),
                if (vendeur.produits != null) ...[
                  _VDivider(),
                  _StatCol('${vendeur.produits}', 'articles'),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

}

class _StatCol extends StatelessWidget {
  final String value, label;
  final IconData? icon;
  final Color? iconColor;
  const _StatCol(this.value, this.label, {this.icon, this.iconColor});

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 14, color: iconColor ?? VAColors.grey),
                const SizedBox(width: 3),
                Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: VAColors.black)),
              ],
            )
          else
            Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: VAColors.black)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 11, color: VAColors.grey)),
        ],
      );
}

class _VDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(width: 1, height: 32, color: VAColors.greyBorder);
}

// ─── DETAILS + DESCRIPTION ────────────────────────────────────────────────────

class _DetailsSection extends StatelessWidget {
  final Annonce annonce;
  final bool expanded;
  final VoidCallback onToggle;
  const _DetailsSection({required this.annonce, required this.expanded, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final desc   = annonce.description;
    final isLong = desc.length > 120;
    final shown  = expanded || !isLong ? desc : '${desc.substring(0, 120)}...';
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
          _DetailRow('État', 'Nouveau neuf'),
          _DetailRow('Catégorie', annonce.categorie.label),
          _DetailRow('Localisation', annonce.localisation),
          const Divider(height: 20, color: VAColors.greyBorder),
          const Text('Description', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: VAColors.black)),
          const SizedBox(height: 6),
          Text(shown, style: const TextStyle(fontSize: 13, color: VAColors.greyText, height: 1.55)),
          if (isLong) ...[
            const SizedBox(height: 6),
            GestureDetector(
              onTap: onToggle,
              child: Text(expanded ? 'Voir moins' : 'Voir plus',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: VAColors.primary)),
            ),
          ],
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label, value;
  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            SizedBox(width: 100,
              child: Text(label, style: const TextStyle(fontSize: 12, color: VAColors.grey))),
            Expanded(child: Text(value,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: VAColors.black))),
          ],
        ),
      );
}

// ─── BOTTOM BAR — panier + acheter ───────────────────────────────────────────

class _BottomBar extends StatelessWidget {
  final Annonce  annonce;
  final bool     isAddingToCart;
  final VoidCallback onAddToCart;

  const _BottomBar({
    required this.annonce,
    required this.isAddingToCart,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Hauteur fixe : empêche toute expansion pendant les transitions
      height: 72 + MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.fromLTRB(16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: VAColors.greyBorder)),
      ),
      child: Row(
        children: [
          // Ajouter au panier
          Expanded(
            child: GestureDetector(
              onTap: isAddingToCart ? null : onAddToCart,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: 48, // hauteur fixe — jamais plus grand
                decoration: BoxDecoration(
                  color: isAddingToCart ? VAColors.primaryLight : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: VAColors.primary, width: 1.5),
                ),
                child: isAddingToCart
                    ? const Center(child: SizedBox(
                        width: 18, height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: VAColors.primary)))
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart_outlined, color: VAColors.primary, size: 18),
                          SizedBox(width: 7),
                          Text('Au panier',
                              style: TextStyle(color: VAColors.primary, fontWeight: FontWeight.w700, fontSize: 13)),
                        ],
                      ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Acheter maintenant
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => OffreSureScreen(annonce: annonce)),
              ),
              child: Container(
                height: 48, // même hauteur fixe que le bouton panier
                decoration: BoxDecoration(
                  color: VAColors.primary,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [BoxShadow(
                    color: VAColors.primary.withValues(alpha: 0.4),
                    blurRadius: 10, offset: const Offset(0, 4),
                  )],
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


// ─── Section produits suggérés ────────────────────────────────────────────────

class _RelatedSection extends StatelessWidget {
  final String       title;
  final String       sub;
  final List<Annonce> items;

  const _RelatedSection({
    required this.title,
    required this.sub,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Titre captivant
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 28, 16, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w900,
                      color: VAColors.black, letterSpacing: -0.4, height: 1.2)),
              const SizedBox(height: 2),
              Text(sub, style: VATextStyles.caption),
            ],
          ),
        ),
        // Scroll horizontal de cartes
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (ctx, i) {
              final ann = items[i];
              final raw = ann.photos.isNotEmpty ? ann.photos.first : null;
              final imgUrl = raw == null || raw.isEmpty ? null
                  : raw.startsWith('http') ? raw
                  : raw.startsWith('/') ? 'https://app.beninrestoo.com$raw'
                  : 'https://app.beninrestoo.com/media/$raw';
              final bg = _bgColor(ann.categorie);
              return GestureDetector(
                onTap: () => Navigator.of(ctx).push(
                  MaterialPageRoute(builder: (_) => AnnonceDetailScreen(annonce: ann)),
                ),
                child: Container(
                  width: 130,
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
                      Expanded(
                        child: imgUrl != null
                            ? CachedNetworkImage(
                                imageUrl: imgUrl,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorWidget: (_, __, ___) => _letterPlaceholder(ann, bg),
                              )
                            : _letterPlaceholder(ann, bg),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(ann.titre,
                                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: VAColors.black),
                                maxLines: 1, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 2),
                            Text(ann.prixFormate,
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: VAColors.primary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _letterPlaceholder(Annonce ann, Color bg) {
    final c = Color.fromRGBO(
      (bg.r * 0.45).toInt(), (bg.g * 0.45).toInt(), (bg.b * 0.45).toInt(), 1);
    return Container(
      color: bg,
      child: Center(child: Text(
        ann.titre.isNotEmpty ? ann.titre[0].toUpperCase() : '?',
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: c),
      )),
    );
  }
}

// ─── Bottom sheet — produit ajouté au panier ──────────────────────────────────


// ─── Bottom sheet — produit ajouté au panier ──────────────────────────────────

class _CartAddedSheet extends StatelessWidget {
  final Annonce annonce;
  final Cart    cart;
  const _CartAddedSheet({required this.annonce, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        VAPadding.base, VAPadding.lg,
        VAPadding.base,
        MediaQuery.of(context).padding.bottom + VAPadding.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag indicator
          Center(
            child: Container(
              width: 36, height: 4,
              decoration: BoxDecoration(
                color: VAColors.greyBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Produit info
          Row(
            children: [
              Container(
                width: 56, height: 56,
                decoration: BoxDecoration(
                  color: VAColors.primaryLight,
                  borderRadius: BorderRadius.circular(VARadius.md),
                ),
                child: Center(
                  child: Text(
                    annonce.titre.isNotEmpty ? annonce.titre[0].toUpperCase() : '?',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: VAColors.primaryDark,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.check_circle_rounded, color: VAColors.green, size: 14),
                        SizedBox(width: 4),
                        Text('Ajouté au panier',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: VAColors.green)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(annonce.titre,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: VAColors.black),
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Text(annonce.prixFormate,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: VAColors.primary)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: VAColors.greyBorder),
          const SizedBox(height: 14),
          // Résumé panier
          Row(
            children: [
              const Icon(Icons.shopping_cart_outlined, color: VAColors.primary, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${cart.itemCount} article${cart.itemCount > 1 ? "s" : ""} dans le panier',
                  style: const TextStyle(fontSize: 13, color: VAColors.greyText),
                ),
              ),
              Text(cart.formattedTotal,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: VAColors.black)),
            ],
          ),
          const SizedBox(height: 18),
          // Boutons
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: VAColors.greyLight,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Text('Continuer',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: VAColors.black)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const CartScreen()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: VAColors.primary,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Text('Voir le panier',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Sélecteur de quantité ────────────────────────────────────────────────────

class _QuantitySheet extends StatefulWidget {
  final Annonce annonce;
  const _QuantitySheet({required this.annonce});
  @override
  State<_QuantitySheet> createState() => _QuantitySheetState();
}

class _QuantitySheetState extends State<_QuantitySheet> {
  int  _qty     = 1;
  bool _loading = false;

  Future<void> _confirm() async {
    if (_loading) return;
    setState(() => _loading = true);
    final cubit = context.read<CartCubit>();
    await cubit.addItem(productUuid: widget.annonce.id, quantity: _qty);
    if (!mounted) return;
    final state = cubit.state;
    Navigator.of(context).pop();
    if (state is CartLoaded) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(VARadius.xl))),
        builder: (_) => _CartAddedSheet(annonce: widget.annonce, cart: state.cart),
      );
    } else if (state is CartFailure) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(
          content: Text(state.failure.toMsg,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          backgroundColor: VAColors.red,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        ));
    }
  }

  String get _subTotal {
    final sub = widget.annonce.prix * _qty;
    if (sub >= 1000000) return '${(sub / 1000000).toStringAsFixed(1)}M F';
    if (sub >= 1000) {
      final e = sub ~/ 1000;
      final r = (sub % 1000).round();
      return r == 0 ? '$e 000 F' : '$e ${r.toString().padLeft(3, '0')} F';
    }
    return '${sub.toInt()} F';
  }

  @override
  Widget build(BuildContext context) {
    final ann = widget.annonce;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        VAPadding.base, VAPadding.lg, VAPadding.base,
        MediaQuery.of(context).padding.bottom + VAPadding.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: Container(width: 36, height: 4,
              decoration: BoxDecoration(color: VAColors.greyBorder,
                  borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 20),
          Row(children: [
            Container(
              width: 52, height: 52,
              decoration: BoxDecoration(color: VAColors.primaryLight,
                  borderRadius: BorderRadius.circular(VARadius.sm)),
              child: Center(child: Text(
                ann.titre.isNotEmpty ? ann.titre[0].toUpperCase() : '?',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900,
                    color: VAColors.primaryDark),
              )),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,
              children: [
                Text(ann.titre,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700,
                        color: VAColors.black),
                    maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text(ann.prixFormate,
                    style: const TextStyle(fontSize: 13, color: VAColors.greyText)),
              ],
            )),
          ]),
          const SizedBox(height: 22),
          const Divider(height: 1, color: VAColors.greyBorder),
          const SizedBox(height: 18),
          const Text('Quantité',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700,
                  color: VAColors.black)),
          const SizedBox(height: 12),
          Container(
            height: 54,
            decoration: BoxDecoration(color: VAColors.greyLight,
                borderRadius: BorderRadius.circular(16)),
            child: Row(children: [
              GestureDetector(
                onTap: _qty > 1 ? () => setState(() => _qty--) : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 54, height: 54,
                  decoration: BoxDecoration(
                    color: _qty > 1 ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: _qty > 1
                        ? [const BoxShadow(color: Color(0x10000000), blurRadius: 6)]
                        : null,
                  ),
                  child: Icon(Icons.remove_rounded, size: 20,
                      color: _qty > 1 ? VAColors.black : VAColors.greyBorder),
                ),
              ),
              Expanded(child: Center(child: Text('$_qty',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900,
                      color: VAColors.black)))),
              GestureDetector(
                onTap: () => setState(() => _qty++),
                child: Container(
                  width: 54, height: 54,
                  decoration: BoxDecoration(color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [BoxShadow(color: Color(0x10000000), blurRadius: 6)]),
                  child: const Icon(Icons.add_rounded, size: 20, color: VAColors.black),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 18),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Sous-total × $_qty',
                style: const TextStyle(fontSize: 13, color: VAColors.greyText)),
            Text(_subTotal,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900,
                    color: VAColors.primary)),
          ]),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: _loading ? null : _confirm,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180), height: 52,
              decoration: BoxDecoration(
                color: _loading ? VAColors.primaryLight : VAColors.primary,
                borderRadius: BorderRadius.circular(14),
                boxShadow: _loading ? null : [BoxShadow(
                  color: VAColors.primary.withValues(alpha: 0.35),
                  blurRadius: 10, offset: const Offset(0, 4),
                )],
              ),
              child: _loading
                  ? const Center(child: SizedBox(width: 22, height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2.5,
                          color: VAColors.primary)))
                  : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 18),
                      const SizedBox(width: 8),
                      Text('Ajouter — $_subTotal',
                          style: const TextStyle(color: Colors.white, fontSize: 15,
                              fontWeight: FontWeight.w800)),
                    ]),
            ),
          ),
        ],
      ),
    );
  }
}
