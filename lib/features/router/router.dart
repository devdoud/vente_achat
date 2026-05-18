import 'package:achat_vente/core/page/webview_page.dart';
import 'package:achat_vente/features/vente_achat/models/annonce.dart';
import 'package:achat_vente/features/vente_achat/models/vendeur.dart';
import 'package:auto_route/auto_route.dart';
import 'package:achat_vente/features/vente_achat/screens/lot1/super_app_home_screen.dart';
import 'package:achat_vente/features/vente_achat/screens/lot1/va_home_screen.dart';
import 'package:achat_vente/features/vente_achat/screens/lot1/annonces_feed_screen.dart';
import 'package:achat_vente/features/vente_achat/screens/lot1/annonce_detail_screen.dart';
import 'package:achat_vente/features/vente_achat/screens/lot2/offre_sure_screen.dart';
import 'package:achat_vente/features/vente_achat/screens/lot2/vendre_form_screen.dart';
import 'package:achat_vente/features/vente_achat/screens/lot2/chat_screen.dart';
import 'package:achat_vente/features/vente_achat/screens/lot2/suivi_commande_screen.dart';
import 'package:achat_vente/features/vente_achat/screens/lot3/messages_screen.dart';
import 'package:achat_vente/features/vente_achat/screens/lot3/mes_annonces_screen.dart';
import 'package:achat_vente/features/vente_achat/screens/lot3/profil_screen.dart';
import 'package:achat_vente/features/vente_achat/screens/lot3/filtres_screen.dart';
import 'package:achat_vente/features/vente_achat/screens/lot4/confirmation_screen.dart';
import 'package:achat_vente/features/vente_achat/screens/lot4/evaluation_screen.dart';
import 'package:achat_vente/features/vente_achat/screens/lot4/favoris_screen.dart';
import 'package:achat_vente/features/vente_achat/screens/lot4/activite_screen.dart';
import 'package:achat_vente/features/vente_achat/screens/lot5/carte_proximite_screen.dart';
import 'package:achat_vente/features/vente_achat/screens/lot5/creation_annonce_photos_screen.dart';
import 'package:achat_vente/features/vente_achat/screens/lot5/boutique_pro_screen.dart';
import 'package:achat_vente/features/vente_achat/screens/lot5/annonce_publiee_screen.dart';
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
