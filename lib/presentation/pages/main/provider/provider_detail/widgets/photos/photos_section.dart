import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reentry_roadmap/core/utils/app_style.dart';
import 'package:reentry_roadmap/presentation/pages/main/provider/provider_detail/provider_detail_cubit.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_cached_image.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_drop_down.dart';

import '../provider_detail_dropdown.dart';

class PhotosSection extends StatelessWidget {
  final ProviderDetailCubit cubit;
  const PhotosSection({super.key,required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "All Photos",
              style: AppStyle.providerDetailTitle(context),
            ),
            Row(
              children: [
                CustomButton(
                  text: "Add Photo",
                  iconData: Icons.image_outlined,
                  width: 120,
                  height: 30,
                  onTap:cubit.addPhotosAction,
                  radius: 5,
                  iconAlignment: IconAlignment.start,
                ),
                const SizedBox(
                  width: 10,
                ),
                ProviderDetailDropdown<String>(
                  items: const ["All Photos","Last 30","Last 90"],
                  selectedItem: "All Photos",
                  width: 120,
                  height: 30,
                  onChanged: (val){},
                ),
              ],
            ),
          ],
        ),
        AlignedGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 13,
          crossAxisSpacing: 13,
          shrinkWrap: true,
          primary: false,
          padding: const EdgeInsets.symmetric(vertical: 20),
          itemCount: 20,
          itemBuilder: (context, index) {
            return const CustomCachedImage(
              radius: 5,
              imgUrl: "https://assets.contenthub.wolterskluwer.com/api/public/content/4694a4818e6145d8acc16aea57d4bd43?v=521142e3",
            );
          },
        ),
      ],
    );
  }
}
