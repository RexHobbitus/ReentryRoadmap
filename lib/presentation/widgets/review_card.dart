import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:reentry_roadmap/Dev_Hire/Utils/Customs/TextField/custom_textfield.dart';
import 'package:reentry_roadmap/core/extensions/media_query_extension.dart';

class ReviewCard extends StatelessWidget {
  final String name;
  final bool isVerified;
  final String date;
  final double rating;
  final String reviewText;
  final TextEditingController? replyController;
  final TextEditingController? disputeController;

  final List<dynamic> reviewImages;
  final VoidCallback? onReplyTap;
  final VoidCallback? onDisputeTap;

  const ReviewCard({
    Key? key,
    required this.name,
    this.onReplyTap,
    this.onDisputeTap,
    required this.isVerified,
    required this.date,
    required this.rating,
    required this.reviewText,
    required this.reviewImages,
    this.replyController,
    this.disputeController,
  }) : super(key: key);

  void _showDialog(
      {required BuildContext context,
      required String title,
      required String buttonTitle,
      required VoidCallback onButtonTap,
      required TextEditingController controller}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Container(
            width: context.screenHeight,
            child: CustomTextField(
              hint: "Enter $title",
              controller: controller,
              maxlines: 4,
            ),
          ),
          actions: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xff807ED5),
                  foregroundColor: Colors.white),
              onPressed: onButtonTap,
              child: Text(buttonTitle),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundColor: Color(0xff11404C),
                backgroundImage: NetworkImage('https://via.placeholder.com/48'),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      if (isVerified)
                        const Icon(
                          Icons.verified,
                          color: Color(0xff11404C),
                          size: 16,
                        ),
                      if (isVerified) const SizedBox(width: 4),
                      const Text(
                        'Verified User',
                        style: TextStyle(
                          color: Color(0xff11404C),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: context.screenHeight * 0.05,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: rating,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Color(0xff11404C),
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                          direction: Axis.horizontal,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          rating.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      reviewText,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[800],
                      ),
                      maxLines: null,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: reviewImages
                          .map(
                            (imageUrl) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  imageUrl,
                                  width: 100,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xffBFD4D9),
                    foregroundColor: Colors.black),
                onPressed: () {
                  _showDialog(
                      context: context,
                      title: "Reply",
                      buttonTitle: "Add reply",
                      onButtonTap: onReplyTap!,
                      controller: replyController!);
                },
                child: const Text('Reply to Review'),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xffBFD4D9),
                    foregroundColor: Colors.black),
                onPressed: () {
                  _showDialog(
                      context: context,
                      title: "Dispute Review",
                      buttonTitle: "Dispute",
                      onButtonTap: onDisputeTap!,
                      controller: disputeController!);
                },
                child: const Text('Dispute Review'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
