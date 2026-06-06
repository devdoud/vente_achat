// AuthGuard est défini dans router.dart pour éviter les imports circulaires
// (il a besoin des routes générées dans router.gr.dart qui est un `part` de router.dart)
export 'router.dart' show AuthGuard;
