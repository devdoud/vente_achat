import 'dart:async';
import 'dart:isolate';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart';

import 'export.dart';
import 'l10n/app_localizations.dart';

Future<void> _initialize() async {
  try {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    final Function? originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      if (originalOnError != null) {
        originalOnError(errorDetails);
      }
    };

    Isolate.current.addErrorListener(
      RawReceivePort((pair) async {
        if (pair is List) {
          final List<dynamic> errorAndStacktrace = pair;
          if (errorAndStacktrace.length == 2 &&
              errorAndStacktrace.last is String) {
            await FirebaseCrashlytics.instance.recordError(
              errorAndStacktrace.first,
              StackTrace.fromString(errorAndStacktrace.last as String),
              fatal: true,
              reason: 'Isolate error',
            );
          }
        }
      }).sendPort,
    );
  } catch (e, s) {
    AppLogger.get().logError(e.toString(), e, s);
  }
}

Future<void> main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: await getApplicationDocumentsDirectory(),
      );

      await configureDependencies(Environment.prod);

      await _initialize();

      runApp(const MyApp());
    },
    (error, stack) {
      AppLogger.get().logError(error.toString(), error, stack);
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      if (record.level == Level.SEVERE) {
        FirebaseCrashlytics.instance.recordError(
          record.error,
          record.stackTrace,
        );
      }

      if (kDebugMode) {
        debugPrint(
          '${record.level.name}: ${record.time}: ${record.message} ${record.stackTrace}',
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    final router = getIt<AppRouter>();

    return OverlaySupport.global(
      child: MaterialApp.router(
        title: 'Achat & Vente',
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          ...AppLocalizations.localizationsDelegates,
          FormBuilderLocalizations.delegate,
        ],
        locale: const Locale('fr'),
        debugShowCheckedModeBanner: false,
        theme: IWidgetsFactory.build().theme.theme,
        routerDelegate: router.delegate(
          navigatorObservers: () => [AutoRouteObserver()],
        ),
        routeInformationParser: router.defaultRouteParser(),
      ),
    );
  }
}
