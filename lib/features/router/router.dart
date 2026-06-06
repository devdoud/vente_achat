import 'package:achat_vente/core/api/token_storage.dart';
import 'package:achat_vente/core/injection/injection.dart';
import 'package:achat_vente/features/vente_achat/data/sources/auth_remote_source.dart' show kDevAuthMode;
import 'package:achat_vente/core/page/webview_page.dart';
import 'package:achat_vente/features/vente_achat/domain/annonce.dart';
import 'package:achat_vente/features/vente_achat/domain/models/category_model.dart';
import 'package:achat_vente/features/vente_achat/domain/vendeur.dart';
import 'package:achat_vente/features/vente_achat/domain/models/order_model.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/auth/login_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/auth/register_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/catalogue/super_app_home_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/catalogue/va_home_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/catalogue/annonces_feed_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/catalogue/annonce_detail_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/transaction/offre_sure_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/transaction/vendre_form_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/transaction/chat_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/transaction/suivi_commande_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/compte/messages_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/compte/mes_annonces_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/compte/profil_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/compte/filtres_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/activite/confirmation_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/activite/evaluation_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/activite/favoris_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/activite/activite_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/vendeur/carte_proximite_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/vendeur/creation_annonce_photos_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/vendeur/boutique_pro_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/vendeur/annonce_publiee_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/compte/wallet_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

part 'router.gr.dart';

// ─── Guard ────────────────────────────────────────────────────────────────────
// Défini ici pour avoir accès aux routes générées (LoginRoute est dans router.gr.dart)

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (kDevAuthMode || getIt<TokenStorage>().hasToken) {
      resolver.next();
    } else {
      resolver.redirect(const LoginRoute());
    }
  }
}

// ─── Router ───────────────────────────────────────────────────────────────────

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        // App principale (initial en mode dev, login redirige ici après auth réelle)
        AutoRoute(page: SuperAppHomeRoute.page, initial: true, guards: [AuthGuard()]),

        // Auth
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: VAHomeRoute.page),
        AutoRoute(page: AnnoncesFeedRoute.page),
        AutoRoute(page: AnnonceDetailRoute.page),
        AutoRoute(page: OffreSureRoute.page,            guards: [AuthGuard()]),
        AutoRoute(page: VendreFormRoute.page,           guards: [AuthGuard()]),
        AutoRoute(page: ChatRoute.page,                 guards: [AuthGuard()]),
        AutoRoute(page: SuiviCommandeRoute.page,        guards: [AuthGuard()]),
        AutoRoute(page: MessagesRoute.page,             guards: [AuthGuard()]),
        AutoRoute(page: MesAnnoncesRoute.page,          guards: [AuthGuard()]),
        AutoRoute(page: ProfilRoute.page,               guards: [AuthGuard()]),
        AutoRoute(page: FiltresRoute.page),
        AutoRoute(page: ConfirmationRoute.page,         guards: [AuthGuard()]),
        AutoRoute(page: EvaluationRoute.page,           guards: [AuthGuard()]),
        AutoRoute(page: FavorisRoute.page,              guards: [AuthGuard()]),
        AutoRoute(page: ActiviteRoute.page,             guards: [AuthGuard()]),
        AutoRoute(page: CarteProximiteRoute.page),
        AutoRoute(page: CreationAnnoncePhotosRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: BoutiqueProRoute.page),
        AutoRoute(page: AnnoncePubileeRoute.page,       guards: [AuthGuard()]),
        AutoRoute(page: WalletRoute.page,               guards: [AuthGuard()]),
      ];
}
