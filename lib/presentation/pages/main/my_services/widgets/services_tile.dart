import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/extensions/double_extension.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/core/utils/resposive.dart';
import 'package:reentry_roadmap/domain/entities/my_service.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/widgets/service_categories_view.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/widgets/service_image.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_cached_image.dart';

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
            maxWidth: 370,
          ),
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(vertical: 0),
          decoration: BoxDecoration(
            color: const Color(0xffF1F6F8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ServiceImageView(),
              24.verticalSpace,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
            "OpenGate Oakland",
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                10.horizontalSpace,
                SvgPicture.asset(Assets.verified),
              ],
            ),

              5.verticalSpace,

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(Assets.location),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    myService.provider?.completeAddress ?? "N/A",
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: context.themeData.colorScheme.secondary),
                  )
                ],
              ),
               20.verticalSpace,
              const ServiceCategoriesView(),
              20.verticalSpace,

              ...List.generate(
                2,
                (index) => _offering(
                    context: context, title: "Holistic Wrap-around Service"),
              ),
              Divider(
                height: 30,
              ),
              ...List.generate(
                2,
                (index) {
                  if (index == 0) {
                    return _offering(
                        context: context,
                        leadingIcon: const Icon(
                          Icons.email_outlined,
                          size: 18,
                        ),
                        title: "Avg Response time - 3 days");
                  }
                  return _offering(
                      context: context,
                      title: "You may be eligible for 4 programs");
                },
              ),
              20.verticalSpace,
              CustomButton(
                height: 55,
                onTap: () {},
                text: "Contact Provider",
              ),
              14.verticalSpace,
            ],
          ),
        ),
      ),
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
      {required BuildContext context,
      Widget? leadingIcon,
      required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          leadingIcon ?? CircleAvatar(
                  radius: 8,
                  backgroundColor: context.colorScheme.primary,
                  child: Icon(
                    Icons.check,
                    size: 10,
                    color: context.colorScheme.onPrimary,
                  ),
                ),
          10.horizontalSpace,
          Flexible(
            child: Text(
              title,
              style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: Responsive.getResponsiveValueDouble(
                      context, 14, 14, 16),
                  fontWeight: FontWeight.w500,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
