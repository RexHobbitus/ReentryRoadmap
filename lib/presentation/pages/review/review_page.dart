import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reentry_roadmap/core/extensions/media_query_extension.dart';
import 'package:reentry_roadmap/core/utils/pref_utils.dart';
import 'package:reentry_roadmap/presentation/widgets/empty_data.dart';

import '../../../core/utils/assets.dart';
import '../../widgets/review_card.dart';
import '../../widgets/text_widgets.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    String _selectedSortOption = 'Oldest First';
    String userId = PrefUtil.getString(PrefUtil.userId);
    final DateTime now = DateTime.now();
    final DateTime sevenDaysAgo = now.subtract(const Duration(days: 7));
    final Timestamp startTime = Timestamp.fromDate(sevenDaysAgo);
    final Timestamp endTime = Timestamp.fromDate(now);
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'New Reviews',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: context.screenHeight * 0.01),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collectionGroup('providerReviews')
                  .snapshots(),
              builder: (builder, providerSnapshot) {
                if (!providerSnapshot.hasData ||
                    providerSnapshot.data == null) {
                  return const EmptyData();
                }
                final data = providerSnapshot.data?.docs ?? [];

                final DateTime now = DateTime.now();
                final DateTime sevenDaysAgo =
                    now.subtract(const Duration(days: 13));

                final filteredReviews = data
                    .where((reviewDoc) {
                      final reviewData = reviewDoc.data();
                      final createdAtTimestamp =
                          reviewData["createdAt"] as Timestamp?;
                      final providerId = reviewData["providerId"] as String?;
                      if (createdAtTimestamp == null || providerId == null) {
                        return false;
                      }

                      final createdAt = DateTime.fromMillisecondsSinceEpoch(
                          createdAtTimestamp.seconds * 1000);

                      final isWithinDateRange =
                          createdAt.isAfter(sevenDaysAgo) &&
                              createdAt.isBefore(now);

                      final isMatchingProviderId = providerId == userId;

                      return isWithinDateRange && isMatchingProviderId;
                    })
                    .take(7)
                    .toList();
                if (filteredReviews.isEmpty) {
                  return const EmptyData();
                }
                return ListView.separated(
                  itemCount: filteredReviews.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (itemBuilder, index) {
                    final reviewDoc = filteredReviews[index];
                    final reviewData = reviewDoc.data();
                    final replyText = reviewData.containsKey("reply")
                        ? reviewData["reply"]
                        : "";
                    final disputeMessage = reviewData.containsKey("dispute")
                        ? reviewData["dispute"]["message"]
                        : "";
                    final TextEditingController dispute =
                        TextEditingController(text: disputeMessage);
                    final TextEditingController replyController =
                        TextEditingController(text: replyText);

                    final createdAtTimestamp =
                        reviewData["createdAt"] as Timestamp?;
                    final disputeStatus = reviewData.containsKey("dispute")
                        ? reviewData["dispute"]["status"]
                        : false;
                    final userName = reviewData.containsKey("userName")
                        ? reviewData["userName"]
                        : "Anonymous";
                    final isVerified = reviewData.containsKey("isVerified")
                        ? reviewData["isVerified"]
                        : false;

                    final formattedDate = createdAtTimestamp != null
                        ? DateFormat('MMM dd, yyyy')
                            .format(createdAtTimestamp.toDate())
                        : "Date not available"; // Default message if 'createdAt' is null

                    return ReviewCard(
                      name: userName,
                      isVerified: isVerified,
                      date: formattedDate,
                      rating: reviewData["rating"],
                      reviewText: reviewData["review"],
                      reviewImages: reviewData["images"],
                      replyController: replyController,
                      disputeController: dispute,
                      onReplyTap: () async {
                        // Update the reply if it does not exist
                        await reviewDoc.reference.set({
                          "reply": replyController.text,
                        }, SetOptions(merge: true)).then((_) {
                          Fluttertoast.showToast(
                            msg: "Reply updated successfully!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                          log("Reply updated successfully.");
                        }).catchError((error) {
                          log("Failed to update reply: $error");
                        });
                      },
                      onDisputeTap: () async {
                        // Update the dispute if it does not exist
                        await reviewDoc.reference.set({
                          "dispute": {"status": true, "message": dispute.text},
                        }, SetOptions(merge: true)).then((_) {
                          Fluttertoast.showToast(
                            msg: "Dispute marked successfully!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                          log("Dispute marked successfully.");
                        }).catchError((error) {
                          log("Failed to update dispute: $error");
                        });
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: context.screenHeight * 0.02);
                  },
                );
              }),
          SizedBox(height: context.screenHeight * 0.04),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Old Reviews',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              // DropdownButton<String>(
              //   value: _selectedSortOption,
              //   onChanged: (String? newValue) {
              //     setState(() {
              //       _selectedSortOption = newValue!;
              //     });
              //   },
              //   items: <String>[
              //     'Newest First',
              //     'Oldest First',
              //     'Highest Rating',
              //     'Lowest Rating'
              //   ].map<DropdownMenuItem<String>>((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              //   style:
              //   const TextStyle(color: Colors.black), // Dropdown text color
              //   dropdownColor:
              //   const Color(0xffBFD4D9), // Dropdown background color
              // ),
            ],
          ),
          SizedBox(height: context.screenHeight * 0.02),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collectionGroup('providerReviews')
                  .snapshots(),
              builder: (builder, providerSnapshot) {
                if (providerSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (!providerSnapshot.hasData ||
                    providerSnapshot.data == null) {
                  return const EmptyData();
                }

                final data = providerSnapshot.data?.docs ?? [];
                log("Data is --> $data");
                // Get the current date and calculate 7 days ago
                final DateTime now = DateTime.now();
                final DateTime sevenDaysAgo =
                    now.subtract(const Duration(days: 7));

                // Filter reviews based on the createdAt field
                final filteredReviews = data.where((reviewDoc) {
                  final reviewData = reviewDoc.data();
                  log("Reviews are $reviewData");

                  final createdAtTimestamp =
                      reviewData["createdAt"] as Timestamp?;
                  final providerId = reviewData["providerId"] as String?;

                  if (createdAtTimestamp == null || providerId == null) {
                    return false;
                  }

                  final createdAt = DateTime.fromMillisecondsSinceEpoch(
                      createdAtTimestamp.seconds * 1000);

                  // Check if the review's createdAt is within the last 7 days
                  final isWithinDateRange = createdAt.isAfter(sevenDaysAgo) &&
                      createdAt.isBefore(now);

                  // Check if the review's providerId matches the targetProviderId
                  final isMatchingProviderId = providerId == userId;

                  return isWithinDateRange && isMatchingProviderId;
                }).toList();
                log("Filtered data $filteredReviews");
                // Apply sorting based on selected option
                if (_selectedSortOption == 'Newest First') {
                  filteredReviews.sort((a, b) {
                    final aDate = (a.data()['createdAt'] as Timestamp).toDate();
                    final bDate = (b.data()['createdAt'] as Timestamp).toDate();
                    return bDate.compareTo(aDate); // Sort descending
                  });
                } else if (_selectedSortOption == 'Oldest First') {
                  filteredReviews.sort((a, b) {
                    final aDate = (a.data()['createdAt'] as Timestamp).toDate();
                    final bDate = (b.data()['createdAt'] as Timestamp).toDate();
                    return aDate.compareTo(bDate); // Sort ascending
                  });
                } else if (_selectedSortOption == 'Highest Rating') {
                  filteredReviews.sort((a, b) {
                    final aRating = a.data()['rating'] as double;
                    final bRating = b.data()['rating'] as double;
                    return bRating
                        .compareTo(aRating); // Sort descending by rating
                  });
                } else if (_selectedSortOption == 'Lowest Rating') {
                  filteredReviews.sort((a, b) {
                    final aRating = a.data()['rating'] as double;
                    final bRating = b.data()['rating'] as double;
                    return aRating
                        .compareTo(bRating); // Sort ascending by rating
                  });
                }

                if (filteredReviews.isEmpty) {
                  return const EmptyData();
                }

                return ListView.separated(
                  itemCount: filteredReviews.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (itemBuilder, index) {
                    final reviewDoc = filteredReviews[index];
                    final reviewData = reviewDoc.data();
                    final replyText = reviewData.containsKey("reply")
                        ? reviewData["reply"]
                        : "";
                    final disputeMessage = reviewData.containsKey("dispute")
                        ? reviewData["dispute"]["message"]
                        : "";
                    final TextEditingController dispute =
                        TextEditingController(text: disputeMessage);
                    final TextEditingController replyController =
                        TextEditingController(text: replyText);

                    final createdAtTimestamp =
                        reviewData["createdAt"] as Timestamp?;

                    final userName = reviewData.containsKey("userName")
                        ? reviewData["userName"]
                        : "Anonymous";
                    final isVerified = reviewData.containsKey("isVerified")
                        ? reviewData["isVerified"]
                        : false;

                    final formattedDate = createdAtTimestamp != null
                        ? DateFormat('MMM dd, yyyy')
                            .format(createdAtTimestamp.toDate())
                        : "Date not available"; // Default message if 'createdAt' is null

                    return ReviewCard(
                      name: userName,
                      isVerified: isVerified,
                      date: formattedDate,
                      rating: reviewData["rating"],
                      reviewText: reviewData["review"],
                      reviewImages: reviewData["images"],
                      replyController: replyController,
                      disputeController: dispute,
                      onReplyTap: () async {
                        // Update the reply if it does not exist
                        await reviewDoc.reference.set({
                          "reply": replyController.text,
                        }, SetOptions(merge: true)).then((_) {
                          Fluttertoast.showToast(
                            msg: "Reply updated successfully!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                          log("Reply updated successfully.");
                        }).catchError((error) {
                          log("Failed to update reply: $error");
                        });
                      },
                      onDisputeTap: () async {
                        // Update the dispute if it does not exist
                        await reviewDoc.reference.set({
                          "dispute": {"status": true, "message": dispute.text},
                        }, SetOptions(merge: true)).then((_) {
                          Fluttertoast.showToast(
                            msg: "Dispute marked successfully!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                          log("Dispute marked successfully.");
                        }).catchError((error) {
                          log("Failed to update dispute: $error");
                        });
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: context.screenHeight * 0.02);
                  },
                );
              }),
        ],
      ),
    );
  }
}
