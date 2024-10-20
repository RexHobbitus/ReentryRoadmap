import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker_web/image_picker_web.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';

import '../../../../core/utils/assets.dart';

class UploadPhotosPopup extends StatefulWidget {
  final Function(List<dynamic>)? onUpload;

  const UploadPhotosPopup({super.key, this.onUpload});

  @override
  State<UploadPhotosPopup> createState() => _UploadPhotosPopupState();
}

class _UploadPhotosPopupState extends State<UploadPhotosPopup> {
  late DropzoneViewController controller;
  bool highlighted = false;
  final ImagePicker _imagePicker = ImagePicker();
  List<dynamic> _images = [];

  @override
  Widget build(BuildContext context) {
    return CustomResponsiveBuilder(builder: (context, constraints, deviceSize) {
      return SizedBox(
        width: deviceSize == DeviceSize.web ? 500 : null,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _title(),
          _dragDropArea(),
          CustomButton(
            text: "Upload",
            isDisabled: isButtonDisabled,
            onTap: () {
              widget.onUpload?.call(_images);
            },
          ),
        ]),
      );
    });
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
      child: Stack(
        children: [
          kIsWeb
              ? DropzoneView(
            onCreated: (ctrl) => controller = ctrl,
            operation: DragOperation.copy,
            cursor: CursorType.grab,
            onLoaded: () => print('Zone loaded'),
            onError: (String? ev) => print('Error: $ev'),
            onHover: () {
              setState(() => highlighted = true);
              print('Zone 1 hovered');
            },
            onLeave: () {
              setState(() => highlighted = false);
              print('Zone 1 left');
            },
            onDrop: (dynamic ev) async {},
            onDropMultiple: (evs) async {
              _images.clear();
              for (var ev in evs ?? []) {
                final bytes = await controller.getFileData(ev);
                _images.add(bytes);
              }
              setState(() {});
              debugPrint("dropped files: ${_images.length}");
            },
          )
              : const SizedBox(),
          Column(
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
                      highlighted ? "DROP FILES PLEASE" : "Drag and drop",
                      style: context.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    highlighted
                        ? const SizedBox.shrink()
                        : Text(
                      "or browse for photos",
                      style: context.textTheme.titleSmall?.copyWith(
                          color: context.colorScheme.tertiary),
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
                onTap: kIsWeb ? _pickWebImages : _pickImages,
              )
            ],
          ),
        ],
      ),
    );
  }

  _pickImages() async {
    List<XFile> xFiles = await _imagePicker.pickMultiImage();
    _images.clear();
    for (var xFile in xFiles) {
      _images.add(File(xFile.path));
    }
    setState(() {});
  }

  _pickWebImages() async {

    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );
    if (result != null) {
      _images.clear();
      List<Uint8List> files = result.files.map((file) =>file.bytes!).toList();
      setState(() {
        _images.addAll(files);
      });
    }
    // List<Uint8List>? bytesFromPicker =
    //     await ImagePickerWeb.getMultiImagesAsBytes();
    // _images.clear();
    // for (var byte in bytesFromPicker ?? []) {
    //   _images.add(byte);
    // }
    // setState(() {});
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
                  child: kIsWeb
                      ? Image.memory(
                    _images[index],
                    width: context.sw,
                    fit: BoxFit.cover,
                  )
                      : Image.file(
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