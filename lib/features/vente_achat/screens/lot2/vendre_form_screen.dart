import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/va_theme.dart';
import '../../models/export.dart';
import '../lot5/annonce_publiee_screen.dart';
import '../lot5/creation_widgets.dart';

@RoutePage()
class VendreFormScreen extends StatefulWidget {
  const VendreFormScreen({super.key});

  @override
  State<VendreFormScreen> createState() => _VendreFormScreenState();
}

class _VendreFormScreenState extends State<VendreFormScreen> {
  int _selectedCat   = 0;
  int _selectedEtat  = 0;

  final _titreCtrl = TextEditingController(text: 'iPhone 13 Pro 128Go');
  final _prixCtrl  = TextEditingController(text: '450 000');
  final _locCtrl   = TextEditingController(text: 'Cadjehoun, Cotonou');
  final _descCtrl  = TextEditingController();

  static const _categories = [
    (emoji: '📱', label: 'Téléphones'),
    (emoji: '👜', label: 'Mode'),
    (emoji: '🏠', label: 'Maison'),
    (emoji: '🚗', label: 'Auto'),
    (emoji: '💄', label: 'Beauté'),
    (emoji: '🖥',  label: 'High-tech'),
    (emoji: '⚽', label: 'Sport'),
    (emoji: '📚', label: 'Livres'),
  ];

  static const _etats = ['Neuf', 'Comme neuf', 'Bon état', 'Correct'];

  @override
  void dispose() {
    _titreCtrl.dispose();
    _prixCtrl.dispose();
    _locCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3EF),
      appBar: CreationAppBar(
        title: 'Nouvelle annonce',
        onBack: () => Navigator.of(context).pop(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Barre de progression ─────────────────────────────────────
            CreationStepBar(current: 2, total: 4),
            const SizedBox(height: 20),

            // ── Étape label ──────────────────────────────────────────────
            const Text('ÉTAPE 2 SUR 4',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                    color: VAColors.primary)),
            const SizedBox(height: 6),

            // ── Titre ────────────────────────────────────────────────────
            RichText(
              text: const TextSpan(
                style: TextStyle(fontFamily: 'Poppins', fontSize: 26,
                    height: 1.2, color: VAColors.black),
                children: [
                  TextSpan(text: 'Décrivez votre\n', style: TextStyle(fontWeight: FontWeight.w300)),
                  TextSpan(text: 'produit', style: TextStyle(fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // ── Formulaire dans une carte blanche ────────────────────────
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titre
                  _FormField(
                    label: 'Titre',
                    required: true,
                    child: _TextInput(controller: _titreCtrl, hint: 'Ex : iPhone 13 Pro 128Go'),
                  ),
                  const _Divider(),

                  // Catégorie
                  _FormField(
                    label: 'Catégorie',
                    required: true,
                    child: _CatChips(
                      items: _categories,
                      selected: _selectedCat,
                      onSelect: (i) => setState(() => _selectedCat = i),
                    ),
                  ),
                  const _Divider(),

                  // État
                  _FormField(
                    label: 'État',
                    required: true,
                    child: _EtatChips(
                      items: _etats,
                      selected: _selectedEtat,
                      onSelect: (i) => setState(() => _selectedEtat = i),
                    ),
                  ),
                  const _Divider(),

                  // Prix
                  _FormField(
                    label: 'Prix',
                    required: true,
                    child: _TextInput(
                      controller: _prixCtrl,
                      hint: '0',
                      suffix: 'FCFA',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  const _Divider(),

                  // Localisation
                  _FormField(
                    label: 'Localisation',
                    required: true,
                    child: _TextInput(
                      controller: _locCtrl,
                      hint: 'Votre ville ou quartier',
                      suffixIcon: Icons.location_on_outlined,
                    ),
                  ),
                  const _Divider(),

                  // Description
                  _FormField(
                    label: 'Description',
                    required: false,
                    child: TextField(
                      controller: _descCtrl,
                      maxLines: 4,
                      maxLength: 500,
                      decoration: InputDecoration(
                        hintText: 'Décrivez votre produit : état, accessoires inclus, raison de vente...',
                        hintStyle: const TextStyle(color: VAColors.grey, fontSize: 13, height: 1.5),
                        border: InputBorder.none,
                        counterStyle: const TextStyle(fontSize: 11, color: VAColors.grey),
                      ),
                      style: const TextStyle(fontSize: 14, color: VAColors.black, height: 1.5),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),

      // ── Bottom bar ───────────────────────────────────────────────────
      bottomNavigationBar: CreationBottomBar(
        onBack: () => Navigator.of(context).pop(),
        onNext: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AnnoncePubileeScreen(annonce: AnnoncesMock.iphone13),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
//  COMPOSANTS DU FORMULAIRE
// ═══════════════════════════════════════════════════════════════════════════

class _FormField extends StatelessWidget {
  final String label;
  final bool required;
  final Widget child;
  const _FormField({required this.label, required this.child, this.required = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w700, color: VAColors.black)),
            if (required)
              const Text(' *',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: VAColors.primary)),
          ],
        ),
        const SizedBox(height: 6),
        child,
        const SizedBox(height: 10),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) =>
      const Divider(height: 1, color: VAColors.greyBorder);
}

// ── Champ texte ─────────────────────────────────────────────────────────────

class _TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? suffix;
  final IconData? suffixIcon;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const _TextInput({
    required this.controller,
    required this.hint,
    this.suffix,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: VAColors.grey, fontSize: 14),
        border: InputBorder.none,
        suffixText: suffix,
        suffixStyle: const TextStyle(
            color: VAColors.primary, fontWeight: FontWeight.w700, fontSize: 14),
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, size: 18, color: VAColors.grey)
            : null,
        isDense: true,
        contentPadding: EdgeInsets.zero,
      ),
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: VAColors.black),
    );
  }
}

// ── Chips catégorie ──────────────────────────────────────────────────────────

class _CatChips extends StatelessWidget {
  final List<({String emoji, String label})> items;
  final int selected;
  final ValueChanged<int> onSelect;
  const _CatChips({required this.items, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final isSel = i == selected;
          return GestureDetector(
            onTap: () => onSelect(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: isSel ? VAColors.primaryLight : const Color(0xFFF5F3EF),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSel ? VAColors.primary : VAColors.greyBorder,
                  width: isSel ? 1.5 : 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(items[i].emoji, style: const TextStyle(fontSize: 13)),
                  const SizedBox(width: 5),
                  Text(items[i].label,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSel ? VAColors.primaryDark : VAColors.greyText)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Chips état ───────────────────────────────────────────────────────────────

class _EtatChips extends StatelessWidget {
  final List<String> items;
  final int selected;
  final ValueChanged<int> onSelect;
  const _EtatChips({required this.items, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: List.generate(items.length, (i) {
        final isSel = i == selected;
        return GestureDetector(
          onTap: () => onSelect(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: isSel ? VAColors.primaryLight : const Color(0xFFF5F3EF),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSel ? VAColors.primary : VAColors.greyBorder,
                width: isSel ? 1.5 : 1,
              ),
            ),
            child: Text(items[i],
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSel ? VAColors.primaryDark : VAColors.greyText)),
          ),
        );
      }),
    );
  }
}
