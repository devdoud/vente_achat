// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [ActiviteScreen]
class ActiviteRoute extends PageRouteInfo<void> {
  const ActiviteRoute({List<PageRouteInfo>? children})
    : super(ActiviteRoute.name, initialChildren: children);

  static const String name = 'ActiviteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ActiviteScreen();
    },
  );
}

/// generated route for
/// [AnnonceDetailScreen]
class AnnonceDetailRoute extends PageRouteInfo<AnnonceDetailRouteArgs> {
  AnnonceDetailRoute({
    Key? key,
    required Annonce annonce,
    List<PageRouteInfo>? children,
  }) : super(
         AnnonceDetailRoute.name,
         args: AnnonceDetailRouteArgs(key: key, annonce: annonce),
         initialChildren: children,
       );

  static const String name = 'AnnonceDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AnnonceDetailRouteArgs>();
      return AnnonceDetailScreen(key: args.key, annonce: args.annonce);
    },
  );
}

class AnnonceDetailRouteArgs {
  const AnnonceDetailRouteArgs({this.key, required this.annonce});

  final Key? key;

  final Annonce annonce;

  @override
  String toString() {
    return 'AnnonceDetailRouteArgs{key: $key, annonce: $annonce}';
  }
}

/// generated route for
/// [AnnoncePubileeScreen]
class AnnoncePubileeRoute extends PageRouteInfo<AnnoncePubileeRouteArgs> {
  AnnoncePubileeRoute({
    Key? key,
    required Annonce annonce,
    String? localImagePath,
    List<PageRouteInfo>? children,
  }) : super(
         AnnoncePubileeRoute.name,
         args: AnnoncePubileeRouteArgs(
           key: key,
           annonce: annonce,
           localImagePath: localImagePath,
         ),
         initialChildren: children,
       );

  static const String name = 'AnnoncePubileeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AnnoncePubileeRouteArgs>();
      return AnnoncePubileeScreen(
        key: args.key,
        annonce: args.annonce,
        localImagePath: args.localImagePath,
      );
    },
  );
}

class AnnoncePubileeRouteArgs {
  const AnnoncePubileeRouteArgs({
    this.key,
    required this.annonce,
    this.localImagePath,
  });

  final Key? key;

  final Annonce annonce;

  final String? localImagePath;

  @override
  String toString() {
    return 'AnnoncePubileeRouteArgs{key: $key, annonce: $annonce, localImagePath: $localImagePath}';
  }
}

/// generated route for
/// [AnnoncesFeedScreen]
class AnnoncesFeedRoute extends PageRouteInfo<AnnoncesFeedRouteArgs> {
  AnnoncesFeedRoute({
    Key? key,
    AnnonceCategorie? categorie,
    List<PageRouteInfo>? children,
  }) : super(
         AnnoncesFeedRoute.name,
         args: AnnoncesFeedRouteArgs(key: key, categorie: categorie),
         initialChildren: children,
       );

  static const String name = 'AnnoncesFeedRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AnnoncesFeedRouteArgs>(
        orElse: () => const AnnoncesFeedRouteArgs(),
      );
      return AnnoncesFeedScreen(key: args.key, categorie: args.categorie);
    },
  );
}

class AnnoncesFeedRouteArgs {
  const AnnoncesFeedRouteArgs({this.key, this.categorie});

  final Key? key;

  final AnnonceCategorie? categorie;

  @override
  String toString() {
    return 'AnnoncesFeedRouteArgs{key: $key, categorie: $categorie}';
  }
}

/// generated route for
/// [BoutiqueProScreen]
class BoutiqueProRoute extends PageRouteInfo<BoutiqueProRouteArgs> {
  BoutiqueProRoute({
    Key? key,
    required Vendeur vendeur,
    List<PageRouteInfo>? children,
  }) : super(
         BoutiqueProRoute.name,
         args: BoutiqueProRouteArgs(key: key, vendeur: vendeur),
         initialChildren: children,
       );

  static const String name = 'BoutiqueProRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BoutiqueProRouteArgs>();
      return BoutiqueProScreen(key: args.key, vendeur: args.vendeur);
    },
  );
}

class BoutiqueProRouteArgs {
  const BoutiqueProRouteArgs({this.key, required this.vendeur});

  final Key? key;

  final Vendeur vendeur;

  @override
  String toString() {
    return 'BoutiqueProRouteArgs{key: $key, vendeur: $vendeur}';
  }
}

/// generated route for
/// [CarteProximiteScreen]
class CarteProximiteRoute extends PageRouteInfo<void> {
  const CarteProximiteRoute({List<PageRouteInfo>? children})
    : super(CarteProximiteRoute.name, initialChildren: children);

  static const String name = 'CarteProximiteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CarteProximiteScreen();
    },
  );
}

