// review_state.dart

import 'package:equatable/equatable.dart';

abstract class ReviewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewLoaded extends ReviewState {
  final List<dynamic> newReviews;
  final List<dynamic> oldReviews;
  final String sortOption;

  ReviewLoaded(this.newReviews, this.oldReviews,
      {this.sortOption = 'Newest First'});

  @override
  List<Object?> get props => [newReviews, oldReviews, sortOption];
}

class ReviewError extends ReviewState {
  final String message;

  ReviewError(this.message);

  @override
  List<Object?> get props => [message];
}

class ReplyUpdated extends ReviewState {}

class DisputeMarked extends ReviewState {}

class FirstSevenReviews extends ReviewState {
  final List<dynamic> firstSevenReviews;

  FirstSevenReviews(this.firstSevenReviews);

  @override
  List<Object?> get props => [firstSevenReviews];
}
