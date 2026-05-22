import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../theme/va_theme.dart';
import '../../widgets/export.dart';
import '../../../domain/export.dart';
import '../vendeur/creation_annonce_photos_screen.dart';

@RoutePage()
class MesAnnoncesScreen extends StatefulWidget {
  const MesAnnoncesScreen({super.key});

  @override
  State<MesAnnoncesScreen> createState() => _MesAnnoncesScreenState();
}

class _MesAnnoncesScreenState extends State<MesAnnoncesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Annonce> _annoncesForTab(int index) {
    return switch (index) {
      0 => AnnoncesMock.all.where((a) => a.status == AnnonceStatus.active).toList(),
      1 => AnnoncesMock.all.where((a) => a.status == AnnonceStatus.enAttente).toList(),
      2 => AnnoncesMock.all.where((a) => a.status == AnnonceStatus.vendue).toList(),
      _ => AnnoncesMock.all,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: VAAppBar(
        title: 'Mes annonces',
        actions: [IconButton(icon: const Icon(Icons.search_rounded), onPressed: () {})],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              onTap: (_) => setState(() {}),
              tabs: [
                _Tab(label: 'Actives', count: 5),
                _Tab(label: 'En attente', count: 2),
                _Tab(label: 'Vendues', count: 12),
                _Tab(label: 'Brouillons'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(4, (i) {
                final annonces = _annoncesForTab(i);
                if (annonces.isEmpty) {
                  return const Center(child: Text('Aucune annonce', style: VATextStyles.caption));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(VAPadding.base),
                  itemCount: annonces.length,
                  itemBuilder: (_, j) => VAAnnonceListCard(
                    annonce: annonces[j],
                    onEdit: () {},
                    onOptions: () => _showOptions(context, annonces[j]),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const CreationAnnoncePhotosScreen()),
        ),
        backgroundColor: VAColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showOptions(BuildContext context, Annonce annonce) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(VARadius.lg))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(VAPadding.base),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 36, height: 4, decoration: BoxDecoration(color: VAColors.greyBorder, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 16),
            _OptionTile(icon: Icons.edit_outlined, label: 'Modifier l\'annonce', onTap: () => Navigator.pop(context)),
            _OptionTile(icon: Icons.pause_circle_outline, label: 'Mettre en pause', onTap: () => Navigator.pop(context)),
            _OptionTile(icon: Icons.delete_outline, label: 'Supprimer', color: VAColors.red, onTap: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final int? count;
  const _Tab({required this.label, this.count});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(fontSize: 13)),
          if (count != null) ...[
            const SizedBox(width: 4),
            Text('$count', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: VAColors.primary)),
          ],
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _OptionTile({required this.icon, required this.label, this.color = VAColors.black, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
      onTap: onTap,
    );
  }
}