/// generated route for
/// [ChatScreen]
class ChatRoute extends PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    Key? key,
    required Vendeur vendeur,
    Annonce? annonce,
    List<PageRouteInfo>? children,
  }) : super(
         ChatRoute.name,
         args: ChatRouteArgs(key: key, vendeur: vendeur, annonce: annonce),
         initialChildren: children,
       );

  static const String name = 'ChatRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChatRouteArgs>();
      return ChatScreen(
        key: args.key,
        vendeur: args.vendeur,
        annonce: args.annonce,
      );
    },
  );
}

class ChatRouteArgs {
  const ChatRouteArgs({this.key, required this.vendeur, this.annonce});

  final Key? key;

  final Vendeur vendeur;

  final Annonce? annonce;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, vendeur: $vendeur, annonce: $annonce}';
  }
}

/// generated route for
/// [ConfirmationScreen]
class ConfirmationRoute extends PageRouteInfo<ConfirmationRouteArgs> {
  ConfirmationRoute({
    Key? key,
    required Order order,
    List<PageRouteInfo>? children,
  }) : super(
         ConfirmationRoute.name,
         args: ConfirmationRouteArgs(key: key, order: order),
         initialChildren: children,
       );

  static const String name = 'ConfirmationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ConfirmationRouteArgs>();
      return ConfirmationScreen(key: args.key, order: args.order);
    },
  );
}

class ConfirmationRouteArgs {
  const ConfirmationRouteArgs({this.key, required this.order});

  final Key? key;

  final Order order;

  @override
  String toString() {
    return 'ConfirmationRouteArgs{key: $key, order: $order}';
  }
}

/// generated route for
/// [CreationAnnoncePhotosScreen]
class CreationAnnoncePhotosRoute extends PageRouteInfo<void> {
  const CreationAnnoncePhotosRoute({List<PageRouteInfo>? children})
    : super(CreationAnnoncePhotosRoute.name, initialChildren: children);

  static const String name = 'CreationAnnoncePhotosRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreationAnnoncePhotosScreen();
    },
  );
}

/// generated route for
/// [EvaluationScreen]
class EvaluationRoute extends PageRouteInfo<EvaluationRouteArgs> {
  EvaluationRoute({
    Key? key,
    required Annonce annonce,
    List<PageRouteInfo>? children,
  }) : super(
         EvaluationRoute.name,
         args: EvaluationRouteArgs(key: key, annonce: annonce),
         initialChildren: children,
       );

  static const String name = 'EvaluationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EvaluationRouteArgs>();
      return EvaluationScreen(key: args.key, annonce: args.annonce);
    },
  );
}

class EvaluationRouteArgs {
  const EvaluationRouteArgs({this.key, required this.annonce});

  final Key? key;

  final Annonce annonce;

  @override
  String toString() {
    return 'EvaluationRouteArgs{key: $key, annonce: $annonce}';
  }
}

/// generated route for
/// [FavorisScreen]
class FavorisRoute extends PageRouteInfo<void> {
  const FavorisRoute({List<PageRouteInfo>? children})
    : super(FavorisRoute.name, initialChildren: children);

  static const String name = 'FavorisRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavorisScreen();
    },
  );
}

/// generated route for
/// [FiltresScreen]
class FiltresRoute extends PageRouteInfo<FiltresRouteArgs> {
  FiltresRoute({
    Key? key,
    SearchFilters? initialFilters,
    List<Category> categories = const [],
    List<PageRouteInfo>? children,
  }) : super(
         FiltresRoute.name,
         args: FiltresRouteArgs(
           key: key,
           initialFilters: initialFilters,
           categories: categories,
         ),
         initialChildren: children,
       );

  static const String name = 'FiltresRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FiltresRouteArgs>(
        orElse: () => const FiltresRouteArgs(),
      );
      return FiltresScreen(
        key: args.key,
        initialFilters: args.initialFilters,
        categories: args.categories,
      );
    },
  );
}

class FiltresRouteArgs {
  const FiltresRouteArgs({
    this.key,
    this.initialFilters,
    this.categories = const [],
  });

  final Key? key;

  final SearchFilters? initialFilters;

  final List<Category> categories;

  @override
  String toString() {
    return 'FiltresRouteArgs{key: $key, initialFilters: $initialFilters, categories: $categories}';
  }
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginScreen();
    },
  );
}

/// generated route for
/// [MesAnnoncesScreen]
class MesAnnoncesRoute extends PageRouteInfo<void> {
  const MesAnnoncesRoute({List<PageRouteInfo>? children})
    : super(MesAnnoncesRoute.name, initialChildren: children);

  static const String name = 'MesAnnoncesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MesAnnoncesScreen();
    },
  );
}

/// generated route for
/// [MessagesScreen]
class MessagesRoute extends PageRouteInfo<void> {
  const MessagesRoute({List<PageRouteInfo>? children})
    : super(MessagesRoute.name, initialChildren: children);

  static const String name = 'MessagesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MessagesScreen();
    },
  );
}

