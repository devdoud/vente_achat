import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../core/utils/failures.dart';
import '../../theme/va_theme.dart';
import '../../../data/mappers/product_mapper.dart';
import '../../../domain/export.dart';
import '../../../logic/export.dart';
import '../catalogue/annonce_detail_screen.dart';
import 'creation_annonce_photos_screen.dart';
import 'product_edit_sheet.dart';

// 
//  ATELIER — HUB VENDEUR
// 

class BoutiqueAtelierScreen extends StatefulWidget {
  final String nom;
  final String ville;
  final String quartier;

  const BoutiqueAtelierScreen({
    super.key,
    required this.nom,
    this.ville    = '',
    this.quartier = '',
  });

  @override
  State<BoutiqueAtelierScreen> createState() => _BoutiqueAtelierScreenState();
}

class _BoutiqueAtelierScreenState extends State<BoutiqueAtelierScreen> {
  final _scrollController = ScrollController();
  double _scrollOffset = 0;
  XFile? _cover;
  XFile? _logo;
  final _picker = ImagePicker();
  late final ProductCubit _productCubit;

  //  Constantes de mise en page
  static const double _coverH        = 185.0;
  static const double _logoSize      = 70.0;
  static const double _logoHalf      = _logoSize / 2;
  // Le contenu blanc chevauche la couverture de cette valeur
  static const double _contentOverlap = 43.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _productCubit = getIt<ProductCubit>()..loadVendorProducts();
  }

  void _onScroll() {
    final offset = _scrollController.offset.clamp(0.0, _coverH);
    if (offset != _scrollOffset) setState(() => _scrollOffset = offset);
  }

  Future<void> _openEditSheet() async {
    final prefs    = await SharedPreferences.getInstance();
    final shopUuid = prefs.getString('boutique_shop_uuid') ?? '';
    if (!mounted) return;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(VARadius.xl))),
      builder: (_) => BlocProvider(
        create: (_) => getIt<ShopCubit>(),
        child: _EditShopSheet(
          shopUuid:    shopUuid,
          initialName: widget.nom,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _productCubit.close();
    super.dispose();
  }

  Future<void> _pickCover() async {
    final file = await _picker.pickImage(
        source: ImageSource.gallery, maxWidth: 1920, imageQuality: 85);
    if (file != null && mounted) setState(() => _cover = file);
  }

  Future<void> _pickLogo() async {
    final file = await _picker.pickImage(
        source: ImageSource.gallery, maxWidth: 400, imageQuality: 90);
    if (file != null && mounted) setState(() => _logo = file);
  }

  @override
  Widget build(BuildContext context) {
    final statusH  = MediaQuery.of(context).padding.top;
    // Le logo descend de coverH - logoHalf vers statusH + 8 au scroll
    final logoY    = (_coverH - _logoHalf - _scrollOffset)
        .clamp(statusH + 8.0, _coverH - _logoHalf);

    return BlocProvider.value(
      value: _productCubit,
      child: Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          //   Couverture (fond fixe, derrière le scroll) 
          Positioned(
            top: 0, left: 0, right: 0,
            child: _CoverZone(
              cover: _cover,
              height: _coverH,
              statusH: statusH,
              onPickCover: _pickCover,
            ),
          ),

          //   Contenu scrollable 
          CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [

              // Espace transparent laissant voir la couverture
              SliverToBoxAdapter(
                child: SizedBox(height: _coverH - _contentOverlap),
              ),

              // Carte blanche d'identité (par-dessus la couverture)
              SliverToBoxAdapter(
                child: _IdentityCard(
                  nom: widget.nom,
                  ville: widget.ville,
                  quartier: widget.quartier,
                  logoSize: _logoSize,
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              SliverToBoxAdapter(child: _PremierPas()),
              SliverToBoxAdapter(
                child: _BoutiqueSettings(
                  quartier: widget.quartier,
                  ville: widget.ville,
                ),
              ),
              SliverToBoxAdapter(child: _MesAnnonces()),
              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          ),

          //   Logo (animé : descend au scroll) 
          Positioned(
            top: logoY,
            left: 16,
            child: GestureDetector(
              onTap: _pickLogo,
              child: _LogoCircle(
                size: _logoSize,
                image: _logo,
              ),
            ),
          ),

          //   Boutons actions (toujours épinglés en haut à droite)
          Positioned(
            top: statusH + 10,
            right: 14,
            child: Row(
              children: [
                _CircleBtn(Icons.edit_outlined, onTap: _openEditSheet),
                const SizedBox(width: 8),
                _CircleBtn(Icons.close_rounded,
                    onTap: () => Navigator.of(context).pop()),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _PublierBar(),
      ),   // Scaffold
    );     // BlocProvider.value
  }
}

// 
//  COUVERTURE
// 

class _CoverZone extends StatelessWidget {
  final XFile? cover;
  final double height, statusH;
  final VoidCallback onPickCover;
  const _CoverZone({
    required this.cover,
    required this.height,
    required this.statusH,
    required this.onPickCover,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPickCover,
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image réelle ou placeholder
            if (cover != null)
              Image.file(File(cover!.path), fit: BoxFit.cover)
            else
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFFF3E0), Color(0xFFFFCC80)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: statusH * 0.4),
                    Container(
                      width: 46, height: 46,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.65),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add_a_photo_outlined,
                          size: 22, color: VAColors.greyText),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ajouter une photo de couverture',
                      style: TextStyle(
                          color: Colors.black.withValues(alpha: 0.40),
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),

            // Dégradé haut (lisibilité boutons)
            Positioned(
              top: 0, left: 0, right: 0,
              child: Container(
                height: statusH + 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.32),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Badge "modifier" si couverture existante
            if (cover != null)
              Positioned(
                top: statusH + 10,
                left: 14,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.edit_outlined, size: 12, color: Colors.white),
                      SizedBox(width: 4),
                      Text('Couverture',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
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
//  CARTE IDENTITÉ (nom + chips + stats, par-dessus la couverture)
// 

class _IdentityCard extends StatelessWidget {
  final String nom, ville, quartier;
  final double logoSize;
  const _IdentityCard({
    required this.nom,
    required this.ville,
    required this.quartier,
    required this.logoSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nom + bouton modifier
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Espace horizontal pour le logo flottant
                    SizedBox(width: logoSize + 10, height: logoSize),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nom,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: VAColors.black,
                              letterSpacing: -0.3,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Text(
                            'Boutique particulière',
                            style: TextStyle(
                                fontSize: 12,
                                color: VAColors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Chips d'info
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _InfoBadge(
                      icon: Icons.circle,
                      iconSize: 8,
                      iconColor: VAColors.green,
                      label: 'Ouverte',
                      bg: VAColors.greenLight,
                      textColor: VAColors.green,
                    ),
                    if (quartier.isNotEmpty)
                      _InfoBadge(
                        icon: Icons.place_outlined,
                        iconColor: VAColors.grey,
                        label:
                            '$quartier${ville.isNotEmpty ? ', $ville': ''}',
                        bg: const Color(0xFFF0EDE8),
                        textColor: VAColors.greyText,
                      ),
                  ],
                ),
              ],
            ),
          ),

          // Stats dynamiques
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          BlocBuilder<ProductCubit, ProductState>(
            builder: (_, state) {
              final products = state is ProductLoaded ? state.products : <dynamic>[];
              final total    = products.length;
              final actifs   = state is ProductLoaded
                  ? state.products.where((p) => p.isActive).length
                  : 0;
              final ratings  = state is ProductLoaded
                  ? state.products
                      .where((p) => p.avgRating != null && p.avgRating! > 0)
                      .map((p) => p.avgRating!)
                      .toList()
                  : <double>[];
              final note = ratings.isEmpty
                  ? '–'
                  : (ratings.reduce((a, b) => a + b) / ratings.length)
                      .toStringAsFixed(1);

              return IntrinsicHeight(
                child: Row(
                  children: [
                    _StatCell('$total', 'Produits'),
                    _StatDivider(),
                    _StatCell('$actifs', 'Actifs'),
                    _StatDivider(),
                    _StatCell(note, 'Note moy.'),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// 
//  LOGO CIRCULAIRE
// 

class _LogoCircle extends StatelessWidget {
  final double size;
  final XFile? image;
  const _LogoCircle({required this.size, required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.16),
                  blurRadius: 14,
                  offset: const Offset(0, 4)),
            ],
          ),
          child: ClipOval(
            child: image != null
                ? Image.file(File(image!.path), fit: BoxFit.cover)
                : Container(
                    color: VAColors.primaryLight,
                    child: const Center(
                        child: Icon(Icons.storefront_outlined,
                            color: VAColors.primaryDark, size: 28)),
                  ),
          ),
        ),
        Positioned(
          bottom: 1, right: 1,
          child: Container(
            width: 22, height: 22,
            decoration: BoxDecoration(
              color: VAColors.primary,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(Icons.camera_alt_rounded,
                size: 10, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

// 
//  MICRO-WIDGETS
// 

class _CircleBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleBtn(this.icon, {required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 34, height: 34,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.88),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 17, color: VAColors.greyText),
        ),
      );
}

class _InfoBadge extends StatelessWidget {
  final IconData icon;
  final Color iconColor, bg, textColor;
  final String label;
  final double iconSize;
  const _InfoBadge({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.bg,
    required this.textColor,
    this.iconSize = 13,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: iconSize, color: iconColor),
            const SizedBox(width: 5),
            Text(label,
                style: TextStyle(
                    color: textColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      );
}

class _StatCell extends StatelessWidget {
  final String value, label;
  const _StatCell(this.value, this.label);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            children: [
              Text(value,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: VAColors.black)),
              const SizedBox(height: 2),
              Text(label,
                  style: const TextStyle(fontSize: 11, color: VAColors.grey)),
            ],
          ),
        ),
      );
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 40, color: const Color(0xFFF0F0F0));
}

// 
//  PREMIER PAS
// 

class _PremierPas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
              color: Color(0x07000000),
              blurRadius: 10,
              offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                    color: VAColors.primaryLight,
                    borderRadius: BorderRadius.circular(12)),
                child: const Center(
                    child: Icon(Icons.rocket_launch_outlined, size: 20, color: VAColors.primaryDark)),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Décrochez votre première vente',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: VAColors.black)),
                    SizedBox(height: 2),
                    Text('Publiez un produit — c\'est gratuit.',
                        style:
                            TextStyle(fontSize: 12, color: VAColors.greyText)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_) => const CreationAnnoncePhotosScreen()),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 13),
              decoration: BoxDecoration(
                color: VAColors.primaryLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_rounded,
                      color: VAColors.primaryDark, size: 18),
                  SizedBox(width: 6),
                  Text('Publier une annonce',
                      style: TextStyle(
                          color: VAColors.primaryDark,
                          fontSize: 13,
                          fontWeight: FontWeight.w700)),
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
//  PARAMÈTRES BOUTIQUE
// 

class _BoutiqueSettings extends StatefulWidget {
  final String quartier, ville;
  const _BoutiqueSettings({required this.quartier, required this.ville});

  @override
  State<_BoutiqueSettings> createState() => _BoutiqueSettingsState();
}

class _BoutiqueSettingsState extends State<_BoutiqueSettings> {
  late final OrderCubit _orderCubit;

  @override
  void initState() {
    super.initState();
    _orderCubit = getIt<OrderCubit>()..loadVendorOrders();
  }

  @override
  void dispose() {
    _orderCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final location = widget.quartier.isNotEmpty
        ? '${widget.quartier}${widget.ville.isNotEmpty ? ", ${widget.ville}" : ""}'
        : 'Non défini';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 22, 16, 10),
          child: Text('Votre boutique',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: VAColors.black)),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [BoxShadow(color: Color(0x07000000), blurRadius: 10, offset: Offset(0, 3))],
          ),
          child: Column(
            children: [
              // Commandes lancées
              BlocBuilder<OrderCubit, OrderState>(
                bloc: _orderCubit,
                builder: (_, state) {
                  final count = state is OrderLoaded ? state.orders.length : 0;
                  return _SettingRow(
                    icon: Icons.shopping_bag_outlined,
                    iconColor: const Color(0xFF6A1B9A),
                    iconBg: const Color(0xFFF3E5F5),
                    title: 'Commandes lancées',
                    sub: count > 0 ? '$count commande${count > 1 ? 's' : ''}' : 'Aucune commande',
                    trailing: const Icon(Icons.chevron_right_rounded, size: 20, color: VAColors.grey),
                  );
                },
              ),
              _SDivider(),
              _SettingRow(
                icon: Icons.location_on_outlined,
                iconColor: const Color(0xFFF57C00),
                iconBg: const Color(0xFFFFF8E1),
                title: 'Lieu de retrait',
                sub: location,
                trailing: const Icon(Icons.chevron_right_rounded, size: 20, color: VAColors.grey),
              ),
              _SDivider(),
              _SettingRow(
                icon: Icons.ios_share_outlined,
                iconColor: const Color(0xFF6A1B9A),
                iconBg: const Color(0xFFF3E5F5),
                title: 'Partager ma boutique',
                sub: 'WhatsApp, réseaux sociaux…',
                trailing: const Icon(Icons.chevron_right_rounded, size: 20, color: VAColors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingRow extends StatelessWidget {
  final IconData icon;
  final Color iconBg, iconColor;
  final String title, sub;
  final Widget trailing;
  const _SettingRow({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.sub,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          child: Row(
            children: [
              Container(
                width: 38, height: 38,
                decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Icon(icon, size: 18, color: iconColor)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: VAColors.black)),
                    const SizedBox(height: 2),
                    Text(sub,
                        style: const TextStyle(
                            fontSize: 12, color: VAColors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              trailing,
            ],
          ),
        ),
      );
}

class _SDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      const Divider(height: 1, indent: 66, color: Color(0xFFF0F0F0));
}

// 
//  MES ANNONCES
// 

class _MesAnnonces extends StatefulWidget {
  @override
  State<_MesAnnonces> createState() => _MesAnnoncesState();
}

class _MesAnnoncesState extends State<_MesAnnonces> {
  int _tabIndex = 0;
  static const _tabs = ['Tous', 'Actifs', 'En attente'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
        builder: (ctx, state) {
          if (state is ProductLoading || state is ProductInitial) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(child: CircularProgressIndicator(color: VAColors.primary, strokeWidth: 2)),
            );
          }

          final all = state is ProductLoaded
              ? state.products.map((p) => productToAnnonce(p)).toList()
              : <Annonce>[];

          final filtered = _tabIndex == 1
              ? all.where((a) => a.status == AnnonceStatus.active).toList()
              : _tabIndex == 2
                  ? all.where((a) => a.status == AnnonceStatus.enAttente).toList()
                  : all;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 22, 16, 10),
                child: Row(
                  children: [
                    Text(
                      'Mes annonces${all.isNotEmpty ? ' (${all.length})' : ''}',
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: VAColors.black),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const CreationAnnoncePhotosScreen()),
                      ),
                      child: const Text('+ Ajouter',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: VAColors.primary)),
                    ),
                  ],
                ),
              ),

              // Onglets filtre
              if (all.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: Row(
                    children: List.generate(_tabs.length, (i) {
                      final count = i == 0
                          ? all.length
                          : i == 1
                              ? all.where((a) => a.status == AnnonceStatus.active).length
                              : all.where((a) => a.status == AnnonceStatus.enAttente).length;
                      final selected = _tabIndex == i;
                      return GestureDetector(
                        onTap: () => setState(() => _tabIndex = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: selected ? VAColors.primary : VAColors.greyLight,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            count > 0 ? '${_tabs[i]} ($count)' : _tabs[i],
                            style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600,
                              color: selected ? Colors.white : VAColors.greyText,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),

              if (filtered.isEmpty) ...[
        // Vitrine vide (hardcoded state)
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.fromLTRB(20, 32, 20, 32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                  color: Color(0x07000000),
                  blurRadius: 10,
                  offset: Offset(0, 3)),
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                height: 68,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                        left: 60,
                        child: _MiniCard(
                            color: const Color(0xFFFFE0B2), offset: 8, opacity: 0.5)),
                    Positioned(
                        right: 60,
                        child: _MiniCard(
                            color: const Color(0xFFFFCCBC), offset: 8, opacity: 0.5)),
                    _MiniCard(
                        color: VAColors.primaryLight, offset: 0, opacity: 1),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text('Votre vitrine est vide',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: VAColors.black)),
              const SizedBox(height: 5),
              const Text(
                'Chaque produit publié est visible\npar des milliers d\'acheteurs.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12, color: VAColors.grey, height: 1.5),
              ),
              const SizedBox(height: 18),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => const CreationAnnoncePhotosScreen()),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 11),
                  decoration: BoxDecoration(
                    color: VAColors.primary,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: VAColors.primary.withValues(alpha: 0.30),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Text('Publier une annonce',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
              ] else ...[
                // Grille des vrais produits
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:  2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing:  8,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (ctx, i) {
                      final a = filtered[i];
                      final raw = a.photos.isNotEmpty ? a.photos.first : null;
                      final imgUrl = raw == null || raw.isEmpty
                          ? null
                          : raw.startsWith('http')
                              ? raw
                              : raw.startsWith('/')
                                  ? 'https://app.beninrestoo.com$raw'
                                  : null;
                      final productList = (state as ProductLoaded).products;
                      final productIdx = productList.indexWhere((p) => p.uuid == a.id);
                      final product = productIdx >= 0 ? productList[productIdx] : null;
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => AnnonceDetailScreen(annonce: a)),
                        ),
                        onLongPress: product != null
                            ? () => _showProductOptions(context, product)
                            : null,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 6)],
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: imgUrl != null
                                    ? CachedNetworkImage(
                                        imageUrl: imgUrl,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        errorWidget: (_, __, ___) => Container(
                                          color: VAColors.primaryLight,
                                          child: Center(child: Text(
                                            a.titre.isNotEmpty ? a.titre[0].toUpperCase() : '?',
                                            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: VAColors.primary),
                                          )),
                                        ),
                                      )
                                    : Container(
                                        color: VAColors.primaryLight,
                                        child: Center(child: Text(
                                          a.titre.isNotEmpty ? a.titre[0].toUpperCase() : '?',
                                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: VAColors.primary),
                                        )),
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(a.titre,
                                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: VAColors.black),
                                        maxLines: 1, overflow: TextOverflow.ellipsis),
                                    const SizedBox(height: 2),
                                    Text(a.prixFormate,
                                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: VAColors.primary)),
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
                const SizedBox(height: 12),
              ],
            ],
          );
        },
      );
  }

  void _showProductOptions(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: VAColors.greyBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Titre
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: VAColors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 20),
            
            // Options
            _OptionRow(
              icon: Icons.edit_outlined,
              iconColor: VAColors.primary,
              iconBg: VAColors.primaryLight,
              label: 'Modifier le produit',
              onTap: () async {
                Navigator.of(context).pop();
                await showProductEditSheet(context, product);
                // Recharger les produits après modification
                if (mounted) {
                  context.read<ProductCubit>().loadVendorProducts();
                }
              },
            ),
            const SizedBox(height: 8),
            _OptionRow(
              icon: Icons.visibility_outlined,
              iconColor: const Color(0xFF1565C0),
              iconBg: const Color(0xFFE3F2FD),
              label: 'Voir la fiche produit',
              onTap: () {
                final annonce = productToAnnonce(product);
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AnnonceDetailScreen(annonce: annonce),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            _OptionRow(
              icon: Icons.delete_outline,
              iconColor: VAColors.red,
              iconBg: const Color(0xFFFFEBEE),
              label: 'Supprimer le produit',
              onTap: () {
                Navigator.of(context).pop();
                _confirmDeleteProduct(product);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeleteProduct(Product product) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Supprimer le produit ?'),
        content: Text('Êtes-vous sûr de vouloir supprimer "${product.name}" ? Cette action est irréversible.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Annuler', style: TextStyle(color: VAColors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<ProductCubit>().deleteProduct(product.uuid);
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(
                  SnackBar(
                    content: const Text('Produit supprimé',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    backgroundColor: VAColors.green,
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  ),
                );
            },
            child: const Text('Supprimer', style: TextStyle(color: VAColors.red, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _MiniCard extends StatelessWidget {
  final Color color;
  final double offset, opacity;
  const _MiniCard(
      {required this.color, required this.offset, required this.opacity});

  @override
  Widget build(BuildContext context) => Transform.translate(
        offset: Offset(0, -offset),
        child: Opacity(
          opacity: opacity,
          child: Container(
            width: 56, height: 64,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
      );
}

// 
//  BARRE PUBLIER
// 

class _PublierBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEBE4))),
      ),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_) => const CreationAnnoncePhotosScreen()),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: VAColors.primary,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: VAColors.primary.withValues(alpha: 0.32),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_rounded, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text('Publier une annonce',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Bottom sheet — Modifier la boutique ─────────────────────────────────────

class _EditShopSheet extends StatefulWidget {
  final String shopUuid;
  final String initialName;
  const _EditShopSheet({required this.shopUuid, required this.initialName});
  @override
  State<_EditShopSheet> createState() => _EditShopSheetState();
}

class _EditShopSheetState extends State<_EditShopSheet> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _descCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.initialName);
    _descCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (ctx, state) {
        if (state is ShopUpdated) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(const SnackBar(
              content: Text('Boutique mise à jour !',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              backgroundColor: VAColors.green,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.fromLTRB(16, 0, 16, 12),
            ));
        } else if (state is ShopFailure) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(SnackBar(
              content: Text(state.failure.toMsg,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              backgroundColor: VAColors.red,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            ));
        }
      },
      builder: (ctx, state) {
        final isLoading = state is ShopLoading;
        return Padding(
          padding: EdgeInsets.fromLTRB(
            VAPadding.base, VAPadding.lg,
            VAPadding.base,
            MediaQuery.of(context).viewInsets.bottom + VAPadding.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Drag handle
              Center(child: Container(
                width: 36, height: 4,
                decoration: BoxDecoration(
                    color: VAColors.greyBorder,
                    borderRadius: BorderRadius.circular(2)),
              )),
              const SizedBox(height: 20),
              const Text('Modifier la boutique',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800,
                      color: VAColors.black)),
              const SizedBox(height: 16),

              // Nom
              const Text('Nom de la boutique',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700,
                      color: VAColors.greyText)),
              const SizedBox(height: 6),
              TextField(
                controller: _nameCtrl,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Nom de votre boutique',
                  hintStyle: const TextStyle(color: VAColors.grey, fontSize: 14),
                  filled: true, fillColor: VAColors.greyLight,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(VARadius.md),
                      borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(VARadius.md),
                      borderSide: const BorderSide(color: VAColors.primary, width: 1.5)),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 12),
                ),
                style: const TextStyle(fontSize: 14, color: VAColors.black,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12),

              // Description
              const Text('Description (optionnel)',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700,
                      color: VAColors.greyText)),
              const SizedBox(height: 6),
              TextField(
                controller: _descCtrl,
                maxLines: 3,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: 'Décrivez votre boutique...',
                  hintStyle: const TextStyle(color: VAColors.grey, fontSize: 14),
                  filled: true, fillColor: VAColors.greyLight,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(VARadius.md),
                      borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(VARadius.md),
                      borderSide: const BorderSide(color: VAColors.primary, width: 1.5)),
                  contentPadding: const EdgeInsets.all(14),
                ),
                style: const TextStyle(fontSize: 14, color: VAColors.black),
              ),
              const SizedBox(height: 18),

              // Bouton sauvegarder
              GestureDetector(
                onTap: isLoading ? null : () {
                  final name = _nameCtrl.text.trim();
                  if (name.isEmpty) return;
                  final desc = _descCtrl.text.trim();
                  ctx.read<ShopCubit>().updateShop(
                    shopUuid:    widget.shopUuid,
                    name:        name,
                    description: desc.isNotEmpty ? desc : null,
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  height: 52,
                  decoration: BoxDecoration(
                    color: isLoading ? VAColors.primaryLight : VAColors.primary,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: isLoading ? null : [BoxShadow(
                      color: VAColors.primary.withValues(alpha: 0.35),
                      blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: isLoading
                      ? const Center(child: SizedBox(width: 22, height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2.5,
                              color: VAColors.primary)))
                      : const Center(child: Text('Sauvegarder',
                          style: TextStyle(color: Colors.white, fontSize: 15,
                              fontWeight: FontWeight.w800))),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─── Option Row pour menu produit ───────────────────────────────────────────

class _OptionRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor, iconBg;
  final String label;
  final VoidCallback onTap;

  const _OptionRow({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: VAColors.greyLight),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(icon, size: 16, color: iconColor),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: VAColors.black,
              ),
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            size: 20,
            color: VAColors.grey,
          ),
        ],
      ),
    ),
  );
}
