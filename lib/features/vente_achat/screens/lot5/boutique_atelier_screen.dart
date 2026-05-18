import 'package:flutter/material.dart';
import '../../core/va_theme.dart';
import 'creation_annonce_photos_screen.dart';

// ═══════════════════════════════════════════════════════════════════════════
//  ATELIER — HUB VENDEUR premium
// ═══════════════════════════════════════════════════════════════════════════

class BoutiqueAtelierScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3EF),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: _BoutiqueHero(
              nom: nom, emoji: emoji,
              ville: ville, quartier: quartier,
            ),
          ),
          SliverToBoxAdapter(child: _PremierPas()),
          SliverToBoxAdapter(child: _BoutiqueSettings(
            quartier: quartier, ville: ville,
          )),
          SliverToBoxAdapter(child: _MesAnnonces()),
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
      bottomNavigationBar: _PublierBar(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  HERO — identité boutique avec bannière douce
// ═══════════════════════════════════════════════════════════════════════════

class _BoutiqueHero extends StatelessWidget {
  final String nom, emoji, ville, quartier;
  const _BoutiqueHero({
    required this.nom, required this.emoji,
    required this.ville, required this.quartier,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [
              BoxShadow(color: Color(0x0A000000), blurRadius: 16, offset: Offset(0, 4)),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Bannière gradient douce ───────────────────────────────
              Stack(
                children: [
                  Container(
                    height: 90,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  // Cercles décoratifs flous
                  Positioned(
                    top: -20, right: -20,
                    child: Container(
                      width: 100, height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: VAColors.primary.withValues(alpha: 0.10),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -10, left: 30,
                    child: Container(
                      width: 60, height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: VAColors.primary.withValues(alpha: 0.07),
                      ),
                    ),
                  ),
                  // Boutons top-right
                  Positioned(
                    top: 10, right: 10,
                    child: Row(
                      children: [
                        _CircleAction(Icons.ios_share_outlined, onTap: () {}),
                        const SizedBox(width: 6),
                        _CircleAction(Icons.close_rounded,
                            onTap: () => Navigator.of(context).pop()),
                      ],
                    ),
                  ),
                  // Logo boutique (chevauchement)
                  Positioned(
                    bottom: -28, left: 20,
                    child: Container(
                      width: 56, height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: VAColors.primary.withValues(alpha: 0.20),
                            blurRadius: 12, offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(emoji, style: const TextStyle(fontSize: 28)),
                      ),
                    ),
                  ),
                ],
              ),

              // ── Identité boutique ─────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 38, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(nom,
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: VAColors.black,
                                  letterSpacing: -0.3),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: VAColors.greyLight,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.edit_outlined, size: 13, color: VAColors.grey),
                                SizedBox(width: 4),
                                Text('Modifier',
                                    style: TextStyle(
                                        fontSize: 12, fontWeight: FontWeight.w600,
                                        color: VAColors.greyText)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: VAColors.greenLight,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.circle, size: 7, color: VAColors.green),
                              SizedBox(width: 4),
                              Text('Ouverte',
                                  style: TextStyle(color: VAColors.green,
                                      fontSize: 11, fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                        if (quartier.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          const Icon(Icons.location_on_outlined,
                              size: 13, color: VAColors.grey),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              '$quartier${ville.isNotEmpty ? ", $ville" : ""}',
                              style: const TextStyle(
                                  fontSize: 12, color: VAColors.grey,
                                  fontWeight: FontWeight.w500),
                              maxLines: 1, overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              // ── Stats ─────────────────────────────────────────────────
              Container(
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Color(0xFFF0F0F0))),
                ),
                child: IntrinsicHeight(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleAction(this.icon, {required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 32, height: 32,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 16, color: VAColors.greyText),
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
                      fontSize: 18, fontWeight: FontWeight.w800,
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
//  PREMIER PAS — encouragement doux, warm
// ═══════════════════════════════════════════════════════════════════════════

class _PremierPas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Color(0x07000000), blurRadius: 10, offset: Offset(0, 3)),
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
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(child: Text('🚀', style: TextStyle(fontSize: 20))),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Décrochez votre première vente',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700,
                            color: VAColors.black)),
                    SizedBox(height: 2),
                    Text('Publiez un produit — c\'est gratuit.',
                        style: TextStyle(fontSize: 12, color: VAColors.greyText)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const CreationAnnoncePhotosScreen()),
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
                  Icon(Icons.add_rounded, color: VAColors.primaryDark, size: 18),
                  SizedBox(width: 6),
                  Text('Publier mon premier produit',
                      style: TextStyle(
                          color: VAColors.primaryDark,
                          fontSize: 13, fontWeight: FontWeight.w700)),
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
//  PARAMÈTRES BOUTIQUE — accès rapide à la personnalisation
// ═══════════════════════════════════════════════════════════════════════════

class _BoutiqueSettings extends StatelessWidget {
  final String quartier, ville;
  const _BoutiqueSettings({required this.quartier, required this.ville});

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
                  fontSize: 15, fontWeight: FontWeight.w700, color: VAColors.black)),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(color: Color(0x07000000), blurRadius: 10, offset: Offset(0, 3)),
            ],
          ),
          child: Column(
            children: [
              _SettingRow(
                icon: '🖼️',
                iconBg: const Color(0xFFE8F5E9),
                title: 'Ajouter une photo de profil',
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
    required this.icon, required this.iconBg,
    required this.title, required this.sub,
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
                    color: iconBg, borderRadius: BorderRadius.circular(10)),
                child: Center(child: Text(icon, style: const TextStyle(fontSize: 17))),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600,
                            color: VAColors.black)),
                    const SizedBox(height: 2),
                    Text(sub,
                        style: const TextStyle(
                            fontSize: 12, color: VAColors.grey),
                        maxLines: 1, overflow: TextOverflow.ellipsis),
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
                color: VAColors.primaryDark, fontSize: 11,
                fontWeight: FontWeight.w700)),
      );
}

