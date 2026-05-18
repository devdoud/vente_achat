import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../theme/va_theme.dart';
import '../../widgets/export.dart';
import '../../../domain/export.dart';
import 'annonce_detail_screen.dart';

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
  static const _tabs = ['Tout', 'Près de moi', 'Récent'];
  static const _filterLabels = ['Filtres', 'Prix ↓', 'État', 'Marque'];

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

  @override
  Widget build(BuildContext context) {
    final title = widget.categorie?.label ?? 'Annonces';
    final annonces = widget.categorie == AnnonceCategorie.telephones
        ? AnnoncesMock.telephones
        : AnnoncesMock.all;

    return Scaffold(
      backgroundColor: VAColors.background,
      appBar: VAAppBar(
        title: title,
        actions: [IconButton(icon: const Icon(Icons.search_rounded), onPressed: () {})],
      ),
      body: Column(
        children: [
          _TabBar(controller: _tabController, tabs: _tabs),
          _FilterRow(
            labels: _filterLabels,
            selectedIndex: _filterIndex,
            onSelected: (i) => setState(() => _filterIndex = i),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(VAPadding.base),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemCount: annonces.length,
              itemBuilder: (_, i) => VAProductCard(
                annonce: annonces[i],
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => AnnonceDetailScreen(annonce: annonces[i])),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  final TabController controller;
  final List<String> tabs;
  const _TabBar({required this.controller, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: controller,
        tabs: tabs.asMap().entries.map((e) {
          final isFirst = e.key == 0;
          return Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(e.value),
                if (isFirst) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: VAColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text('142', style: TextStyle(fontSize: 10, color: VAColors.primary, fontWeight: FontWeight.w700)),
                  ),
                ],
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  const _FilterRow({required this.labels, required this.selectedIndex, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: VAPadding.base, vertical: 8),
        itemCount: labels.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) => VAFilterChip(
          label: labels[i],
          isSelected: i == selectedIndex,
          onTap: () => onSelected(i),
        ),
      ),
    );
  }
}
