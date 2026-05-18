import 'dart:isolate';

import 'package:achat_vente/export.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies(String env) {
  getIt.registerSingleton<AppRouter>(AppRouter());
  return getIt.init(environment: env);
}

SharedPreferences get prefs => getIt.get<SharedPreferences>();

Future<void> initialize() async {
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
