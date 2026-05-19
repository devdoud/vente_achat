import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../theme/va_theme.dart';
import 'creation_annonce_photos_screen.dart';

// ═══════════════════════════════════════════════════════════════════════════
//  ATELIER — HUB VENDEUR
// ═══════════════════════════════════════════════════════════════════════════

class BoutiqueAtelierScreen extends StatefulWidget {
  final String nom;
  final String emoji;
  final String ville;
  final String quartier;

  const BoutiqueAtelierScreen({
    super.key,
    required this.nom,
    required this.emoji,
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

  // ── Constantes de mise en page ─────────────────────────────────────────
  static const double _coverH        = 185.0;
  static const double _logoSize      = 70.0;
  static const double _logoHalf      = _logoSize / 2;
  // Le contenu blanc chevauche la couverture de cette valeur
  static const double _contentOverlap = 43.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final offset = _scrollController.offset.clamp(0.0, _coverH);
    if (offset != _scrollOffset) setState(() => _scrollOffset = offset);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
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

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3EF),
      body: Stack(
        children: [

          // ── ① Couverture (fond fixe, derrière le scroll) ──────────────
          Positioned(
            top: 0, left: 0, right: 0,
            child: _CoverZone(
              cover: _cover,
              height: _coverH,
              statusH: statusH,
              onPickCover: _pickCover,
            ),
          ),

          // ── ② Contenu scrollable ───────────────────────────────────────
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

          // ── ③ Logo (animé : descend au scroll) ─────────────────────────
          Positioned(
            top: logoY,
            left: 16,
            child: GestureDetector(
              onTap: _pickLogo,
              child: _LogoCircle(
                size: _logoSize,
                image: _logo,
                emoji: widget.emoji,
              ),
            ),
          ),

          // ── ④ Boutons actions (toujours épinglés en haut à droite) ──────
          Positioned(
            top: statusH + 10,
            right: 14,
            child: Row(
              children: [
                _CircleBtn(Icons.ios_share_outlined, onTap: () {}),
                const SizedBox(width: 8),
                _CircleBtn(Icons.close_rounded,
                    onTap: () => Navigator.of(context).pop()),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _PublierBar(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  COUVERTURE
// ═══════════════════════════════════════════════════════════════════════════

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

// ═══════════════════════════════════════════════════════════════════════════
//  CARTE IDENTITÉ (nom + chips + stats, par-dessus la couverture)
// ═══════════════════════════════════════════════════════════════════════════

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
                    const SizedBox(width: 8),
                    _EditBtn(),
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
                            '$quartier${ville.isNotEmpty ? ', $ville' : ''}',
                        bg: const Color(0xFFF0EDE8),
                        textColor: VAColors.greyText,
                      ),
                  ],
                ),
              ],
            ),
          ),

          // Stats
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          IntrinsicHeight(
            child: Row(
              children: [
                _StatCell('0', 'Ventes'),
                _StatDivider(),
                _StatCell('0', 'Vues'),
                _StatDivider(),
                _StatCell('0', 'Abonnés'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  LOGO CIRCULAIRE
// ═══════════════════════════════════════════════════════════════════════════

class _LogoCircle extends StatelessWidget {
  final double size;
  final XFile? image;
  final String emoji;
  const _LogoCircle(
      {required this.size, required this.image, required this.emoji});

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
                    child: Center(
                        child: Text(emoji,
                            style:
                                TextStyle(fontSize: size * 0.44))),
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

// ═══════════════════════════════════════════════════════════════════════════
//  MICRO-WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

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

class _EditBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFF0EDE8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.edit_outlined, size: 13, color: VAColors.grey),
              SizedBox(width: 4),
              Text('Modifier',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: VAColors.greyText)),
            ],
          ),
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

// ═══════════════════════════════════════════════════════════════════════════
//  PREMIER PAS
// ═══════════════════════════════════════════════════════════════════════════

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
                    child: Text('🚀', style: TextStyle(fontSize: 20))),
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
                  Text('Publier mon premier produit',
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

// ═══════════════════════════════════════════════════════════════════════════
//  PARAMÈTRES BOUTIQUE
// ═══════════════════════════════════════════════════════════════════════════

class _BoutiqueSettings extends StatelessWidget {
  final String quartier, ville;
  const _BoutiqueSettings(
      {required this.quartier, required this.ville});

  @override
  Widget build(BuildContext context) {
    final location = quartier.isNotEmpty
        ? '$quartier${ville.isNotEmpty ? ", $ville" : ""}'
        : 'Non défini';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 22, 16, 10),
          child: Text('Votre boutique',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: VAColors.black)),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
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
              _SettingRow(
                icon: '🖼️',
                iconBg: const Color(0xFFE8F5E9),
                title: 'Photo de profil & couverture',
                sub: 'Rassurez vos acheteurs',
                trailing: _AddBadge(),
              ),
              _SDivider(),
              _SettingRow(
                icon: '📝',
                iconBg: const Color(0xFFE3F2FD),
                title: 'Description de la boutique',
                sub: 'Présentez ce que vous vendez',
                trailing: _AddBadge(),
              ),
              _SDivider(),
              _SettingRow(
                icon: '📍',
                iconBg: const Color(0xFFFFF8E1),
                title: 'Lieu de retrait',
                sub: location,
                trailing: const Icon(Icons.chevron_right_rounded,
                    size: 20, color: VAColors.grey),
              ),
              _SDivider(),
              _SettingRow(
                icon: '🔗',
                iconBg: const Color(0xFFF3E5F5),
                title: 'Partager ma boutique',
                sub: 'WhatsApp, réseaux sociaux…',
                trailing: const Icon(Icons.ios_share_outlined,
                    size: 18, color: VAColors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingRow extends StatelessWidget {
  final String icon, title, sub;
  final Color iconBg;
  final Widget trailing;
  const _SettingRow({
    required this.icon,
    required this.iconBg,
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
                    child:
                        Text(icon, style: const TextStyle(fontSize: 17))),
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

class _AddBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: VAColors.primaryLight,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text('Ajouter',
            style: TextStyle(
                color: VAColors.primaryDark,
                fontSize: 11,
                fontWeight: FontWeight.w700)),
      );
}

class _SDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      const Divider(height: 1, indent: 66, color: Color(0xFFF0F0F0));
}

// ═══════════════════════════════════════════════════════════════════════════
//  MES ANNONCES
// ═══════════════════════════════════════════════════════════════════════════

class _MesAnnonces extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 22, 16, 10),
          child: Row(
            children: [
              const Text('Mes annonces',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: VAColors.black)),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: const Text('Tout voir',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: VAColors.primary)),
              ),
            ],
          ),
        ),
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
                  child: const Text('Publier mon premier produit',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ],
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

// ═══════════════════════════════════════════════════════════════════════════
//  BARRE PUBLIER
// ═══════════════════════════════════════════════════════════════════════════

class _PublierBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
      decoration: const BoxDecoration(
        color: Color(0xFFF5F3EF),
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
