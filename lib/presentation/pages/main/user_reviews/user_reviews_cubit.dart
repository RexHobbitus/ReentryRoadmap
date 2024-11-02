import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:reentry_roadmap/presentation/pages/main/user_reviews/user_reviews_initial.dart';
import 'package:reentry_roadmap/presentation/pages/main/user_reviews/user_reviews_navigator.dart';
import 'package:reentry_roadmap/presentation/pages/main/user_reviews/user_reviews_state.dart';
import '../../../../../data/models/review_parameter.dart';
import '../../../../../data/repositories/database/user_reviews_service.dart';

class UserReviewsCubit extends Cubit<UserReviewsState> {
  final UserReviewsNavigator navigator;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserReviewsService _userReviewsService = UserReviewsService(); // Add UserReviewsService instance

  UserReviewsCubit({required this.navigator}) : super(UserReviewsState.initial());

  BuildContext get context => navigator.context;

  // Initialization function
  void onInit(UserReviewsInitialParams initialParams) {
    fetchUserReviews();
  }


  Future<void> fetchUserReviews() async {
    emit(UserReviewsState.loading());

    try {

      final userReviews = await _userReviewsService.getUserReviews(); // Fetch reviews for the logged-in user

      // Map the documents to review data
      final reviews = userReviews.map((data) {
        return ReviewParameter(
          rating: data['rating'],
          review: data['review'],
          images: List<String>.from(data['images']),
          postAnonymously: data['postAnonymously'],
          ratings: Map<String, int>.from(data['ratings']),
        );
      }).toList();

      emit(UserReviewsState.loaded(reviews));
    } catch (e) {
      emit(UserReviewsState.error('Failed to fetch reviews: $e'));
    }
  }

  String formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    DateFormat formatter = DateFormat('MMM dd yyyy');
    return formatter.format(dateTime);
  }

}
