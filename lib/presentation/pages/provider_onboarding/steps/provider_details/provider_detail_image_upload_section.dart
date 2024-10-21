import 'dart:async';
import 'dart:math';

//import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/widgets/provider_onboarding_title_widget.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/service_locator/service_locator.dart';

class ProviderDetailImageUploadSection extends StatefulWidget {
  @override
  _ProviderDetailImageUploadSectionState createState() =>
      _ProviderDetailImageUploadSectionState();
}

class _ProviderDetailImageUploadSectionState
    extends State<ProviderDetailImageUploadSection> {
  ProviderOnboardingCubit get cubit => getIt();

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.height;

    final isMobile = MediaQuery.of(context).size.width < 600;
    return SizedBox(
      height: 700,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProviderOnboardingTitleWidget(
            title: "Share a few photos of your provider location",
          ),
          if (cubit.providerLocationPhotos.isNotEmpty)
            CustomButton(
              width: 140,
              height: 40,
              text: "Add Photos",
              iconData: Icons.add,
              isSecondary: true,
              isIconLeft: true,
              onTap: cubit.openImagePicker,
            ),
          if (cubit.providerLocationPhotos.isEmpty)
            Expanded(
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      cubit.openImagePicker();
                      cubit.notifyTextFieldUpdates();
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
                              color: context.colorScheme.tertiary
                                  .withOpacity(0.8))),
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
                ],
              ),
            ),
          if (cubit.providerLocationPhotos.isNotEmpty)
            Expanded(
              child: StaggeredGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                children: cubit.providerLocationPhotos.map((photo) {
                  final random = Random();
                  final crossAxisCount = random.nextInt(2) + 1;
                  final mainAxisCount = random.nextInt(3) + 1;

                  return StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 3,
                    child: ImageCard(photo: photo),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  final dynamic photo;

  ImageCard({required this.photo});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: photo is String
            ? Image.network(photo, fit: BoxFit.cover)
            : Image.file(photo, fit: BoxFit.cover),
      ),
    );
  }
}
