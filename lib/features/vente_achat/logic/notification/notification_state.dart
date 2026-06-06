import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/message.dart';
import '../../../../core/utils/failures.dart';

part 'notification_state.freezed.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState.initial()                            = NotificationInitial;
  const factory NotificationState.loading()                            = NotificationLoading;
  const factory NotificationState.loaded(List<ActivityItem> items)     = NotificationLoaded;
  const factory NotificationState.failure(NetworkFailure failure)      = NotificationFailure;
}
