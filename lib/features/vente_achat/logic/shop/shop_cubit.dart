import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/failures.dart';
import '../../data/repositories/repo_utils.dart';
import '../../data/sources/shop_remote_source.dart';
import 'shop_state.dart';

@injectable
class ShopCubit extends Cubit<ShopState> {
  final ShopRemoteSource _source;
  ShopCubit(this._source) : super(const ShopState.initial());

  Future<void> createShop({required String name, String? description}) async {
    emit(const ShopState.loading());
    try {
      final dto = await _source.createShop(name: name, description: description);
      emit(ShopState.created(shopUuid: dto.uuid));
    } on DioException catch (e) {
      emit(ShopState.failure(toNetworkFailure(e)));
    } catch (_) {
      emit(const ShopState.failure(NetworkFailure.unexpectedError()));
    }
  }

  Future<void> updateShop({
    required String shopUuid,
    required String name,
    String? description,
  }) async {
    emit(const ShopState.loading());
    try {
      await _source.updateShop(
          shopUuid: shopUuid, name: name, description: description);
      emit(const ShopState.updated());
    } on DioException catch (e) {
      emit(ShopState.failure(toNetworkFailure(e)));
    } catch (_) {
      emit(const ShopState.failure(NetworkFailure.unexpectedError()));
    }
  }
}
