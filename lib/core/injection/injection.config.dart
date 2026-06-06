// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:achat_vente/core/api/api_client.dart' as _i1043;
import 'package:achat_vente/core/api/token_storage.dart' as _i480;
import 'package:achat_vente/core/impl/logger.dart' as _i579;
import 'package:achat_vente/core/injection/injectable_module.dart' as _i556;
import 'package:achat_vente/export.dart' as _i428;
import 'package:achat_vente/features/vente_achat/data/repositories/auth_repository.dart'
    as _i349;
import 'package:achat_vente/features/vente_achat/data/repositories/cart_repository.dart'
    as _i225;
import 'package:achat_vente/features/vente_achat/data/repositories/category_repository.dart'
    as _i676;
import 'package:achat_vente/features/vente_achat/data/repositories/favorite_repository.dart'
    as _i420;
import 'package:achat_vente/features/vente_achat/data/repositories/order_repository.dart'
    as _i914;
import 'package:achat_vente/features/vente_achat/data/repositories/product_repository.dart'
    as _i930;
import 'package:achat_vente/features/vente_achat/data/sources/auth_remote_source.dart'
    as _i966;
import 'package:achat_vente/features/vente_achat/data/sources/cart_remote_source.dart'
    as _i282;
import 'package:achat_vente/features/vente_achat/data/sources/category_remote_source.dart'
    as _i880;
import 'package:achat_vente/features/vente_achat/data/sources/favorite_remote_source.dart'
    as _i907;
import 'package:achat_vente/features/vente_achat/data/sources/notification_remote_source.dart'
    as _i522;
import 'package:achat_vente/features/vente_achat/data/sources/order_remote_source.dart'
    as _i591;
import 'package:achat_vente/features/vente_achat/data/sources/product_creation_remote_source.dart'
    as _i135;
import 'package:achat_vente/features/vente_achat/data/sources/product_remote_source.dart'
    as _i964;
import 'package:achat_vente/features/vente_achat/data/sources/shop_remote_source.dart'
    as _i57;
import 'package:achat_vente/features/vente_achat/data/sources/wallet_remote_source.dart'
    as _i839;
import 'package:achat_vente/features/vente_achat/domain/repositories/i_auth_repository.dart'
    as _i948;
import 'package:achat_vente/features/vente_achat/domain/repositories/i_cart_repository.dart'
    as _i389;
import 'package:achat_vente/features/vente_achat/domain/repositories/i_category_repository.dart'
    as _i736;
import 'package:achat_vente/features/vente_achat/domain/repositories/i_favorite_repository.dart'
    as _i154;
import 'package:achat_vente/features/vente_achat/domain/repositories/i_order_repository.dart'
    as _i977;
import 'package:achat_vente/features/vente_achat/domain/repositories/i_product_repository.dart'
    as _i615;
import 'package:achat_vente/features/vente_achat/logic/auth/auth_cubit.dart'
    as _i980;
import 'package:achat_vente/features/vente_achat/logic/cart/cart_cubit.dart'
    as _i543;
import 'package:achat_vente/features/vente_achat/logic/category/category_cubit.dart'
    as _i160;
import 'package:achat_vente/features/vente_achat/logic/favorite/favorite_cubit.dart'
    as _i450;
import 'package:achat_vente/features/vente_achat/logic/notification/notification_cubit.dart'
    as _i26;
import 'package:achat_vente/features/vente_achat/logic/order/order_cubit.dart'
    as _i581;
import 'package:achat_vente/features/vente_achat/logic/product/product_cubit.dart'
    as _i440;
import 'package:achat_vente/features/vente_achat/logic/product_creation/product_creation_cubit.dart'
    as _i230;
import 'package:achat_vente/features/vente_achat/logic/shop/shop_cubit.dart'
    as _i11;
