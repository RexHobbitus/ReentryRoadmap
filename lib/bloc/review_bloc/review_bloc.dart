import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'review_event.dart';
import 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc() : super(ReviewInitial()) {
    on<LoadNewReviews>(_onLoadNewReviews);
    on<LoadFirstSevenReviews>(_onLoadFirstSevenReviews);
    on<LoadOldReviews>(_onLoadOldReviews);
    on<UpdateReply>(_onUpdateReply);
    on<MarkDispute>(_onMarkDispute);
    on<SortReviews>(_onSortReviews);
  }

  Future<void> _onLoadNewReviews(
      LoadNewReviews event, Emitter<ReviewState> emit) async {
    emit(ReviewLoading());
    try {
      await FirebaseFirestore.instance
          .collectionGroup('providerReviews')
          .snapshots()
          .forEach((snapshot) {
        final now = DateTime.now();
        final sevenDaysAgo = now.subtract(Duration(days: 7));

        final newReviews = snapshot.docs.where((doc) {
          final data = doc.data();
          final createdAtTimestamp = data['createdAt'] as Timestamp?;
          if (createdAtTimestamp == null) return false;
          final createdAt = createdAtTimestamp.toDate();
          return createdAt.isAfter(sevenDaysAgo) && createdAt.isBefore(now);
        }).toList();

        log("Loaded ${newReviews.length} new reviews from the last 7 days");
        emit(ReviewLoaded(newReviews, [], sortOption: 'Newest First'));
      });
    } catch (e) {
      emit(ReviewError("Failed to load new reviews"));
      log("Error loading new reviews: $e",
          name: 'ReviewBloc._onLoadNewReviews');
    }
  }

  Future<void> _onLoadFirstSevenReviews(
      LoadFirstSevenReviews event, Emitter<ReviewState> emit) async {
    emit(ReviewLoading());
    try {
      await FirebaseFirestore.instance
          .collectionGroup('providerReviews')
          .snapshots()
          .first
          .then((snapshot) {
        final firstSevenReviews = snapshot.docs.take(7).toList();
        log("Loaded the first ${firstSevenReviews.length} reviews");
        emit(FirstSevenReviews(firstSevenReviews));
      });
    } catch (e) {
      emit(ReviewError("Failed to load the first seven reviews"));
      log("Error loading first seven reviews: $e",
          name: 'ReviewBloc._onLoadFirstSevenReviews');
    }
  }

  Future<void> _onLoadOldReviews(
      LoadOldReviews event, Emitter<ReviewState> emit) async {
    emit(ReviewLoading());
    try {
      await FirebaseFirestore.instance
          .collectionGroup('providerReviews')
          .snapshots()
          .forEach((snapshot) {
        final now = DateTime.now();
        final sevenDaysAgo = now.subtract(Duration(days: 7));

        final oldReviews = snapshot.docs.where((doc) {
          final data = doc.data();
          final createdAtTimestamp = data['createdAt'] as Timestamp?;
          if (createdAtTimestamp == null) return false;
          final createdAt = createdAtTimestamp.toDate();
          return createdAt.isBefore(sevenDaysAgo);
        }).toList();

        final newReviews =
            (state is ReviewLoaded) ? (state as ReviewLoaded).newReviews : [];

        log("Loaded ${oldReviews.length} old reviews (older than 7 days)");
        emit(ReviewLoaded(newReviews, oldReviews, sortOption: 'Newest First'));
      });
    } catch (e) {
      emit(ReviewError("Failed to load old reviews"));
      log("Error loading old reviews: $e",
          name: 'ReviewBloc._onLoadOldReviews');
    }
  }

  Future<void> _onUpdateReply(
      UpdateReply event, Emitter<ReviewState> emit) async {
    try {
      await event.reviewDocRef.set({
        "reply": event.reply,
      }, SetOptions(merge: true));
      Fluttertoast.showToast(
        msg: "Reply updated successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      log("Reply updated for review ${event.reviewDocRef.id}");
      emit(ReplyUpdated());
    } catch (e) {
      emit(ReviewError("Failed to update reply"));
      log("Error updating reply: $e", name: 'ReviewBloc._onUpdateReply');
    }
  }

  Future<void> _onMarkDispute(
      MarkDispute event, Emitter<ReviewState> emit) async {
    try {
      await event.reviewDocRef.set({
        "dispute": {"status": true, "message": event.disputeMessage}
      }, SetOptions(merge: true));
      Fluttertoast.showToast(
        msg: "Dispute marked successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      log("Dispute marked for review ${event.reviewDocRef.id}");
      emit(DisputeMarked());
    } catch (e) {
      emit(ReviewError("Failed to mark dispute"));
      log("Error marking dispute: $e", name: 'ReviewBloc._onMarkDispute');
    }
  }

  void _onSortReviews(SortReviews event, Emitter<ReviewState> emit) {
    if (state is ReviewLoaded) {
      final newReviews = List.from((state as ReviewLoaded).newReviews);
      final oldReviews = List.from((state as ReviewLoaded).oldReviews);

      switch (event.sortOption) {
        case 'Newest First':
          newReviews.sort((a, b) {
            final aCreatedAt = a.data()['createdAt'] as Timestamp?;
            final bCreatedAt = b.data()['createdAt'] as Timestamp?;
            if (aCreatedAt == null || bCreatedAt == null) return 0;
            return bCreatedAt.compareTo(aCreatedAt);
          });
          oldReviews.sort((a, b) {
            final aCreatedAt = a.data()['createdAt'] as Timestamp?;
            final bCreatedAt = b.data()['createdAt'] as Timestamp?;
            if (aCreatedAt == null || bCreatedAt == null) return 0;
            return bCreatedAt.compareTo(aCreatedAt);
          });
          log("Sorted reviews by Newest First");
          break;
        case 'Oldest First':
          newReviews.sort((a, b) {
            final aCreatedAt = a.data()['createdAt'] as Timestamp?;
            final bCreatedAt = b.data()['createdAt'] as Timestamp?;
            if (aCreatedAt == null || bCreatedAt == null) return 0;
            return aCreatedAt.compareTo(bCreatedAt);
          });
          oldReviews.sort((a, b) {
            final aCreatedAt = a.data()['createdAt'] as Timestamp?;
            final bCreatedAt = b.data()['createdAt'] as Timestamp?;
            if (aCreatedAt == null || bCreatedAt == null) return 0;
            return aCreatedAt.compareTo(bCreatedAt);
          });
          log("Sorted reviews by Oldest First");
          break;
        case 'Highest Rating':
          newReviews.sort((a, b) {
            final aRating = a.data()['rating'] as double?;
            final bRating = b.data()['rating'] as double?;
            if (aRating == null || bRating == null) return 0;
            return bRating.compareTo(aRating);
          });
          oldReviews.sort((a, b) {
            final aRating = a.data()['rating'] as double?;
            final bRating = b.data()['rating'] as double?;
            if (aRating == null || bRating == null) return 0;
            return bRating.compareTo(aRating);
          });
          log("Sorted reviews by Highest Rating");
          break;
        case 'Lowest Rating':
          newReviews.sort((a, b) {
            final aRating = a.data()['rating'] as double?;
            final bRating = b.data()['rating'] as double?;
            if (aRating == null || bRating == null) return 0;
            return aRating.compareTo(bRating);
          });
          oldReviews.sort((a, b) {
            final aRating = a.data()['rating'] as double?;
            final bRating = b.data()['rating'] as double?;
            if (aRating == null || bRating == null) return 0;
            return aRating.compareTo(bRating);
          });
          log("Sorted reviews by Lowest Rating");
          break;
      }

      emit(ReviewLoaded(newReviews, oldReviews, sortOption: event.sortOption));
    }
  }
}
