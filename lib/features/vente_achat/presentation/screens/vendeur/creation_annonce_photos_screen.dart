import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../theme/va_theme.dart';
import '../transaction/vendre_form_screen.dart';
import 'creation_widgets.dart';

@RoutePage()
class CreationAnnoncePhotosScreen extends StatefulWidget {
  const CreationAnnoncePhotosScreen({super.key});

  @override
  State<CreationAnnoncePhotosScreen> createState() =>
      _CreationAnnoncePhotosScreenState();
}

class _CreationAnnoncePhotosScreenState
    extends State<CreationAnnoncePhotosScreen> {
  final List<XFile> _photos = [];
  final _picker = ImagePicker();
  bool _picking = false;

  static const int _maxPhotos = 10;

  Future<void> _pickFromCamera() async {
    if (_photos.length >= _maxPhotos || _picking) return;
    setState(() => _picking = true);
    try {
      final file = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1080,
        imageQuality: 85,
      );
      if (file != null && mounted) setState(() => _photos.add(file));
    } finally {
      if (mounted) setState(() => _picking = false);
    }
  }

  Future<void> _pickFromGallery() async {
    if (_picking) return;
    setState(() => _picking = true);
    try {
      final remaining = _maxPhotos - _photos.length;
      final files = await _picker.pickMultiImage(
        maxWidth: 1080,
        imageQuality: 85,
        limit: remaining,
      );
      if (files.isNotEmpty && mounted) {
        setState(() => _photos.addAll(files.take(remaining)));
      }
    } finally {
      if (mounted) setState(() => _picking = false);
    }
  }

  void _showPickerSheet() {
    if (_photos.length >= _maxPhotos || _picking) return;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => _PickerSheet(
        onCamera: () {
          Navigator.pop(ctx);
          _pickFromCamera();
        },
        onGallery: () {
          Navigator.pop(ctx);
          _pickFromGallery();
        },
      ),
    );
  }

  void _removePhoto(int index) => setState(() => _photos.removeAt(index));

  void _setAsPrimary(int index) {
    if (index == 0) return;
    setState(() {
      final photo = _photos.removeAt(index);
      _photos.insert(0, photo);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool hasFull = _photos.length >= _maxPhotos;

    return Scaffold(
      backgroundColor: Colors.white,
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
            CreationStepBar(current: 1, total: 3),
            const SizedBox(height: 20),

            const Text('ÉTAPE 1 SUR 3',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                    color: VAColors.primary)),
            const SizedBox(height: 6),

            RichText(
              text: const TextSpan(
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 26,
                    height: 1.2,
                    color: VAColors.black),
                children: [
                  TextSpan(
                      text: 'Ajoutez vos\n',
                      style: TextStyle(fontWeight: FontWeight.w300)),
                  TextSpan(
                      text: 'photos',
                      style: TextStyle(fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            const SizedBox(height: 4),
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 13, color: VAColors.greyText),
                children: [
                  TextSpan(text: 'La '),
                  TextSpan(
                      text: 'première photo',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: VAColors.black)),
                  TextSpan(text: 'est la plus importante.'),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // Zone d'upload principale
            _UploadZone(
              onTap: _showPickerSheet,
              picking: _picking,
              isFull: hasFull,
              count: _photos.length,
            ),
            const SizedBox(height: 14),

            _TipRow(Icons.check_circle_outline_rounded,
                '5 photos minimum pour de meilleurs résultats'),
            const SizedBox(height: 8),
            _TipRow(Icons.check_circle_outline_rounded,
                'Bonne luminosité et fond neutre recommandés'),

            if (_photos.isNotEmpty) ...[
              const SizedBox(height: 22),
              _PhotoGrid(
                photos: _photos,
                onRemove: _removePhoto,
                onAdd: _showPickerSheet,
                onSetPrimary: _setAsPrimary,
                isFull: hasFull,
              ),
            ],

            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: CreationBottomBar(
        onBack: () => Navigator.of(context).pop(),
        onNext: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const VendreFormScreen()),
        ),
        canContinue: _photos.isNotEmpty,
      ),
    );
  }
}

// 
//  PICKER BOTTOM SHEET
// 

class _PickerSheet extends StatelessWidget {
  final VoidCallback onCamera;
  final VoidCallback onGallery;
  const _PickerSheet({required this.onCamera, required this.onGallery});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFE0DDD8),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 18),
          const Text('Ajouter des photos',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 6),
          const Text('Choisissez votre source',
              style: TextStyle(fontSize: 12, color: VAColors.greyText)),
          const SizedBox(height: 16),
          _SheetOption(
            icon: Icons.camera_alt_outlined,
            color: VAColors.primary,
            label: 'Prendre une photo',
            sub: 'Utiliser l\'appareil photo',
            onTap: onCamera,
          ),
          Divider(height: 1, indent: 66, color: Colors.grey.shade100),
          _SheetOption(
            icon: Icons.photo_library_outlined,
            color: const Color(0xFF6B7FD4),
            label: 'Choisir depuis la galerie',
            sub: 'Sélection multiple possible',
            onTap: onGallery,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _SheetOption extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String sub;
  final VoidCallback onTap;
  const _SheetOption(
      {required this.icon,
      required this.color,
      required this.label,
      required this.sub,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(sub,
                      style: const TextStyle(
                          fontSize: 12, color: VAColors.greyText)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                color: VAColors.greyText, size: 20),
          ],
        ),
      ),
    );
  }
}

