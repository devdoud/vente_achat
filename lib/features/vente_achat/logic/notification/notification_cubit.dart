import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/failures.dart';
import '../../data/repositories/repo_utils.dart';
import '../../data/sources/notification_remote_source.dart';
import 'notification_state.dart';

@injectable
class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRemoteSource _source;
  NotificationCubit(this._source) : super(const NotificationState.initial());

  Future<void> load() async {
    emit(const NotificationState.loading());
    try {
      final dtos  = await _source.getNotifications();
      final items = dtos.map((d) => d.toActivityItem()).toList();
      emit(NotificationState.loaded(items));
    } on DioException catch (e) {
      emit(NotificationState.failure(toNetworkFailure(e)));
    } catch (_) {
      emit(const NotificationState.failure(NetworkFailure.unexpectedError()));
    }
  }
}
