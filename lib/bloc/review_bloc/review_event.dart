// review_event.dart

import 'package:equatable/equatable.dart';

abstract class ReviewEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadNewReviews extends ReviewEvent {}

class LoadOldReviews extends ReviewEvent {}

class LoadFirstSevenReviews extends ReviewEvent {}

class UpdateReply extends ReviewEvent {
  final dynamic reviewDocRef;
  final String reply;

  UpdateReply(this.reviewDocRef, this.reply);

  @override
  List<Object?> get props => [reviewDocRef, reply];
}

class MarkDispute extends ReviewEvent {
  final dynamic reviewDocRef;
  final String disputeMessage;

  MarkDispute(this.reviewDocRef, this.disputeMessage);

  @override
  List<Object?> get props => [reviewDocRef, disputeMessage];
}

class SortReviews extends ReviewEvent {
  final String sortOption;

  SortReviews(this.sortOption);

  @override
  List<Object?> get props => [sortOption];
}
