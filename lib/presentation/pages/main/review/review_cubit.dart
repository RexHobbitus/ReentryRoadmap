import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:reentry_roadmap/presentation/pages/main/review/widgets/rate_card.dart';
import '../../../../data/repositories/database/services_provider_accessed_imp.dart';
import '../../../../domain/entities/provider.dart';
import '../../../../domain/entities/service_provider.dart';
import '../../../../domain/entities/service_provider_accessed.dart';
import '../../../../domain/repositories/database/provider_repository.dart';
import 'review_initial_params.dart';
import 'review_state.dart';
import 'review_navigator.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewNavigator navigator;
  final ServiceProviderRepository repository;

  ReviewCubit({required this.navigator,required this.repository}) : super(ReviewState.initial());

  BuildContext get context => navigator.context;

  onInit(ReviewInitialParams initialParams) {
    debugPrint("Review init called...");
    if(isLoggedIn()){
      fetchServiceProviders(FirebaseAuth.instance.currentUser!.uid);
    }
  }

  bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<void> fetchServiceProviders(String userId) async {
    try {
      emit(state.copyWith(loading: state.services.isEmpty));
      final data = await repository.getServiceProvidersAccessed(userId);
      emit(state.copyWith(services: data));
    } catch (e) {
      print("Error fetching service providers: $e");
    } finally {
      emit(state.copyWith(loading: false));
    }
  }
  showRateCard({required String title}){
    navigator.navigator.showDialogBox(context, RateCard(title: title, navigator: navigator,));
  }


}
