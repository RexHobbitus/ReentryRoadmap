import 'my_services_initial_params.dart';

class MyServicesState {
final bool loading;
const MyServicesState({required this.loading});

factory MyServicesState.initial() => const MyServicesState(loading: false);

MyServicesState copyWith({bool? loading}) => MyServicesState(loading: loading??this.loading);
}
