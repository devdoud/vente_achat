import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/injection/injection.dart';
import '../../theme/va_theme.dart';
import '../../../domain/export.dart';
import '../../../domain/models/product_creation_data.dart';
import '../../../logic/product_creation/product_creation_cubit.dart';
import 'annonce_pending_screen.dart';
import 'annonce_publiee_screen.dart';
import 'creation_widgets.dart';

// ─── Étape 3/3 — Justificatif + CGV + Publication ────────────────────────────

class JustificatifScreen extends StatefulWidget {
  final ProductCreationData data;
  const JustificatifScreen({super.key, required this.data});

  @override
  State<JustificatifScreen> createState() => _JustificatifScreenState();
}

class _JustificatifScreenState extends State<JustificatifScreen> {
  XFile? _justif;
  bool   _cgv = false;
  final  _picker = ImagePicker();
  late final ProductCreationCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<ProductCreationCubit>();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  Future<void> _pickDoc() async {
    final file = await _picker.pickImage(
        source: ImageSource.gallery, maxWidth: 1920, imageQuality: 90);
    if (file != null && mounted) setState(() => _justif = file);
  }

  void _showPickerSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _DocPickerSheet(
        onCamera: () {
          Navigator.pop(ctx);
          _pickFromSource(ImageSource.camera);
        },
        onGallery: () {
          Navigator.pop(ctx);
          _pickDoc();
        },
      ),
    );
  }

  Future<void> _pickFromSource(ImageSource source) async {
    final file = await _picker.pickImage(
        source: source, maxWidth: 1920, imageQuality: 90);
    if (file != null && mounted) setState(() => _justif = file);
  }

  void _publish() {
    _cubit.create(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<ProductCreationCubit, ProductCreationState>(
        listener: (ctx, state) {
          if (state is ProductCreationSuccess) {
            final photos = state.productBannerUrl != null ? [state.productBannerUrl!] : <String>[];
            final localPath = widget.data.photos.isNotEmpty
                ? widget.data.photos.first.path
                : null;
            final annonce = Annonce(
              id:              state.productId,
              titre:           state.productName,
              prix:            widget.data.price.toDouble(),
              localisation:    widget.data.location.isEmpty ? 'Bénin' : widget.data.location,
              categorie:       AnnonceCategorie.telephones,
              status:          state.isDraft ? AnnonceStatus.enAttente : AnnonceStatus.enLigne,
              vendeur:         VendeursMock.adjoa,
              description:     widget.data.description,
              photos:          photos,
              vues:            0,
              datePublication: DateTime.now(),
            );
            final screen = state.isDraft
                ? AnnoncePendingScreen(
                    annonce:        annonce,
                    productUuid:    state.productId,
                    localImagePath: localPath,
                  )
                : AnnoncePubileeScreen(annonce: annonce, localImagePath: localPath);
            Navigator.of(ctx).pushReplacement(
              MaterialPageRoute(builder: (_) => screen),
            );
          } else if (state is ProductCreationFailure) {
            ScaffoldMessenger.of(ctx)
              ..clearSnackBars()
              ..showSnackBar(SnackBar(
                content: Text(state.message,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                backgroundColor: VAColors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              ));
          }
        },
        builder: (ctx, state) {
          final isLoading = state is ProductCreationLoading;

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
                  CreationStepBar(current: 3, total: 3),
                  const SizedBox(height: 20),

                  const Text('ÉTAPE 3 SUR 3',
                      style: TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w700,
                          letterSpacing: 1.2, color: VAColors.primary)),
                  const SizedBox(height: 6),

                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 26,
                          height: 1.2, color: VAColors.black),
                      children: [
                        TextSpan(text: 'Avant de\n',
                            style: TextStyle(fontWeight: FontWeight.w300)),
                        TextSpan(text: 'publier',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Récap de l'annonce
                  _RecapCard(data: widget.data),
                  const SizedBox(height: 20),

                  // Justificatif
                  _SectionHeader(title: 'Justificatif de possession', badge: 'OPTIONNEL'),
                  const SizedBox(height: 6),
                  const Text(
                    'Facture, photo du carton ou emballage d\'origine',
                    style: TextStyle(fontSize: 12, color: VAColors.greyText),
                  ),
                  const SizedBox(height: 12),

                  _justif == null
                      ? _UploadZone(onTap: _showPickerSheet)
                      : _DocPreview(
                          file: _justif!,
                          onRemove: () => setState(() => _justif = null),
                        ),

                  const SizedBox(height: 12),
                  _InfoNote(
                    text: 'Les annonces avec justificatif se vendent 3× plus vite.',
                  ),
                  const SizedBox(height: 28),

                  // CGV
                  _SectionHeader(title: 'Conditions de vente', badge: 'REQUIS'),
                  const SizedBox(height: 12),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [BoxShadow(
                          color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 2))],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => _cgv = !_cgv),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _StyledCheckbox(value: _cgv),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'J\'accepte les conditions générales de vente',
                                      style: TextStyle(
                                          fontSize: 14, fontWeight: FontWeight.w600,
                                          color: VAColors.black, height: 1.4),
                                    ),
                                    const SizedBox(height: 4),
                                    GestureDetector(
                                      onTap: () {},
                                      child: const Text(
                                        'Lire les conditions →',
                                        style: TextStyle(
                                            color: VAColors.primary, fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Divider(height: 1, color: Color(0xFFF0F0F0)),
                        const SizedBox(height: 12),
                        const Text(
                          'En publiant, vous confirmez que cet article vous appartient et que les informations fournies sont exactes.',
                          style: TextStyle(fontSize: 11, color: VAColors.greyText, height: 1.55),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            bottomNavigationBar: CreationBottomBar(
              onBack: () => Navigator.of(context).pop(),
              onNext: (_cgv && !isLoading) ? _publish : null,
              canContinue: _cgv && !isLoading,
              nextLabel: isLoading ? 'Publication en cours...' : 'Publier mon annonce',
              isLoading: isLoading,
            ),
          );
        },
      ),
    );
  }
}

