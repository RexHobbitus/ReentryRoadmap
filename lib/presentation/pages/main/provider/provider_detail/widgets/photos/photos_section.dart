import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reentry_roadmap/core/enums/photo_sorting.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/domain/entities/login_user.dart';
import 'package:reentry_roadmap/domain/stores/user_store.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_state.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/widgets/provider_detail_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_cached_image.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_responsive_builder.dart';

import '../provider_detail_dropdown.dart';

class PhotosSection extends StatefulWidget {
  final ProviderDetailCubit cubit;

  const PhotosSection({super.key, required this.cubit});

  @override
  State<PhotosSection> createState() => _PhotosSectionState();
}

class _PhotosSectionState extends State<PhotosSection> {
  ProviderDetailState get state => widget.cubit.state;

  @override
  Widget build(BuildContext context) {
    List<String> images=widget.cubit.getPhotos();
    return BlocBuilder<UserStore, LoginUser>(
      bloc: widget.cubit.userStore,
      builder: (context, user) {
        return Column(
          children: [
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "All Photos",
                    style: AppStyle.providerDetailTitle(context),
                  ),
                  const SizedBox(width: 20,),
                  Row(
                    children: [
                      user.isLoggedIn ? ProviderDetailButton(
                          title: "Add Photo",
                          icon: Icons.image_outlined,
                          onTap: widget.cubit.addPhotosAction) : const SizedBox.shrink(),
                      const SizedBox(
                        width: 10,
                      ),
                      ProviderDetailDropdown<PhotoSorting>(
                        items: const [
                          PhotoSorting.allPhotos,
                          PhotoSorting.photosByOwner,
                          PhotoSorting.photosByOthers,
                        ],
                        selectedItem: widget.cubit.photoSorting,
                        width: 165,
                        onChanged:(sort){
                          setState(() {
                            widget.cubit.sortPhotos(sort);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            images.isEmpty?
             Center(child: Padding(
              padding: const EdgeInsets.symmetric(vertical:50),
              child: Text("No image uploaded yet",style: context.textTheme.bodyMedium,),
            ),):
            CustomResponsiveBuilder(
                builder: (context, constraints, deviceSize) {
                  return AlignedGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 13,
                    crossAxisSpacing: 13,
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemCount:images.length,
                    itemBuilder: (context, index) {
                      return CustomCachedImage(
                        radius: 5,
                        height: deviceSize == DeviceSize.web ? 200 : 100,
                        width: deviceSize == DeviceSize.web ? 250 : 100,
                        imgUrl:images[index],
                      );
                    },
                  );
                }),
          ],
        );
      },
    );
  }
}
