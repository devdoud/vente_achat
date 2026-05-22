import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../theme/va_theme.dart';
import '../../widgets/export.dart';
import '../../../domain/export.dart';

@RoutePage()
class EvaluationScreen extends StatefulWidget {
  final Annonce annonce;
  const EvaluationScreen({super.key, required this.annonce});

  @override
  State<EvaluationScreen> createState() => _EvaluationScreenState();
}

class _EvaluationScreenState extends State<EvaluationScreen> {
  int _note = 5;
  final Set<int> _selectedTags = {0, 1, 3};
  final _commentController = TextEditingController();

  static const _tags = ['Produit conforme', 'Vendeur sympa', 'Bon emballage', 'Communication', 'Livraison rapide', 'Bon prix'];
  static const _noteLabels = ['', 'Mauvais', 'Passable', 'Bien', 'Très bien', 'Excellent !'];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: VAAppBar(title: 'Évaluation'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(VAPadding.base),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              width: 64, height: 64,
              decoration: BoxDecoration(color: VAColors.primaryLight, borderRadius: BorderRadius.circular(VARadius.md)),
              child: Center(child: Text(widget.annonce.categorie.emoji, style: const TextStyle(fontSize: 32))),
            ),
            const SizedBox(height: 12),
            const Text('Comment s\'est passée\nvotre transaction ?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: VAColors.black), textAlign: TextAlign.center),
            const SizedBox(height: 4),
            Text('avec ${widget.annonce.vendeur.nom}', style: VATextStyles.caption),
            const SizedBox(height: 24),
            _StarRating(note: _note, onChanged: (v) => setState(() => _note = v)),
            const SizedBox(height: 4),
            Text(
              _noteLabels[_note],
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: VAColors.primary),
            ),
            const SizedBox(height: 24),
            _TagsSection(tags: _tags, selectedTags: _selectedTags, onToggle: (i) => setState(() {
              if (_selectedTags.contains(i)) { _selectedTags.remove(i); } else { _selectedTags.add(i); }
            })),
            const SizedBox(height: 24),
            _CommentField(controller: _commentController),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(VAPadding.base, VAPadding.sm, VAPadding.base, VAPadding.xl),
        child: VAPrimaryButton(label: 'Publier mon évaluation →', onPressed: () {}),
      ),
    );
  }
}

class _StarRating extends StatelessWidget {
  final int note;
  final ValueChanged<int> onChanged;
  const _StarRating({required this.note, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (i) {
        final filled = i < note;
        return GestureDetector(
          onTap: () => onChanged(i + 1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Container(
              width: 48, height: 48,
              decoration: BoxDecoration(
                color: filled ? VAColors.primary : VAColors.greyLight,
                borderRadius: BorderRadius.circular(VARadius.sm),
              ),
              child: Icon(Icons.star_rounded, color: filled ? Colors.white : VAColors.greyBorder, size: 28),
            ),
          ),
        );
      }),
    );
  }
}

class _TagsSection extends StatelessWidget {
  final List<String> tags;
  final Set<int> selectedTags;
  final ValueChanged<int> onToggle;
  const _TagsSection({required this.tags, required this.selectedTags, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(VAPadding.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(VARadius.md),
        border: Border.all(color: VAColors.greyBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VASectionLabel(text: 'Qu\'avez-vous apprécié ?'),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags.asMap().entries.map((e) {
              final isSelected = selectedTags.contains(e.key);
              return GestureDetector(
                onTap: () => onToggle(e.key),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? VAColors.primaryLight : Colors.white,
                    borderRadius: BorderRadius.circular(VARadius.xxl),
                    border: Border.all(color: isSelected ? VAColors.primary : VAColors.greyBorder, width: isSelected ? 1.5 : 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSelected) ...[const Icon(Icons.check, size: 14, color: VAColors.primary), const SizedBox(width: 4)],
                      Text(e.value, style: TextStyle(fontSize: 13, color: isSelected ? VAColors.primary : VAColors.greyText, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _CommentField extends StatelessWidget {
  final TextEditingController controller;
  const _CommentField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VASectionLabel(text: 'Commentaire (optionnel)'),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLength: 280,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Décrivez votre expérience...',
            hintStyle: const TextStyle(color: VAColors.grey, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(VAPadding.md),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(VARadius.md), borderSide: const BorderSide(color: VAColors.greyBorder)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(VARadius.md), borderSide: const BorderSide(color: VAColors.greyBorder)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(VARadius.md), borderSide: const BorderSide(color: VAColors.primary, width: 1.5)),
          ),
        ),
      ],
    );
  }
}
