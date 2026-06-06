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
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey       = GlobalKey<FormState>();
  final _emailCtrl     = TextEditingController();
  final _passwordCtrl  = TextEditingController();
  bool _obscure        = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<AuthCubit>().login(
      email:    _emailCtrl.text.trim(),
      password: _passwordCtrl.text,
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
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 48),

                      // Logo
                      Container(
                        width: 56, height: 56,
                        decoration: BoxDecoration(
                          color: VAColors.primary,
                          borderRadius: BorderRadius.circular(VARadius.md),
                        ),
                        child: const Icon(Icons.shopping_bag_rounded, color: Colors.white, size: 28),
                      ),
                      const SizedBox(height: 24),

                      const Text('Connexion',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900,
                              color: VAColors.black, letterSpacing: -0.5)),
                      const SizedBox(height: 6),
                      const Text('Accédez à votre espace personnel',
                          style: VATextStyles.body),
                      const SizedBox(height: 40),

                      // Email
                      _Label('Adresse email'),
                      const SizedBox(height: 6),
                      _Field(
                        controller:   _emailCtrl,
                        hint:         'votre@email.com',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Champ requis';
                          if (!v.contains('@')) return 'Email invalide';
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),

                      // Mot de passe
                      _Label('Mot de passe'),
                      const SizedBox(height: 6),
                      _Field(
                        controller:      _passwordCtrl,
                        hint:            '••••••••',
                        obscure:         _obscure,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _submit(),
                        suffix: IconButton(
                          icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                              size: 20, color: VAColors.grey),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Champ requis';
                          if (v.length < 6) return 'Minimum 6 caractères';
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),

                      // Mot de passe oublié
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {},
                          child: const Text('Mot de passe oublié ?',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,
                                  color: VAColors.primary)),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Bouton connexion
                      VAPrimaryButton(
                        label: 'Se connecter',
                        isLoading: loading,
                        onPressed: loading ? null : _submit,
                      ),
                      const SizedBox(height: 20),

                      // Lien inscription
                      Center(
                        child: GestureDetector(
                          onTap: () => ctx.router.push(const RegisterRoute()),
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(fontSize: 14, color: VAColors.greyText),
                              children: [
                                TextSpan(text: 'Pas encore de compte ? '),
                                TextSpan(text: 'Créer un compte',
                                    style: TextStyle(
                                        color: VAColors.primary,
                                        fontWeight: FontWeight.w700)),
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
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) => Text(text,
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: VAColors.black));
}

class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onFieldSubmitted;

  const _Field({
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
    return TextFormField(
      controller:      controller,
      obscureText:     obscure,
      keyboardType:    keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      validator:       validator,
      style: const TextStyle(fontSize: 15, color: VAColors.black, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText:    hint,
        hintStyle:   const TextStyle(color: VAColors.grey, fontSize: 14),
        suffixIcon:  suffix,
        filled:      true,
        fillColor:   VAColors.greyLight,
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
    );
  }
}