// ─── Récap de l'annonce avant publication ─────────────────────────────────────

class _RecapCard extends StatelessWidget {
  final ProductCreationData data;
  const _RecapCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: VAColors.greyLight,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // Miniature première photo
          if (data.photos.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(File(data.photos.first.path),
                  width: 52, height: 52, fit: BoxFit.cover),
            )
          else
            Container(
              width: 52, height: 52,
              decoration: BoxDecoration(
                  color: VAColors.primaryLight,
                  borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.image_outlined, color: VAColors.primary, size: 24),
            ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.name,
                    style: VATextStyles.bodyMedium,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text(data.categoryName,
                    style: VATextStyles.caption),
                const SizedBox(height: 2),
                Text(_fmt(data.price), style: VATextStyles.price),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                color: VAColors.greenLight, borderRadius: BorderRadius.circular(20)),
            child: Text('${data.photos.length} photo${data.photos.length > 1 ? 's' : ''}',
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700,
                    color: VAColors.green)),
          ),
        ],
      ),
    );
  }

  static String _fmt(int v) {
    if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M F';
    if (v >= 1000) {
      final e = v ~/ 1000;
      final r = v % 1000;
      return r == 0 ? '$e 000 F' : '$e ${r.toString().padLeft(3, '0')} F';
    }
    return '$v F';
  }
}

// ─── Composants ───────────────────────────────────────────────────────────────