class _SDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      const Divider(height: 1, indent: 66, color: Color(0xFFF0F0F0));
}

// ═══════════════════════════════════════════════════════════════════════════
//  MES ANNONCES — état vide warm
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
                      fontSize: 15, fontWeight: FontWeight.w700, color: VAColors.black)),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: const Text('Tout voir',
                    style: TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600,
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
              BoxShadow(color: Color(0x07000000), blurRadius: 10, offset: Offset(0, 3)),
            ],
          ),
          child: Column(
            children: [
              // Illustration warm : 3 petites cartes empilées
              SizedBox(
                height: 68,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 60,
                      child: _MiniEmptyCard(
                          color: const Color(0xFFFFE0B2), offset: 8, opacity: 0.5),
                    ),
                    Positioned(
                      right: 60,
                      child: _MiniEmptyCard(
                          color: const Color(0xFFFFCCBC), offset: 8, opacity: 0.5),
                    ),
                    _MiniEmptyCard(color: VAColors.primaryLight, offset: 0, opacity: 1),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text('Votre vitrine est vide',
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w700, color: VAColors.black)),
              const SizedBox(height: 5),
              const Text(
                'Chaque produit publié est visible\npar des milliers d\'acheteurs.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: VAColors.grey, height: 1.5),
              ),
              const SizedBox(height: 18),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => const CreationAnnoncePhotosScreen()),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
                  decoration: BoxDecoration(
                    color: VAColors.primary,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: VAColors.primary.withValues(alpha: 0.30),
                        blurRadius: 10, offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Text('Publier mon premier produit',
                      style: TextStyle(
                          color: Colors.white, fontSize: 13,
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

class _MiniEmptyCard extends StatelessWidget {
  final Color color;
  final double offset;
  final double opacity;
  const _MiniEmptyCard(
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
              borderRadius: BorderRadius.circular(10),
            ),
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
          MaterialPageRoute(builder: (_) => const CreationAnnoncePhotosScreen()),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: VAColors.primary,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: VAColors.primary.withValues(alpha: 0.32),
                blurRadius: 14, offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_rounded, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text('Publier une annonce',
                  style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.w800, fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}
