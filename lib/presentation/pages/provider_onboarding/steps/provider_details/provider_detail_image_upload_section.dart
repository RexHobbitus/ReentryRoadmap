import 'dart:async';
//import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_title_widget.dart';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  //List<html.File> _webImages = []; // Store uploaded images for web
  bool _showUploadPopup = false; // Controls popup visibility

  // Function to pick and upload images for Web
  // void _pickImageWeb() {
  //   html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
  //   uploadInput.accept = 'image/*';
  //   uploadInput.multiple = true;
  //   uploadInput.click();
  //   uploadInput.onChange.listen((event) {
  //     final files = uploadInput.files!;
  //     for (var file in files) {
  //       _handleDrop(file);
  //     }
  //     setState(() {
  //       _showUploadPopup = false; // Close popup after selecting images
  //     });
  //   });
  // }

  // // Function to handle the file drop (web only)
  // void _handleDrop(html.File file) {
  //   setState(() {
  //     _webImages.add(file);
  //   });
  // }

  // // Widget to display uploaded images in a grid view for web
  // Widget _buildImageGrid() {
  //   if (_webImages.isEmpty) {
  //     return const Center(
  //       child: Text('No images uploaded yet.', style: TextStyle(fontSize: 16)),
  //     );
  //   } else {
  //     // Show images in a staggered grid when multiple images are uploaded
  //     return Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: StaggeredGrid.count(
  //         crossAxisCount: 3, // Number of columns in the grid
  //         mainAxisSpacing: 4,
  //         crossAxisSpacing: 4,
  //         children: _webImages.map((file) {
  //           return FutureBuilder(
  //             future: _readFileAsDataUrl(file),
  //             builder: (context, snapshot) {
  //               if (snapshot.connectionState == ConnectionState.done) {
  //                 return Image.network(snapshot.data as String,
  //                     fit: BoxFit.cover);
  //               }
  //               return const CircularProgressIndicator();
  //             },
  //           );
  //         }).toList(),
  //       ),
  //     );
  //   }
  // }

  // // Function to read files as Data URL for web
  // Future<String> _readFileAsDataUrl(html.File file) {
  //   final reader = html.FileReader();
  //   final completer = Completer<String>();
  //   reader.readAsDataUrl(file);
  //   reader.onLoadEnd.listen((_) {
  //     completer.complete(reader.result as String);
  //   });
  //   return completer.future;
  // }

  // Popup window for uploading on Web
  Widget _buildUploadPopupWeb(double height) {
    return Center(
      child: Container(
        width: double.infinity,
        height: height * 0.5,
        color: Colors.white,
        child: Stack(
          children: [
            const Center(
              child: Text(
                'Drag & Drop Images Here or Click to Browse',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _showUploadPopup = false; // Close popup
                  });
                },
              ),
            ),
            // InkWell(
            //   onTap: _pickImageWeb,
            //   child: Container(
            //     color: Colors
            //         .transparent, // Transparent area to trigger file picker
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // Popup window for mobile upload (no drag and drop)
  Widget _buildUploadPopupMobile() {
    return Center(
      child: Container(
        width: 300,
        height: 200,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Upload Photos',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed:
            //       _pickImageWeb, // Same method used for picking on mobile
            //   child: const Text('Add Photo'),
            // ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _showUploadPopup = false; // Close popup on mobile
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double size =
        MediaQuery.of(context).size.height; // Adjust threshold if needed

    final isMobile =
        MediaQuery.of(context).size.width < 600; // Adjust threshold if needed
    return SizedBox(
      height: 700,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProviderOnboardingTitleWidget(
            title: "Share a few photos of your provider location",
          ),
          // if (_webImages.isNotEmpty)
          //   Align(
          //     alignment: Alignment.topRight,
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: ElevatedButton(
          //         onPressed: () {
          //           setState(() {
          //             _showUploadPopup = true; // Open upload popup
          //           });
          //         },
          //         child: const Text('Add More Photos'),
          //       ),
          //     ),
          //   ),

          // Big box or grid view for images
          Expanded(
            child: Stack(
              children: [
                //  if (_webImages.isEmpty && !_showUploadPopup)
                InkWell(
                  onTap: () {
                    setState(() {
                      _showUploadPopup = true;
                    });
                  },
                  child: Container(
                    height: size * 0.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: context.colorScheme.tertiaryContainer
                            .withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 1,
                            color:
                                context.colorScheme.tertiary.withOpacity(0.8))),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        Text(
                          'Add Photo',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                ),
                // if (_webImages.isNotEmpty || _showUploadPopup)
                //   _buildImageGrid(),

                // Show the upload popup depending on the platform (mobile or web)
                if (_showUploadPopup)
                  Container(
                    height: 300,
                    width: 400,
                    color: Colors.black.withOpacity(0.5),
                    child: isMobile
                        ? _buildUploadPopupMobile()
                        : _buildUploadPopupWeb(size),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
