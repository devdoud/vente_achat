import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/injection/injection.dart';
import '../../theme/va_theme.dart';
import '../../widgets/export.dart';
import '../../../domain/models/product_model.dart';
import '../../../logic/product_creation/product_creation_cubit.dart';

/// Bottom sheet d'édition d'un produit existant.
/// Retourne `true` si le produit a été modifié avec succès.
Future<bool?> showProductEditSheet(BuildContext context, Product product) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (_) => BlocProvider(
      create: (_) => getIt<ProductCreationCubit>(),
      child: _ProductEditSheet(product: product),
    ),
  );
}

class _ProductEditSheet extends StatefulWidget {
  final Product product;
  const _ProductEditSheet({required this.product});

  @override
  State<_ProductEditSheet> createState() => _ProductEditSheetState();
}

class _ProductEditSheetState extends State<_ProductEditSheet> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _priceCtrl;
  late final TextEditingController _descCtrl;
  late final TextEditingController _stockCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl  = TextEditingController(text: widget.product.name);
    _priceCtrl = TextEditingController(text: widget.product.price.toString());
    _descCtrl  = TextEditingController(text: widget.product.description);
    _stockCtrl = TextEditingController(text: widget.product.stock.toString());
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    _descCtrl.dispose();
    _stockCtrl.dispose();
    super.dispose();
  }

  void _save() {
    final name  = _nameCtrl.text.trim();
    final price = int.tryParse(_priceCtrl.text.trim());
    final stock = int.tryParse(_stockCtrl.text.trim());
    if (name.isEmpty || price == null || price <= 0) return;

    final fields = <String, dynamic>{
      'name':        name,
      'price':       price,
      'description': _descCtrl.text.trim(),
      if (stock != null && stock >= 0) 'stock': stock,
    };
    context.read<ProductCreationCubit>().update(
      productUuid: widget.product.uuid,
      fields: fields,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCreationCubit, ProductCreationState>(
      listener: (ctx, state) {
        if (state is ProductUpdateSuccess) {
          Navigator.of(ctx).pop(true);
        } else if (state is ProductCreationFailure) {
          ScaffoldMessenger.of(ctx)
            ..clearSnackBars()
            ..showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: VAColors.red,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            ));
        }
      },
      builder: (ctx, state) {
        final isLoading = state is ProductCreationLoading;
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20, 20, 20,
            MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 36, height: 4,
                  decoration: BoxDecoration(
                      color: VAColors.greyBorder,
                      borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 18),

              // Titre
              const Text('Modifier le produit',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: VAColors.black)),
              const SizedBox(height: 20),

              // Nom
              _Field(
                controller: _nameCtrl,
                label: 'Nom du produit',
                hint: 'Ex: iPhone 13 Pro 128Go',
              ),
              const SizedBox(height: 12),

              // Prix + Stock (côte à côte)
              Row(
                children: [
                  Expanded(
                    child: _Field(
                      controller: _priceCtrl,
                      label: 'Prix (FCFA)',
                      hint: '0',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _Field(
                      controller: _stockCtrl,
                      label: 'Stock',
                      hint: '1',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Description
              _Field(
                controller: _descCtrl,
                label: 'Description',
                hint: 'Décrivez votre produit...',
                maxLines: 3,
              ),
              const SizedBox(height: 20),

              // Bouton sauvegarder
              VAPrimaryButton(
                label: isLoading ? 'Enregistrement...' : 'Enregistrer les modifications',
                isLoading: isLoading,
                onPressed: isLoading ? null : _save,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String label, hint;
  final int maxLines;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const _Field({
    required this.controller,
    required this.label,
    required this.hint,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, color: VAColors.greyText)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          style: const TextStyle(fontSize: 14, color: VAColors.black),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: VAColors.grey, fontSize: 14),
            filled: true,
            fillColor: VAColors.greyLight,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: VAColors.primary, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            isDense: true,
          ),
        ),
      ],
    );
  }
}
