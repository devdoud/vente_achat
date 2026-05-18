import 'package:achat_vente/core/page/webview_page.dart';
import 'package:achat_vente/features/vente_achat/domain/annonce.dart';
import 'package:achat_vente/features/vente_achat/domain/vendeur.dart';
import 'package:auto_route/auto_route.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/catalogue/super_app_home_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/catalogue/va_home_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/catalogue/annonces_feed_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/catalogue/annonce_detail_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/transaction/offre_sure_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/transaction/vendre_form_screen.dart';
import 'package:achat_vente/features/vente_achat/presentation/screens/transaction/chat_screen.dart';
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
import 'package:flutter/material.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SuperAppHomeRoute.page, initial: true),
        AutoRoute(page: VAHomeRoute.page),
        AutoRoute(page: AnnoncesFeedRoute.page),
        AutoRoute(page: AnnonceDetailRoute.page),
        AutoRoute(page: OffreSureRoute.page),
        AutoRoute(page: VendreFormRoute.page),
        AutoRoute(page: ChatRoute.page),
        AutoRoute(page: SuiviCommandeRoute.page),
        AutoRoute(page: MessagesRoute.page),
        AutoRoute(page: MesAnnoncesRoute.page),
        AutoRoute(page: ProfilRoute.page),
        AutoRoute(page: FiltresRoute.page),
        AutoRoute(page: ConfirmationRoute.page),
        AutoRoute(page: EvaluationRoute.page),
        AutoRoute(page: FavorisRoute.page),
        AutoRoute(page: ActiviteRoute.page),
        AutoRoute(page: CarteProximiteRoute.page),
        AutoRoute(page: CreationAnnoncePhotosRoute.page),
        AutoRoute(page: BoutiqueProRoute.page),
        AutoRoute(page: AnnoncePubileeRoute.page),
      ];
}
