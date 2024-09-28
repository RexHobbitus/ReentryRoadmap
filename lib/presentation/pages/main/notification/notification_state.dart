import 'notification_initial_params.dart';

class NotificationState {
final bool loading;
const NotificationState({required this.loading});

factory NotificationState.initial() => const NotificationState(loading: false);

NotificationState copyWith({bool? loading}) => NotificationState(loading: loading??this.loading);
}
