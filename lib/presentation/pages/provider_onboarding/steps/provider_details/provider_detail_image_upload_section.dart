import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/provider_onboarding/provider_onboarding_state.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkEnableNextForThisSection();
    });
  }
  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.height;
    return BlocBuilder<ProviderOnboardingCubit, ProviderOnboardingState>(
      bloc: cubit,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProviderOnboardingTitleWidget(
              title: "Share a few photos of your provider location",
            ),
            if (state.providerLocationImages.isNotEmpty)
              CustomButton(
                width: 140,
                height: 40,
                text: "Add Photos",
                iconData: Icons.add,
                isSecondary: true,
                iconAlignment: IconAlignment.start,
                onTap: cubit.openImagePicker,
              ),
            if (state.providerLocationImages.isEmpty)
              Stack(
                children: [
                  InkWell(
                    onTap: () {
                      cubit.openImagePicker();
                      _checkEnableNextForThisSection();
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
            if (state.providerLocationImages.isNotEmpty)
              AlignedGridView.count(
                crossAxisCount: kIsWeb ? 3 : 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.providerLocationImages.length,
                itemBuilder: (context, index) {
                  return ImageCard(
                    photo: state.providerLocationImages[index],
                    onRemove: cubit.removeImage,
                  );
                },
              ),
          ],
        );
      },
    );
  }


  void _checkEnableNextForThisSection() {
    // if(cubit.state.providerLocationImages.isNotEmpty){
    //   cubit.isNextButtonEnabled.value=true;
    //   return;
    // }
    cubit.isNextButtonEnabled.value = true;
  }


}


class ImageCard extends StatelessWidget {
  final dynamic photo;
  final Function(dynamic) onRemove;

  ImageCard({required this.photo, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 150,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Card(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: _buildImage(),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: InkWell(
              onTap: () {
                onRemove.call(photo);
              },
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                radius: 15,
                child: Icon(
                  Icons.delete,
                  size: 15,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (kIsWeb) {
      // Web: Handle both Uint8List and network image URL
      if (photo is Uint8List) {
        // Handle Uint8List for images selected from file picker on web
        return Image.memory(
          photo,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(child: Icon(Icons.broken_image, size: 50));
          },
        );
      } else if (photo is String) {
        // Handle network URL for images
        return Image.network(
          photo,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(child: Icon(Icons.broken_image, size: 50));
          },
        );
      }
    } else {
      // Mobile: Handle both File and network image URL
      if (photo is String) {
        return Image.network(
          photo,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(child: Icon(Icons.broken_image, size: 50));
          },
        );
      } else if (photo is File) {
        return Image.file(
          photo,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(child: Icon(Icons.broken_image, size: 50));
          },
        );
      }
    }

    return Center(
        child: Icon(Icons.broken_image,
            size: 50)); // Fallback for unsupported types
  }
}