// 
//  ZONE D'UPLOAD
// 

class _UploadZone extends StatelessWidget {
  final VoidCallback onTap;
  final bool picking;
  final bool isFull;
  final int count;
  const _UploadZone(
      {required this.onTap,
      required this.picking,
      required this.isFull,
      required this.count});

  @override
  Widget build(BuildContext context) {
    final color = isFull ? const Color(0xFFB0ADA8) : VAColors.primary;
    return GestureDetector(
      onTap: (isFull || picking) ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 160,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.28),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: -22,
              right: -22,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -30,
              left: 20,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.06),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Center(
              child: picking
                  ? const SizedBox(
                      width: 32,
                      height: 32,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2.5))
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.20),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFull
                                ? Icons.check_circle_outline_rounded
                                : Icons.camera_alt_outlined,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          isFull
                              ? 'Limite atteinte ($count/$count)'
                              : count == 0
                                  ? 'Prendre une photo'
                                  : 'Ajouter d\'autres photos',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        ),
                        if (!isFull) ...[
                          const SizedBox(height: 3),
                          Text(
                            count == 0
                                ? 'ou choisir depuis la galerie'
                                : '${10 - count} emplacement(s) restant(s)',
                            style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.75),
                                fontSize: 12),
                          ),
                        ],
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// 
//  GRILLE PHOTOS
// 

class _PhotoGrid extends StatelessWidget {
  final List<XFile> photos;
  final ValueChanged<int> onRemove;
  final VoidCallback onAdd;
  final ValueChanged<int> onSetPrimary;
  final bool isFull;
  const _PhotoGrid(
      {required this.photos,
      required this.onRemove,
      required this.onAdd,
      required this.onSetPrimary,
      required this.isFull});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'PHOTOS (${photos.length}/10)',
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: VAColors.grey),
            ),
            if (!isFull)
              Text(
                'Appuyez pour définir la principale',
                style: const TextStyle(fontSize: 10, color: VAColors.greyText),
              ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 92,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              ...photos.asMap().entries.map((e) => _PhotoTile(
                    key: ValueKey(e.value.path),
                    photo: e.value,
                    index: e.key,
                    onRemove: () => onRemove(e.key),
                    onSetPrimary: () => onSetPrimary(e.key),
                  )),
              if (!isFull)
                GestureDetector(
                  onTap: onAdd,
                  child: Container(
                    width: 82,
                    height: 82,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: VAColors.greyBorder, width: 1.5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add_rounded,
                            color: VAColors.grey, size: 24),
                        const SizedBox(height: 2),
                        Text('Ajouter',
                            style: TextStyle(
                                fontSize: 9,
                                color: VAColors.grey,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PhotoTile extends StatelessWidget {
  final XFile photo;
  final int index;
  final VoidCallback onRemove;
  final VoidCallback onSetPrimary;
  const _PhotoTile(
      {super.key,
      required this.photo,
      required this.index,
      required this.onRemove,
      required this.onSetPrimary});

  @override
  Widget build(BuildContext context) {
    final isPrimary = index == 0;
    return GestureDetector(
      onTap: isPrimary ? null : onSetPrimary,
      child: Container(
        width: 82,
        height: 82,
        margin: const EdgeInsets.only(right: 8),
        child: Stack(
          children: [
            // Image réelle
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(photo.path),
                width: 82,
                height: 82,
                fit: BoxFit.cover,
              ),
            ),
            // Dégradé bas
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 28,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.55),
                      Colors.transparent,
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
              ),
            ),
            // Badge principale
            if (isPrimary)
              Positioned(
                bottom: 5,
                left: 5,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: VAColors.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('PRINCIPALE',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 7,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.3)),
                ),
              )
            else
              Positioned(
                bottom: 4,
                left: 5,
                child: Text(
                  'Définir principale',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 7,
                      fontWeight: FontWeight.w600),
                ),
              ),
            // Bouton supprimer
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.60),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close,
                      color: Colors.white, size: 12),
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
//  TIP ROW
// 

class _TipRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _TipRow(this.icon, this.text);

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Icon(icon, color: VAColors.primary, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 12, color: VAColors.greyText)),
          ),
        ],
      );
}
