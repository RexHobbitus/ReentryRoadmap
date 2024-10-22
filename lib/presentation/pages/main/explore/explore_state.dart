import 'package:reentry_roadmap/domain/entities/provider.dart';

class ExploreState {
  final bool loading;
  final List<Provider> services;

  const ExploreState({required this.loading, required this.services});

  factory ExploreState.initial() => const ExploreState(
        loading: false,
        services: [],
      );

  ExploreState copyWith({bool? loading, List<Provider>? services}) =>
      ExploreState(
        loading: loading ?? this.loading,
        services: services ?? this.services,
      );
}
