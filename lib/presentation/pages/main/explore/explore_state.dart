import 'package:equatable/equatable.dart';
import 'package:reentry_roadmap/domain/entities/ceo_info.dart';
import 'package:reentry_roadmap/domain/entities/featured_provider_our_take.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';

class ExploreState extends Equatable {
  final bool loading;
  final bool loadingCeoInfo;
  final bool loadingOurTakes;
  final CeoInfo? ceoInfo;
  final List<Provider> services;
  final List<FeaturedProviderOurTake> featuredProvidersOurTake;

  const ExploreState(
      {required this.loading,
      required this.loadingCeoInfo,
      required this.loadingOurTakes,
      required this.services,
      required this.featuredProvidersOurTake,
      this.ceoInfo});

  factory ExploreState.initial() => ExploreState(
        loading: false,
        loadingCeoInfo: false,
        loadingOurTakes: false,
        services: [],
        featuredProvidersOurTake: [],
        ceoInfo: CeoInfo.shimmer(),
      );

  ExploreState copyWith(
          {bool? loading,
          bool? loadingCeoInfo,
          bool? loadingOurTakes,
          List<Provider>? services,
          List<FeaturedProviderOurTake>? featuredProvidersOurTake,
          CeoInfo? ceoInfo}) =>
      ExploreState(
        loading: loading ?? this.loading,
        loadingCeoInfo: loadingCeoInfo ?? this.loadingCeoInfo,
        loadingOurTakes: loadingOurTakes ?? this.loadingOurTakes,
        services: services ?? this.services,
        ceoInfo: ceoInfo ?? this.ceoInfo,
        featuredProvidersOurTake:
            featuredProvidersOurTake ?? this.featuredProvidersOurTake,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        loading,
        loadingCeoInfo,
        loadingOurTakes,
        services,
        ceoInfo,
        featuredProvidersOurTake,
      ];
}
