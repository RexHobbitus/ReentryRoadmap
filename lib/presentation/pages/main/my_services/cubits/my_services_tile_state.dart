part of 'my_services_tile_cubit.dart';

class MyServicesTileState {
  final bool loading;

  final bool serviceStatusUpdated;

  const MyServicesTileState(
      {required this.loading, required this.serviceStatusUpdated});

  factory MyServicesTileState.initial() =>
      const MyServicesTileState(loading: false, serviceStatusUpdated: false);

  MyServicesTileState copyWith({bool? loading, bool? serviceStatusUpdated}) =>
      MyServicesTileState(
          loading: loading ?? this.loading,
          serviceStatusUpdated:
              serviceStatusUpdated ?? this.serviceStatusUpdated);
}
