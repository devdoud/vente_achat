import 'package:flutter/material.dart';
import '../../theme/va_theme.dart';
import '../../../domain/export.dart';
import 'creation_annonce_photos_screen.dart';

// ─── Modèle tâche à compléter ─────────────────────────────────────────────────

class _Task {
  final String emoji;
  final String title;
  final String? sub;
  final Color accent;
  bool done = false;
  _Task({required this.emoji, required this.title, this.sub,
      this.accent = VAColors.black});
}

// ─── Écran principal ──────────────────────────────────────────────────────────

class BoutiqueDashboardScreen extends StatefulWidget {
  const BoutiqueDashboardScreen({super.key});

  @override
  State<BoutiqueDashboardScreen> createState() => _BoutiqueDashboardState();
}

class _BoutiqueDashboardState extends State<BoutiqueDashboardScreen> {
  final Vendeur _vendeur = VendeursMock.adjoa;

  final List<_Task> _tasks = [
    _Task(emoji: '📷', title: 'Ajouter une photo de profil',
        sub: 'Rassurez les acheteurs avec un vrai visage'),
    _Task(emoji: '📦', title: 'Publier votre première annonce',
        sub: 'Mettez votre premier produit en ligne'),
    _Task(emoji: 'ℹ️',  title: 'Compléter les infos boutique',
        sub: 'Description, adresse, contacts'),
    _Task(emoji: '📱', title: 'Partager sur les réseaux',
        sub: 'Attirez vos premiers acheteurs'),
    _Task(emoji: '💜', title: 'Attirer vos abonnés',
        sub: 'Concluez 1 vente et gagnez +50 abonnés',
        accent: VAColors.purple),
  ];

  @override
  Widget build(BuildContext context) {
    final pending = _tasks.where((t) => !t.done).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F3EF),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // ── Header boutique ─────────────────────────────────────────
            SliverToBoxAdapter(child: _BoutiqueHeader(vendeur: _vendeur)),

            // ── Actions rapides ──────────────────────────────────────────
            SliverToBoxAdapter(child: _QuickActions()),

            // ── Stats ────────────────────────────────────────────────────
            SliverToBoxAdapter(child: _StatsSection()),

            // ── À compléter ──────────────────────────────────────────────
            SliverToBoxAdapter(
              child: _TaskSection(
                tasks: _tasks,
                pending: pending,
                onToggle: (i) => setState(() => _tasks[i].done = !_tasks[i].done),
              ),
            ),

            // ── Mes annonces (vide pour l'instant) ──────────────────────
            SliverToBoxAdapter(child: _MyListings()),

            const SliverToBoxAdapter(child: SizedBox(height: 120)),
          ],
        ),
      ),

      // ── Bouton publier une annonce ────────────────────────────────────
      bottomNavigationBar: _PublishBar(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  HEADER BOUTIQUE
// ═══════════════════════════════════════════════════════════════════════════

class _BoutiqueHeader extends StatelessWidget {
  final Vendeur vendeur;
  const _BoutiqueHeader({required this.vendeur});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ligne 1 : avatar + titre + fermer
          Row(
            children: [
              // Avatar avec bouton caméra
              Stack(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: VAColors.primaryLight,
                      shape: BoxShape.circle,
                      border: Border.all(color: VAColors.primary, width: 2),
                    ),
                    child: Center(
                      child: Text(vendeur.initiales,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w800,
                              color: VAColors.primaryDark)),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: VAColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, color: Colors.white, size: 13),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'MA BOUTIQUE',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: VAColors.black,
                          letterSpacing: 0.5),
                    ),
                    Text(
                      vendeur.username ?? '@${vendeur.nom.toLowerCase().replaceAll(' ', '')}',
                      style: const TextStyle(fontSize: 12, color: VAColors.grey),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: VAColors.greyLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close_rounded, size: 17, color: VAColors.greyText),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  ACTIONS RAPIDES
// ═══════════════════════════════════════════════════════════════════════════

class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
      child: Row(
        children: [
          // Paramètres
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: VAColors.greyLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.settings_outlined, size: 20, color: VAColors.greyText),
          ),
          const SizedBox(width: 8),
          // Aide
          Expanded(
            child: _ActionChip(
              icon: Icons.waving_hand_outlined,
              label: 'Obtenir de l\'aide',
              onTap: () {},
            ),
          ),
          const SizedBox(width: 8),
          // Partager
          Expanded(
            child: _ActionChip(
              icon: Icons.share_outlined,
              label: 'Partager',
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ActionChip({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: VAColors.greyLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 15, color: VAColors.greyText),
              const SizedBox(width: 5),
              Text(label,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600, color: VAColors.greyText)),
            ],
          ),
        ),
      );
}