/// generated route for
/// [OffreSureScreen]
class OffreSureRoute extends PageRouteInfo<OffreSureRouteArgs> {
  OffreSureRoute({
    Key? key,
    required Annonce annonce,
    int quantity = 1,
    List<PageRouteInfo>? children,
  }) : super(
         OffreSureRoute.name,
         args: OffreSureRouteArgs(
           key: key,
           annonce: annonce,
           quantity: quantity,
         ),
         initialChildren: children,
       );

  static const String name = 'OffreSureRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OffreSureRouteArgs>();
      return OffreSureScreen(
        key: args.key,
        annonce: args.annonce,
        quantity: args.quantity,
      );
    },
  );
}

class OffreSureRouteArgs {
  const OffreSureRouteArgs({
    this.key,
    required this.annonce,
    this.quantity = 1,
  });

  final Key? key;

  final Annonce annonce;

  final int quantity;

  @override
  String toString() {
    return 'OffreSureRouteArgs{key: $key, annonce: $annonce, quantity: $quantity}';
  }
}

/// generated route for
/// [ProfilScreen]
class ProfilRoute extends PageRouteInfo<void> {
  const ProfilRoute({List<PageRouteInfo>? children})
    : super(ProfilRoute.name, initialChildren: children);

  static const String name = 'ProfilRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfilScreen();
    },
  );
}

/// generated route for
/// [RegisterScreen]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RegisterScreen();
    },
  );
}

/// generated route for
/// [SuiviCommandeScreen]
class SuiviCommandeRoute extends PageRouteInfo<SuiviCommandeRouteArgs> {
  SuiviCommandeRoute({
    Key? key,
    required Order order,
    List<PageRouteInfo>? children,
  }) : super(
         SuiviCommandeRoute.name,
         args: SuiviCommandeRouteArgs(key: key, order: order),
         initialChildren: children,
       );

  static const String name = 'SuiviCommandeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SuiviCommandeRouteArgs>();
      return SuiviCommandeScreen(key: args.key, order: args.order);
    },
  );
}

class SuiviCommandeRouteArgs {
  const SuiviCommandeRouteArgs({this.key, required this.order});

  final Key? key;

  final Order order;

  @override
  String toString() {
    return 'SuiviCommandeRouteArgs{key: $key, order: $order}';
  }
}

/// generated route for
/// [SuperAppHomeScreen]
class SuperAppHomeRoute extends PageRouteInfo<void> {
  const SuperAppHomeRoute({List<PageRouteInfo>? children})
    : super(SuperAppHomeRoute.name, initialChildren: children);

  static const String name = 'SuperAppHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SuperAppHomeScreen();
    },
  );
}

/// generated route for
/// [VAHomeScreen]
class VAHomeRoute extends PageRouteInfo<void> {
  const VAHomeRoute({List<PageRouteInfo>? children})
    : super(VAHomeRoute.name, initialChildren: children);

  static const String name = 'VAHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const VAHomeScreen();
    },
  );
}

/// generated route for
/// [VendreFormScreen]
class VendreFormRoute extends PageRouteInfo<VendreFormRouteArgs> {
  VendreFormRoute({
    Key? key,
    required List<XFile> photos,
    List<PageRouteInfo>? children,
  }) : super(
         VendreFormRoute.name,
         args: VendreFormRouteArgs(key: key, photos: photos),
         initialChildren: children,
       );

  static const String name = 'VendreFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VendreFormRouteArgs>();
      return VendreFormScreen(key: args.key, photos: args.photos);
    },
  );
}

class VendreFormRouteArgs {
  const VendreFormRouteArgs({this.key, required this.photos});

  final Key? key;

  final List<XFile> photos;

  @override
  String toString() {
    return 'VendreFormRouteArgs{key: $key, photos: $photos}';
  }
}

/// generated route for
/// [WalletScreen]
class WalletRoute extends PageRouteInfo<void> {
  const WalletRoute({List<PageRouteInfo>? children})
    : super(WalletRoute.name, initialChildren: children);

  static const String name = 'WalletRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const WalletScreen();
    },
  );
}

/// generated route for
/// [WebViewPage]
class WebViewRoute extends PageRouteInfo<WebViewRouteArgs> {
  WebViewRoute({
    Key? key,
    required String url,
    String? title,
    List<PageRouteInfo>? children,
  }) : super(
         WebViewRoute.name,
         args: WebViewRouteArgs(key: key, url: url, title: title),
         initialChildren: children,
       );

  static const String name = 'WebViewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WebViewRouteArgs>();
      return WebViewPage(key: args.key, url: args.url, title: args.title);
    },
  );
}

class WebViewRouteArgs {
  const WebViewRouteArgs({this.key, required this.url, this.title});

  final Key? key;

  final String url;

  final String? title;

  @override
  String toString() {
    return 'WebViewRouteArgs{key: $key, url: $url, title: $title}';
  }
}
