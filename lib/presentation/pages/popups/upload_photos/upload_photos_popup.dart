import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';

import '../../../../core/utils/assets.dart';

class UploadPhotosPopup extends StatefulWidget {
  final Function(List<File>)? onUpload;

  const UploadPhotosPopup({super.key, this.onUpload});

  @override
  State<UploadPhotosPopup> createState() => _UploadPhotosPopupState();
}

class _UploadPhotosPopupState extends State<UploadPhotosPopup> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      _title(),
      _dragDropArea(),
      CustomButton(
        text: "Upload",
        isDisabled: isButtonDisabled,
        onTap: () {
          widget.onUpload?.call(_images);
        },
      ),
    ]);
  }

  Widget _title() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        Column(
          children: [
            Text(
              "Upload Photos",
              style: context.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              "No items selected",
              style: context.textTheme.bodySmall
                  ?.copyWith(color: context.colorScheme.tertiary),
            ),
          ],
        ),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
      ],
    );
  }

  Widget _dragDropArea() {
    return Container(
      height: 300,
      width: context.sw,
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.tertiary),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          _images.isEmpty
              ? Expanded(
                  child: Column(
                    children: [
                      const Expanded(child: Text("")),
                      SvgPicture.asset(Assets.images),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Drag and drop",
                        style: context.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "or browse for photos",
                        style: context.textTheme.titleSmall
                            ?.copyWith(color: context.colorScheme.tertiary),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Expanded(child: Text("")),
                    ],
                  ),
                )
              : _selectedImages(),
          CustomButton(
            text: "Browse",
            onTap: _pickImages,
          )
        ],
      ),
    );
  }

  final ImagePicker _imagePicker = ImagePicker();
  List<File> _images = [];

  _pickImages() async {
    List<XFile> xFiles = await _imagePicker.pickMultiImage();
    _images.clear();
    for (var xFile in xFiles) {
      _images.add(File(xFile.path));
    }
    setState(() {});
  }

  Widget _selectedImages() {
    return _images.isEmpty
        ? const SizedBox.shrink()
        : Expanded(
            child: PageView.builder(
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          _images[index],
                          width: context.sw,
                          fit: BoxFit.cover,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _images.remove(_images[index]);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: context.colorScheme.primary,
                            child: Icon(
                              Icons.delete,
                              color: context.colorScheme.onPrimary,
                              size: 15,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
  }

  bool get isButtonDisabled => _images.isEmpty;
}
