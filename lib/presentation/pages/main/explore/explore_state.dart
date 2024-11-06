import 'package:reentry_roadmap/domain/entities/ceo_info.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';

class ExploreState {
  final bool loading;
  final bool loadingCeoInfo;
  final CeoInfo? ceoInfo;
  final List<Provider> services;

  const ExploreState(
      {required this.loading,required this.loadingCeoInfo, required this.services, this.ceoInfo});

  factory ExploreState.initial() => ExploreState(
        loading: false,
        loadingCeoInfo: false,
        services: [],
        ceoInfo: CeoInfo.shimmer(),
      );

  ExploreState copyWith(
          {bool? loading,bool? loadingCeoInfo, List<Provider>? services, CeoInfo? ceoInfo}) =>
      ExploreState(
        loading: loading ?? this.loading,
        loadingCeoInfo: loadingCeoInfo ?? this.loadingCeoInfo,
        services: services ?? this.services,
        ceoInfo: ceoInfo ?? this.ceoInfo,
      );
}
