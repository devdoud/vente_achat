import 'package:flutter/material.dart';
import '../../theme/va_theme.dart';
import '../../../domain/export.dart';
import '../compte/filtres_screen.dart';
import 'annonce_detail_screen.dart';

// ═══════════════════════════════════════════════════════════════════════════
//  RECHERCHE — plein écran avec résultats live
// ═══════════════════════════════════════════════════════════════════════════

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _ctrl  = TextEditingController();
  final _focus = FocusNode();
  String _query = '';

  // Recherches récentes (mockées en session)
  final List<String> _recent = [
    'iPhone 13', 'Robe wax', 'Table basse', 'Vélo', 'Ordinateur portable',
  ];

  List<Annonce> get _results {
    if (_query.trim().isEmpty) return [];
    final q = _query.toLowerCase();
    return AnnoncesMock.all.where((a) =>
        a.titre.toLowerCase().contains(q) ||
        a.categorie.name.toLowerCase().contains(q) ||
        a.vendeur.nom.toLowerCase().contains(q) ||
        a.localisation.toLowerCase().contains(q)).toList();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _focus.requestFocus());
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _onSearch(String q) => setState(() => _query = q);

  void _selectRecent(String term) {
    _ctrl.text = term;
    _ctrl.selection = TextSelection.fromPosition(
        TextPosition(offset: term.length));
    setState(() => _query = term);
  }

  void _addAndSearch(String term) {
    if (term.trim().isEmpty) return;
    if (!_recent.contains(term)) {
      setState(() {
        _recent.insert(0, term);
        if (_recent.length > 8) _recent.removeLast();
      });
    }
    _focus.unfocus();
  }

  void _removeRecent(String term) =>
      setState(() => _recent.remove(term));

  void _clearAll() => setState(() => _recent.clear());

  void _openFilters() => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => const FiltresScreen(),
      );

  @override
  Widget build(BuildContext context) {
    final statusH = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3EF),
      body: Column(
        children: [
          // ── Barre de recherche ─────────────────────────────────────────
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(12, statusH + 8, 12, 12),
            child: Row(
              children: [
                // Retour
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 38, height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F3EF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_rounded,
                        size: 15, color: VAColors.black),
                  ),
                ),
                const SizedBox(width: 8),

                // Champ de texte
                Expanded(
                  child: Container(
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F3EF),
                      borderRadius: BorderRadius.circular(23),
                    ),
                    child: TextField(
                      controller: _ctrl,
                      focusNode: _focus,
                      textInputAction: TextInputAction.search,
                      onChanged: _onSearch,
                      onSubmitted: _addAndSearch,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: VAColors.black),
                      decoration: InputDecoration(
                        hintText: 'Que cherchez-vous ?',
                        hintStyle: const TextStyle(
                            color: Color(0xFFBBBBBB), fontSize: 14),
                        prefixIcon: const Icon(Icons.search_rounded,
                            color: VAColors.primary, size: 20),
                        suffixIcon: _query.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  _ctrl.clear();
                                  setState(() => _query = '');
                                  _focus.requestFocus();
                                },
                                child: const Icon(Icons.close_rounded,
                                    color: VAColors.grey, size: 18),
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 12),
                        isDense: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Bouton filtre
                GestureDetector(
                  onTap: _openFilters,
                  child: Container(
                    width: 42, height: 42,
                    decoration: BoxDecoration(
                      color: VAColors.primary,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: VAColors.primary.withValues(alpha: 0.30),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.tune_rounded,
                        color: Colors.white, size: 18),
                  ),
                ),
              ],
            ),
          ),

          // ── Contenu ────────────────────────────────────────────────────
          Expanded(
            child: _query.isEmpty
                ? _EmptyState(
                    recent: _recent,
                    onSelect: _selectRecent,
                    onRemove: _removeRecent,
                    onClearAll: _clearAll,
                  )
                : _ResultsView(
                    query: _query,
                    results: _results,
                  ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  ÉTAT VIDE — recherches récentes + catégories
// ═══════════════════════════════════════════════════════════════════════════

class _EmptyState extends StatelessWidget {
  final List<String> recent;
  final ValueChanged<String> onSelect;
  final ValueChanged<String> onRemove;
  final VoidCallback onClearAll;

  const _EmptyState({
    required this.recent,
    required this.onSelect,
    required this.onRemove,
    required this.onClearAll,
  });

  static const _popularCats = [
    (emoji: '📱', label: 'Téléphones'),
    (emoji: '👜', label: 'Mode'),
    (emoji: '🏠', label: 'Maison'),
    (emoji: '🚗', label: 'Auto'),
    (emoji: '💄', label: 'Beauté'),
    (emoji: '🖥',  label: 'High-tech'),
    (emoji: '⚽', label: 'Sport'),
    (emoji: '📚', label: 'Livres'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Recherches récentes
          if (recent.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Recherches récentes',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: VAColors.black)),
                GestureDetector(
                  onTap: onClearAll,
                  child: const Text('Tout effacer',
                      style: TextStyle(
                          fontSize: 12,
                          color: VAColors.primary,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: recent.map((term) => _RecentChip(
                    term: term,
                    onSelect: () => onSelect(term),
                    onRemove: () => onRemove(term),
                  )).toList(),
            ),
            const SizedBox(height: 28),
          ],

          // Catégories populaires
          const Text('Catégories populaires',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: VAColors.black)),
          const SizedBox(height: 10),
          SizedBox(
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 2),
              itemCount: _popularCats.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final c = _popularCats[i];
                return GestureDetector(
                  onTap: () => onSelect(c.label),
                  child: Container(
                    width: 72,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: const Color(0xFFEEEBE5), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(c.emoji,
                            style: const TextStyle(fontSize: 26)),
                        const SizedBox(height: 5),
                        Text(
                          c.label,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: VAColors.black),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentChip extends StatelessWidget {
  final String term;
  final VoidCallback onSelect, onRemove;
  const _RecentChip(
      {required this.term,
      required this.onSelect,
      required this.onRemove});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onSelect,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFEEEEEE)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.history_rounded,
                  size: 13, color: VAColors.grey),
              const SizedBox(width: 6),
              Text(term,
                  style: const TextStyle(
                      fontSize: 12,
                      color: VAColors.black,
                      fontWeight: FontWeight.w500)),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: onRemove,
                child: const Icon(Icons.close_rounded,
                    size: 13, color: VAColors.grey),
              ),
            ],
          ),
        ),
      );
}

// ═══════════════════════════════════════════════════════════════════════════
//  RÉSULTATS
// ═══════════════════════════════════════════════════════════════════════════

class _ResultsView extends StatelessWidget {
  final String query;
  final List<Annonce> results;
  const _ResultsView({required this.query, required this.results});

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🔍', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 16),
            Text('Aucun résultat pour\n"$query"',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: VAColors.black,
                    height: 1.4)),
            const SizedBox(height: 8),
            const Text('Essayez un autre mot-clé\nou utilisez les filtres.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13,
                    color: VAColors.greyText,
                    height: 1.5)),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontSize: 13, color: VAColors.greyText),
              children: [
                TextSpan(
                    text: '${results.length} résultat${results.length > 1 ? 's' : ''} ',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: VAColors.black)),
                TextSpan(text: 'pour "$query"'),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
            itemCount: results.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, i) =>
                _ResultTile(annonce: results[i]),
          ),
        ),
      ],
    );
  }
}

class _ResultTile extends StatelessWidget {
  final Annonce annonce;
  const _ResultTile({required this.annonce});

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

  Color _catBg(AnnonceCategorie cat) =>
      _catColors[cat] ?? VAColors.primaryLight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_) => AnnonceDetailScreen(annonce: annonce)),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: Color(0x07000000),
                blurRadius: 8,
                offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            // Placeholder catégorie (photos vides dans les mocks)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 72, height: 72,
                color: _catBg(annonce.categorie),
                child: Center(
                  child: Text(annonce.categorie.emoji,
                      style: const TextStyle(fontSize: 28)),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Infos
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(annonce.titre,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: VAColors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0EDE8),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          annonce.isPro ? 'Pro' : 'Particulier',
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: VAColors.greyText),
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.location_on_outlined,
                          size: 11, color: VAColors.grey),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          annonce.localisation,
                          style: const TextStyle(
                              fontSize: 11, color: VAColors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${annonce.prix.toInt()} F',
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: VAColors.primary),
                  ),
                ],
              ),
            ),

            const Icon(Icons.chevron_right_rounded,
                color: VAColors.greyBorder, size: 20),
          ],
        ),
      ),
    );
  }
}
