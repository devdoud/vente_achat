// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:achat_vente/core/api/api_client.dart' as _i1043;
import 'package:achat_vente/core/impl/logger.dart' as _i579;
import 'package:achat_vente/core/injection/injectable_module.dart' as _i556;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logging/logging.dart' as _i831;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appInjectableModule = _$AppInjectableModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => appInjectableModule.prefs,
      preResolve: true,
    );
    gh.factory<_i831.Logger>(() => appInjectableModule.logger);
    gh.singleton<_i1043.ApiClient>(() => _i1043.ApiClient());
    gh.singleton<_i579.AppLogger>(
      () => _i579.AppLogger(logger: gh<_i831.Logger>()),
    );
    return this;
  }
}

class _$AppInjectableModule extends _i556.AppInjectableModule {}
