import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_check_box.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_star_rating.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../data/models/review_parameter.dart';
import '../../../../../data/repositories/database/review_service.dart';
import '../../provider/write_review/add_photos_button.dart';

/// This screen needs modification on the code to add providerId variable instead of the hardcoded one

class ReviewCard extends StatefulWidget {
  final Function(ReviewParameter)? onPostReview;
  final Map<String, int> ratings; // Add ratings parameter
  final String title;

  ReviewCard(
      {super.key,
      this.onPostReview,
      required this.ratings,
      required this.title});

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  String _review = "";
  double _rating = 0;
  List<dynamic> _images = [];
  bool postAnonymously = false;

  @override
  Widget build(BuildContext context) {
    return CustomResponsiveBuilder(builder: (context, constraints, deviceSize) {
      return SizedBox(
        width: deviceSize == DeviceSize.web ? 800 : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titleWidget(title: widget.title),

            Divider(
              height: 30,
              color: context.colorScheme.onSurface.withOpacity(0.3),
            ),
            SizedBox(height: 20),
            deviceSize == DeviceSize.web ? _ratingWidgetWeb() :_ratingWidget(),
            const SizedBox(height: 20),
            CustomTextField(
              isDetail: true,
              width: deviceSize == DeviceSize.web ? constraints.maxWidth : null,
              onChange: (val) {
                setState(() {
                  _review = val;
                });
              },
            ),
            _selectedImages(),
            AddPhotosButton(onTap: kIsWeb ? _pickWebImages : _pickImages),
            const SizedBox(height: 20),
            deviceSize == DeviceSize.web ? _PostReviewButtonWeb(constraints,kMenuBreakPoint) : _PostReviewButtonMobile(constraints,kMenuBreakPoint),
          ],
        ),
      );
    });
  }

  bool get isButtonDisabled => _rating <= 0 || _review.isEmpty;

  Widget _titleWidget({required String title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              title,
              style: context.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 20),
            SvgPicture.asset(Assets.verified, width: 15),
          ],
        ),
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear),
        )
      ],
    );
  }

  Widget _ratingWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Select a Rating",
          style: context.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        CustomStarRating(
          disableTap: false,
          initialValue: _rating,
          onChange: (val) {
            setState(() {
              _rating = val;
            });
          },
        ),
      ],
    );
  }

  Widget _selectedImages() {
    return _images.isEmpty
        ? const SizedBox.shrink()
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var img in _images)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: kIsWeb
                              ? Image.memory(
                                  img,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  img,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _images.remove(img);
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: context.colorScheme.surface,
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 15,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          );
  }

  ImagePicker _imagePicker = ImagePicker();

  _pickImages() async {
    List<XFile> xImages = await _imagePicker.pickMultiImage();
    _images.clear();
    for (var img in xImages) {
      _images.add(File(img.path));
    }
    setState(() {});
  }

  _pickWebImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );
    if (result != null) {
      _images.clear();
      List<Uint8List> files = result.files.map((file) => file.bytes!).toList();
      setState(() {
        _images.addAll(files);
      });
    }
  }

  Widget _PostReviewButtonWeb(BoxConstraints constraints , kMenuBreakPoint){
    return Row(
      children: [
        CustomButton(
          text: "Post Review",
          width: 350,
          height: 73,
          isDisabled: isButtonDisabled,
          onTap: () async {
            final reviewService = ReviewService();
            final reviewParameter = ReviewParameter(
              rating: _rating,
              review: _review,
              images: _images,
              postAnonymously: postAnonymously,
              ratings: widget.ratings,
            );

            try {
              //ToDo: change the providerId to providerId variable
              /// The ProviderID is hardcoded here, you should replace it with the actual provider ID
              await reviewService.submitReview(
                  providerId: "hyg5P5o0VROkvq8sxDun4NZtzYp1",
                  review: reviewParameter);
              Navigator.pop(context);
              showSuccessDialog(context,constraints,kMenuBreakPoint);
            } catch (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to post review: $error')));
            }
          },
        ),
        const SizedBox(width: 20),
        CustomCheckBox(
          text: "Post review anonymously",
          onChange: (val) {
            postAnonymously = val;
          },
        ),
      ],
    );
  }

  Widget _PostReviewButtonMobile(BoxConstraints constraints , kMenuBreakPoint){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        CustomCheckBox(
          text: "Post review anonymously",
          onChange: (val) {
            postAnonymously = val;
          },
        ),
        const SizedBox(height: 20),
        CustomButton(
          text: "Post Review",
          isDisabled: isButtonDisabled,
          onTap: () async {
            final reviewService = ReviewService();
            final reviewParameter = ReviewParameter(
              rating: _rating,
              review: _review,
              images: _images,
              postAnonymously: postAnonymously,
              ratings: widget.ratings,
            );

            try {
              //ToDo: change the providerId to providerId variable
              /// The ProviderID is hardcoded here, you should replace it with the actual provider ID
              await reviewService.submitReview(
                  providerId: "hyg5P5o0VROkvq8sxDun4NZtzYp1",
                  review: reviewParameter);
              Navigator.pop(context);
              showSuccessDialog(context,constraints,kMenuBreakPoint);
            } catch (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to post review: $error')));
            }
          },
        ),
      ]
    );
  }

  Widget _ratingWidgetWeb(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Write a Review",
          style: context.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        Spacer(),
        Text(
          "Select a Rating",
          style: context.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(width: 10),
        CustomStarRating(
          disableTap: false,
          initialValue: _rating,
          onChange: (val) {
            setState(() {
              _rating = val;
            });
          },
        ),
      ],
    );
  }

  void showSuccessDialog(BuildContext context ,BoxConstraints constraints , kMenuBreakPoint) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          ),
          content: Builder(builder: (context) {
            return Container(
              width: constraints.maxWidth < kMenuBreakPoint ? 200 : 500,
              height: constraints.maxWidth < kMenuBreakPoint ? 200 : 350,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Review Posted Successfully!",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                          "Thank you for writing a review. Your review helps other people find and choose the best services available.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color:Color(0xFF396773)
                          )),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }


}
