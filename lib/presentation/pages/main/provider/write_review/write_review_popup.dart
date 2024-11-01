import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/navigation/app_navigator.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_check_box.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_star_rating.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_textfield.dart';

import 'add_photos_button.dart';
import 'write_review_parameter.dart';

class WriteReviewPopup extends StatefulWidget {
  final Provider provider;
  Function(WriteReviewParameter)? onPostReview;

  WriteReviewPopup({super.key, this.onPostReview,required this.provider});

  @override
  State<WriteReviewPopup> createState() => _WriteReviewPopupState();
}

class _WriteReviewPopupState extends State<WriteReviewPopup> {
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
            _titleWidget(),
            const Divider(thickness: 1,),
            const SizedBox(
              height: 30,
            ),
            _ratingWidget(),
            const SizedBox(
              height: 20,
            ),
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
            CustomCheckBox(
              text: "Post review anonymously",
              onChange: (val) {
                postAnonymously = val;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              text: "Post Review",
              isDisabled: isButtonDisabled,
              onTap: () {
                Navigator.pop(context);
                widget.onPostReview?.call(WriteReviewParameter(
                  rating: _rating,
                  review: _review,
                  images: _images,
                  postAnonymously: postAnonymously,
                ));
              },
            )
          ],
        ),
      );
    });
  }

  bool get isButtonDisabled => _rating <= 0 || _review.isEmpty;

  Widget _titleWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              "${widget.provider.onboardingInfo?.providerDetails?.providerNameLocation}",
              style: context.textTheme.titleMedium,
            ),
            const SizedBox(
              width: 20,
            ),
            SvgPicture.asset(
              Assets.verified,
              width: 15,
            ),
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
          style: context.textTheme.bodyLarge,
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
                              child: const Icon(
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
}