class _DocPickerSheet extends StatelessWidget {
  final VoidCallback onCamera, onGallery;
  const _DocPickerSheet({required this.onCamera, required this.onGallery});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 24),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 36, height: 4,
            decoration: BoxDecoration(
                color: const Color(0xFFE0DDD8),
                borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(height: 18),
          const Text('Ajouter le justificatif',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 6),
          const Text('Photo de la facture ou du carton',
              style: TextStyle(fontSize: 12, color: VAColors.greyText)),
          const SizedBox(height: 16),
          _SheetOption(icon: Icons.camera_alt_outlined, color: VAColors.primary,
              label: 'Photographier le document', sub: 'Utiliser l\'appareil photo',
              onTap: onCamera),
          Divider(height: 1, indent: 66, color: Colors.grey.shade100),
          _SheetOption(icon: Icons.photo_library_outlined, color: const Color(0xFF6B7FD4),
              label: 'Choisir depuis la galerie', sub: 'Photo existante de la facture',
              onTap: onGallery),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _SheetOption extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label, sub;
  final VoidCallback onTap;
  const _SheetOption({required this.icon, required this.color,
      required this.label, required this.sub, required this.onTap});

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12), shape: BoxShape.circle),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    const SizedBox(height: 2),
                    Text(sub, style: const TextStyle(fontSize: 12, color: VAColors.greyText)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: VAColors.greyText, size: 20),
            ],
          ),
        ),
      );
}

class _SectionHeader extends StatelessWidget {
  final String title, badge;
  const _SectionHeader({required this.title, required this.badge});

  @override
  Widget build(BuildContext context) {
    final isRequired = badge == 'REQUIS';
    return Row(children: [
      Text(title, style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w700, color: VAColors.black)),
      const SizedBox(width: 8),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        decoration: BoxDecoration(
          color: isRequired ? VAColors.primaryLight : const Color(0xFFF0EDE8),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(badge, style: TextStyle(
            fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 0.5,
            color: isRequired ? VAColors.primaryDark : VAColors.greyText)),
      ),
    ]);
  }
}

class _UploadZone extends StatelessWidget {
  final VoidCallback onTap;
  const _UploadZone({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DashedBorder(
        child: Container(
          height: 110, width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(14)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 42, height: 42,
                decoration: BoxDecoration(
                    color: const Color(0xFFF0EDE8), shape: BoxShape.circle),
                child: const Icon(Icons.upload_file_outlined, size: 20, color: VAColors.grey),
              ),
              const SizedBox(height: 10),
              const Text('Ajouter une facture ou photo du carton',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: VAColors.black)),
              const SizedBox(height: 3),
              const Text('Galerie ou appareil photo',
                  style: TextStyle(fontSize: 11, color: VAColors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}

class _DocPreview extends StatelessWidget {
  final XFile file;
  final VoidCallback onRemove;
  const _DocPreview({required this.file, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.file(File(file.path),
              height: 140, width: double.infinity, fit: BoxFit.cover),
        ),
        Positioned(bottom: 8, left: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: VAColors.green, borderRadius: BorderRadius.circular(20)),
            child: const Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.check_circle_rounded, size: 12, color: Colors.white),
              SizedBox(width: 4),
              Text('Justificatif ajouté', style: TextStyle(
                  color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
            ]),
          )),
        Positioned(top: 8, right: 8,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 28, height: 28,
              decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55), shape: BoxShape.circle),
              child: const Icon(Icons.close, color: Colors.white, size: 14),
            ),
          )),
      ],
    );
  }
}

class _InfoNote extends StatelessWidget {
  final String text;
  const _InfoNote({required this.text});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: VAColors.primaryLight.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: VAColors.primaryLight),
        ),
        child: Row(
          children: [
            const Icon(Icons.lightbulb_outline_rounded, size: 18, color: VAColors.primaryDark),
            const SizedBox(width: 10),
            Expanded(
              child: Text(text, style: const TextStyle(
                  fontSize: 12, color: VAColors.primaryDark, height: 1.5)),
            ),
          ],
        ),
      );
}

class _StyledCheckbox extends StatelessWidget {
  final bool value;
  const _StyledCheckbox({required this.value});

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 22, height: 22,
        margin: const EdgeInsets.only(top: 1),
        decoration: BoxDecoration(
          color: value ? VAColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: value ? VAColors.primary : VAColors.greyBorder, width: 1.5),
          boxShadow: value
              ? [BoxShadow(color: VAColors.primary.withValues(alpha: 0.25), blurRadius: 6)]
              : null,
        ),
        child: value
            ? const Icon(Icons.check_rounded, size: 14, color: Colors.white)
            : null,
      );
}
