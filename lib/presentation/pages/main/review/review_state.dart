import '../../../../data/models/service_provider_accessed.dart';
import '../../../../domain/entities/provider.dart';
import '../../../../domain/entities/service_provider.dart';
import '../../../../domain/entities/service_provider_accessed.dart';
import 'review_initial_params.dart';

class ReviewState {
  final bool loading;
  final List<ServiceProviderDataModel> services;

  const ReviewState({required this.loading, required this.services});

  factory ReviewState.initial() =>
      const ReviewState(loading: false, services: []);

  ReviewState copyWith({bool? loading, List<ServiceProviderDataModel>? services}) => ReviewState(
      loading: loading ?? this.loading, services: services ?? this.services);
}
