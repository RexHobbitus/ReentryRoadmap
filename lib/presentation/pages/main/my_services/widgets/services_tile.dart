import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/double_extension.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/core/utils/constants.dart';
import 'package:reentry_roadmap/domain/entities/my_service.dart';
import 'package:reentry_roadmap/domain/entities/provider.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/widgets/service_categories_view.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_cached_image.dart';
import 'package:reentry_roadmap/presentation/widgets/service_card_category_chip.dart';

class ServicesTile extends StatelessWidget {
  final Function(MyService)? onTap;
  final MyService myService;

  const ServicesTile({super.key, this.onTap, required this.myService});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          onTap?.call(myService);
        },
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          padding: const EdgeInsets.all(15  ),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: context.themeData.cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _serviceImage(context: context),
              const SizedBox(
                height: 24,
              ),
              _serviceTitle(
                  context: context,
                  title:
                  "${myService.name}"),
              const SizedBox(
                height: 5,
              ),
              _locationWidget(
                  context: context, location: myService.address ?? "N/A"),
              const SizedBox(
                height: 20,
              ),
              const ServiceCategoriesView(),
              const SizedBox(
                height: 20,
              ),
              ...List.generate(2, (index) =>
                  _offering(context: context,
                      title: "Holistic Wrap-around Service"),),

              Divider(height: 30,),

              ...List.generate(2, (index) {
                if(index==0){
                  return  _offering(
                      context: context,leadingIcon: const Icon(Icons.email_outlined,size: 18,), title: "Avg Response time - 3 days");
                }
                return _offering(
                      context: context, title: "You may be eligible for 4 programs");
              },),

              20.verticalSpace,
              CustomButton(height:55,onTap:() {

              },text: "Contact Provider",),

              14.verticalSpace,

            ],
          ),
        ),
      ),
    );
  }

  Widget _serviceImage({required BuildContext context}) {
    return Stack(
      children: [
        CustomCachedImage(
          radius: 10,
          width: double.maxFinite,
          height: 210,
          imgUrl: "https://plus.unsplash.com/premium_photo-1673292293042-cafd9c8a3ab3?q=80&w=3387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        ),
        // Gradient overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter, // Bottom
                end: Alignment.topCenter, // Top
                colors: [
                  Colors.black.withOpacity(0.8),
                  // Start with black at the bottom
                  Colors.black.withOpacity(0.0),
                  // Gradually become transparent at the top
                ],
                stops: const [
                  0.0068,
                  0.3274
                ], // Corresponding to 0.68% and 32.74%
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(

              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: context.themeData.colorScheme.primary,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    color: context.themeData.colorScheme.tertiaryContainer,
                    size: 14,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${4.9} (${123})",
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: context.colorScheme.onPrimary),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _locationWidget(
      {required String location, required BuildContext context}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(Assets.location),
        const SizedBox(
          width: 5,
        ),
        Text(
          location,
          style: context.textTheme.bodySmall
              ?.copyWith(color: context.themeData.colorScheme.secondary),
        )
      ],
    );
  }

  Widget _serviceTitle({required String title, required BuildContext context}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 10),
        SvgPicture.asset(Assets.verified),
      ],
    );
  }

  // Widget _serviceCategories({required BuildContext context}) {
  //   List<String> categories = provider.getAllCategories();
  //   int maxLimit = 5;
  //   return Wrap(
  //     //  mainAxisSize: MainAxisSize.min,
  //     runSpacing: 10,
  //     crossAxisAlignment: WrapCrossAlignment.center,
  //     children: [
  //       for (var category in List.from(categories).take(maxLimit).toList())
  //         ServiceCardCategoryChip(
  //           title: category,
  //         ),
  //       categories.length > maxLimit
  //           ? Text(
  //               "+ ${categories.length - maxLimit} More",
  //               style: context.textTheme.bodyMedium?.copyWith(
  //                   color: context.themeData.colorScheme.tertiary,
  //                   fontSize: 10),
  //             )
  //           : const SizedBox.shrink(),
  //     ],
  //   );
  // }

  // Widget _subSection(
  //     {required BuildContext context,
  //     required String title,
  //     required List<String> data}) {
  //   return data.isEmpty
  //       ? const SizedBox.shrink()
  //       : Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               title,
  //               style: context.textTheme.bodyMedium
  //                   ?.copyWith(fontWeight: FontWeight.w600),
  //             ),
  //             const SizedBox(
  //               height: 10,
  //             ),
  //             for (var info in data)
  //               _featureOrEligibilityTile(context: context, title: info)
  //           ],
  //         );
  // }

  Widget _offering(
      { required BuildContext context, Widget? leadingIcon, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          leadingIcon != null ? leadingIcon: CircleAvatar(
            radius: 8,
            backgroundColor: context.colorScheme.primary,
            child: Icon(
              Icons.check,
              size: 10,
              color: context.colorScheme.onPrimary,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600,letterSpacing: 0.5),
          )
        ],
      ),
    );
  }
}