import 'package:achat_vente/features/vente_achat/logic/wallet/wallet_cubit.dart'
    as _i926;
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
    gh.singleton<_i480.TokenStorage>(
      () => _i480.TokenStorage(gh<_i460.SharedPreferences>()),
    );
    gh.singleton<_i1043.ApiClient>(
      () => _i1043.ApiClient(gh<_i428.TokenStorage>()),
    );
    gh.singleton<_i579.AppLogger>(
      () => _i579.AppLogger(logger: gh<_i831.Logger>()),
    );
    gh.lazySingleton<_i966.AuthRemoteSource>(
      () => _i966.AuthRemoteSource(
        gh<_i1043.ApiClient>(),
        gh<_i480.TokenStorage>(),
      ),
    );
    gh.lazySingleton<_i282.CartRemoteSource>(
      () => _i282.CartRemoteSource(gh<_i1043.ApiClient>()),
    );
    gh.lazySingleton<_i880.CategoryRemoteSource>(
      () => _i880.CategoryRemoteSource(gh<_i1043.ApiClient>()),
    );
    gh.lazySingleton<_i907.FavoriteRemoteSource>(
      () => _i907.FavoriteRemoteSource(gh<_i1043.ApiClient>()),
    );
    gh.lazySingleton<_i591.OrderRemoteSource>(
      () => _i591.OrderRemoteSource(gh<_i1043.ApiClient>()),
    );
    gh.lazySingleton<_i964.ProductRemoteSource>(
      () => _i964.ProductRemoteSource(gh<_i1043.ApiClient>()),
    );
    gh.lazySingleton<_i522.NotificationRemoteSource>(
      () => _i522.NotificationRemoteSource(gh<_i1043.ApiClient>()),
    );
    gh.lazySingleton<_i135.ProductCreationRemoteSource>(
      () => _i135.ProductCreationRemoteSource(gh<_i1043.ApiClient>()),
    );
    gh.lazySingleton<_i57.ShopRemoteSource>(
      () => _i57.ShopRemoteSource(gh<_i1043.ApiClient>()),
    );
    gh.lazySingleton<_i839.WalletRemoteSource>(
      () => _i839.WalletRemoteSource(gh<_i1043.ApiClient>()),
    );
    gh.lazySingleton<_i389.ICartRepository>(
      () => _i225.CartRepository(gh<_i282.CartRemoteSource>()),
    );
    gh.factory<_i26.NotificationCubit>(
      () => _i26.NotificationCubit(gh<_i522.NotificationRemoteSource>()),
    );
    gh.factory<_i926.WalletCubit>(
      () => _i926.WalletCubit(gh<_i839.WalletRemoteSource>()),
    );
    gh.factory<_i230.ProductCreationCubit>(
      () => _i230.ProductCreationCubit(gh<_i135.ProductCreationRemoteSource>()),
    );
    gh.lazySingleton<_i154.IFavoriteRepository>(
      () => _i420.FavoriteRepository(gh<_i907.FavoriteRemoteSource>()),
    );
    gh.singleton<_i543.CartCubit>(
      () => _i543.CartCubit(gh<_i389.ICartRepository>()),
    );
    gh.lazySingleton<_i977.IOrderRepository>(
      () => _i914.OrderRepository(gh<_i591.OrderRemoteSource>()),
    );
    gh.lazySingleton<_i948.IAuthRepository>(
      () => _i349.AuthRepository(gh<_i966.AuthRemoteSource>()),
    );
    gh.lazySingleton<_i736.ICategoryRepository>(
      () => _i676.CategoryRepository(gh<_i880.CategoryRemoteSource>()),
    );
    gh.factory<_i11.ShopCubit>(
      () => _i11.ShopCubit(gh<_i57.ShopRemoteSource>()),
    );
    gh.lazySingleton<_i615.IProductRepository>(
      () => _i930.ProductRepository(gh<_i964.ProductRemoteSource>()),
    );
    gh.factory<_i581.OrderCubit>(
      () => _i581.OrderCubit(gh<_i977.IOrderRepository>()),
    );
    gh.factory<_i440.ProductCubit>(
      () => _i440.ProductCubit(gh<_i615.IProductRepository>()),
    );
    gh.singleton<_i980.AuthCubit>(
      () => _i980.AuthCubit(
        gh<_i948.IAuthRepository>(),
        gh<_i480.TokenStorage>(),
      ),
    );
    gh.factory<_i450.FavoriteCubit>(
      () => _i450.FavoriteCubit(gh<_i154.IFavoriteRepository>()),
    );
    gh.factory<_i160.CategoryCubit>(
      () => _i160.CategoryCubit(gh<_i736.ICategoryRepository>()),
    );
    return this;
  }
}

class _$AppInjectableModule extends _i556.AppInjectableModule {}