// ═══════════════════════════════════════════════════════════════════════════
//  STATS
// ═══════════════════════════════════════════════════════════════════════════

class _StatsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Période + rapport
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: VAColors.greyLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('7 derniers jours',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600,
                            color: VAColors.black)),
                    SizedBox(width: 4),
                    Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: VAColors.grey),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: const Text('Rapport complet →',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600,
                        color: VAColors.primary)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Métriques
          Row(
            children: [
              const _StatTile(value: '0', label: 'Revenus', suffix: ' F'),
              _VLine(),
              const _StatTile(value: '0', label: 'Ventes'),
              _VLine(),
              const _StatTile(value: '0', label: 'Vues'),
              _VLine(),
              const _StatTile(value: '0', label: 'Abonnés'),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String value, label;
  final String suffix;
  const _StatTile({required this.value, required this.label, this.suffix = ''});

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$value$suffix',
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w800, color: VAColors.black),
            ),
            Text(label, style: const TextStyle(fontSize: 11, color: VAColors.grey)),
          ],
        ),
      );
}

class _VLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 32, color: VAColors.greyBorder,
          margin: const EdgeInsets.symmetric(horizontal: 10));
}

// ═══════════════════════════════════════════════════════════════════════════
//  TÂCHES À COMPLÉTER
// ═══════════════════════════════════════════════════════════════════════════

class _TaskSection extends StatelessWidget {
  final List<_Task> tasks;
  final int pending;
  final ValueChanged<int> onToggle;
  const _TaskSection({required this.tasks, required this.pending, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
          child: Text('À compléter',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: VAColors.black)),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < tasks.length; i++) ...[
                _TaskTile(
                  task: tasks[i],
                  onTap: () => onToggle(i),
                ),
                if (i < tasks.length - 1)
                  const Divider(height: 1, indent: 52, color: VAColors.greyBorder),
              ],
            ],
          ),
        ),
        if (pending > 0)
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              decoration: BoxDecoration(
                color: VAColors.greyLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Toutes les tâches · $pending',
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600, color: VAColors.greyText),
              ),
            ),
          ),
      ],
    );
  }
}

class _TaskTile extends StatelessWidget {
  final _Task task;
  final VoidCallback onTap;
  const _TaskTile({required this.task, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        child: Row(
          children: [
            // Icône emoji dans cercle coloré
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: task.accent == VAColors.purple
                    ? VAColors.purpleLight
                    : VAColors.greyLight,
                shape: BoxShape.circle,
              ),
              child: Center(child: Text(task.emoji, style: const TextStyle(fontSize: 16))),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(task.title,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: task.done ? VAColors.grey : VAColors.black,
                          decoration: task.done ? TextDecoration.lineThrough : null)),
                  if (task.sub != null && !task.done)
                    Text(task.sub!,
                        style: const TextStyle(fontSize: 11, color: VAColors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Icon(
              task.done ? Icons.check_circle_rounded : Icons.chevron_right_rounded,
              color: task.done ? VAColors.green : VAColors.grey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  MES ANNONCES (vide state)
// ═══════════════════════════════════════════════════════════════════════════

class _MyListings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Row(
            children: [
              Text('Mes annonces',
                  style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w800, color: VAColors.black)),
              Spacer(),
              Text('Tout voir',
                  style: TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w600, color: VAColors.primary)),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 36),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                    color: VAColors.greyLight, shape: BoxShape.circle),
                child: const Icon(Icons.inventory_2_outlined,
                    size: 26, color: VAColors.grey),
              ),
              const SizedBox(height: 12),
              const Text('Aucune annonce pour l\'instant',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,
                      color: VAColors.black)),
              const SizedBox(height: 4),
              const Text('Publiez votre premier produit',
                  style: TextStyle(fontSize: 12, color: VAColors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  BARRE DE PUBLICATION
// ═══════════════════════════════════════════════════════════════════════════

class _PublishBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 28),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Color(0x12000000), blurRadius: 16, offset: Offset(0, -4))],
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
                color: VAColors.primary.withValues(alpha: 0.35),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_rounded, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text(
                'Publier une annonce',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
