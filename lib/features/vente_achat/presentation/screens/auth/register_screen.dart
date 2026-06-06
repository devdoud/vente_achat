import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/failures.dart';
import 'package:achat_vente/features/router/router.dart';
import '../../theme/va_theme.dart';
import '../../widgets/export.dart';
import '../../../logic/auth/auth_cubit.dart';
import '../../../logic/auth/auth_state.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey       = GlobalKey<FormState>();
  final _firstCtrl     = TextEditingController();
  final _lastCtrl      = TextEditingController();
  final _emailCtrl     = TextEditingController();
  final _phoneCtrl     = TextEditingController();
  final _passCtrl      = TextEditingController();
  bool  _obscure       = true;
  bool  _cgv           = false;

  @override
  void dispose() {
    _firstCtrl.dispose();
    _lastCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (!_cgv) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Veuillez accepter les conditions d\'utilisation'),
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }
    context.read<AuthCubit>().register(
      email:     _emailCtrl.text.trim(),
      password:  _passCtrl.text,
      firstName: _firstCtrl.text.trim(),
      lastName:  _lastCtrl.text.trim(),
      phone:     _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (ctx, state) {
        if (state is AuthAuthenticated) {
          ctx.router.replaceAll([const SuperAppHomeRoute()]);
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(ctx)
            ..clearSnackBars()
            ..showSnackBar(SnackBar(
              content: Text(state.failure.toMsg,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              backgroundColor: VAColors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            ));
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (ctx, state) {
          final loading = state is AuthLoading;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: VAAppBar(title: 'Créer un compte'),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    const Text('Rejoignez-nous',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900,
                            color: VAColors.black, letterSpacing: -0.5)),
                    const SizedBox(height: 4),
                    const Text('Créez votre compte en quelques secondes',
                        style: VATextStyles.body),
                    const SizedBox(height: 32),

                    // Prénom + Nom côte à côte
                    Row(
                      children: [
                        Expanded(child: _LabeledField(
                          label: 'Prénom',
                          controller: _firstCtrl,
                          hint: 'Kofi',
                          textInputAction: TextInputAction.next,
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Requis' : null,
                        )),
                        const SizedBox(width: 12),
                        Expanded(child: _LabeledField(
                          label: 'Nom',
                          controller: _lastCtrl,
                          hint: 'Mensah',
                          textInputAction: TextInputAction.next,
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Requis' : null,
                        )),
                      ],
                    ),
                    const SizedBox(height: 18),

                    _LabeledField(
                      label: 'Adresse email',
                      controller: _emailCtrl,
                      hint: 'votre@email.com',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Requis';
                        if (!v.contains('@')) return 'Email invalide';
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),

                    _LabeledField(
                      label: 'Téléphone (optionnel)',
                      controller: _phoneCtrl,
                      hint: '+229 XX XX XX XX',
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 18),

                    _LabeledField(
                      label: 'Mot de passe',
                      controller: _passCtrl,
                      hint: '••••••••',
                      obscure: _obscure,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submit(),
                      suffix: IconButton(
                        icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                            size: 20, color: VAColors.grey),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Requis';
                        if (v.length < 8) return 'Minimum 8 caractères';
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // CGV
                    GestureDetector(
                      onTap: () => setState(() => _cgv = !_cgv),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 20, height: 20,
                            decoration: BoxDecoration(
                              color: _cgv ? VAColors.primary : Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: _cgv ? VAColors.primary : VAColors.greyBorder,
                                width: 1.5,
                              ),
                            ),
                            child: _cgv
                                ? const Icon(Icons.check_rounded, size: 14, color: Colors.white)
                                : null,
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text.rich(
                              TextSpan(
                                style: TextStyle(fontSize: 13, color: VAColors.greyText),
                                children: [
                                  TextSpan(text: "J'accepte les "),
                                  TextSpan(text: "conditions d'utilisation",
                                      style: TextStyle(color: VAColors.primary, fontWeight: FontWeight.w700)),
                                  TextSpan(text: " et la "),
                                  TextSpan(text: "politique de confidentialité",
                                      style: TextStyle(color: VAColors.primary, fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    VAPrimaryButton(
                      label: 'Créer mon compte',
                      isLoading: loading,
                      onPressed: loading ? null : _submit,
                    ),
                    const SizedBox(height: 20),

                    Center(
                      child: GestureDetector(
                        onTap: () => Navigator.of(ctx).pop(),
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(fontSize: 14, color: VAColors.greyText),
                            children: [
                              TextSpan(text: 'Déjà un compte ? '),
                              TextSpan(text: 'Se connecter',
                                  style: TextStyle(color: VAColors.primary, fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onFieldSubmitted;

  const _LabeledField({
    required this.label,
    required this.controller,
    required this.hint,
    this.obscure = false,
    this.keyboardType,
    this.textInputAction,
    this.suffix,
    this.validator,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: VAColors.black)),
        const SizedBox(height: 6),
        TextFormField(
          controller:       controller,
          obscureText:      obscure,
          keyboardType:     keyboardType,
          textInputAction:  textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          validator:        validator,
          style: const TextStyle(fontSize: 15, color: VAColors.black, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            hintText:   hint,
            hintStyle:  const TextStyle(color: VAColors.grey, fontSize: 14),
            suffixIcon: suffix,
            filled:     true,
            fillColor:  VAColors.greyLight,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(VARadius.md),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(VARadius.md),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(VARadius.md),
              borderSide: const BorderSide(color: VAColors.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(VARadius.md),
              borderSide: const BorderSide(color: VAColors.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(VARadius.md),
              borderSide: const BorderSide(color: VAColors.red, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}
