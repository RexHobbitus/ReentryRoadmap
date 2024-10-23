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
            if (state.providerLocationImages.isNotEmpty)
              AlignedGridView.count(
                crossAxisCount: 2,
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
            // StaggeredGrid.count(
            //   crossAxisCount: 2,
            //   mainAxisSpacing: 4.0,
            //   crossAxisSpacing: 4.0,
            //   children: cubit.providerLocationPhotos.map((photo) {
            //     return StaggeredGridTile.count(
            //       crossAxisCellCount: 2,
            //       mainAxisCellCount: 3,
            //       child: ImageCard(photo: photo),
            //     );
            //   }).toList(),
            // ),
          ],
        );
      },
    );
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
      child: Stack(
        fit: StackFit.expand,
        children: [
          Card(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: photo is String
                  ? Image.network(photo, fit: BoxFit.cover)
                  : Image.file(photo, fit: BoxFit.cover),
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
                backgroundColor: context.colorScheme.secondary,
                radius: 15,
                child: Icon(
                  Icons.delete,
                  size: 15,
                  color: context.colorScheme.onSecondary,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
