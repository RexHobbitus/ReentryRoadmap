import 'dart:async';

//import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_title_widget.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

class ProviderDetailImageUploadSection extends StatefulWidget {
  @override
  _ProviderDetailImageUploadSectionState createState() =>
      _ProviderDetailImageUploadSectionState();
}

class _ProviderDetailImageUploadSectionState
    extends State<ProviderDetailImageUploadSection> {
  //List<html.File> _webImages = []; // Store uploaded images for web
  bool _showUploadPopup = false; // Controls popup visibility

  ProviderOnboardingCubit get cubit => getIt();

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
          const ProviderOnboardingTitleWidget(
            title: "Share a few photos of your provider location",
          ),

          // Big box or grid view for images
          Expanded(
            child: Stack(
              children: [
                //  if (_webImages.isEmpty && !_showUploadPopup)
                InkWell(
                  onTap: () {
                    cubit.openImagePicker();
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
