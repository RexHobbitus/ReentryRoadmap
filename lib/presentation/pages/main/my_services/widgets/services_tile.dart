import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reentry_roadmap/core/enums/my_services_status.dart';
import 'package:reentry_roadmap/core/extensions/double_extension.dart';
import 'package:reentry_roadmap/core/extensions/theme_extension.dart';
import 'package:reentry_roadmap/core/theme/light_theme.dart';
import 'package:reentry_roadmap/core/utils/assets.dart';
import 'package:reentry_roadmap/core/utils/resposive.dart';
import 'package:reentry_roadmap/domain/entities/my_service.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/cubits/my_services_tile_cubit.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/widgets/features_view.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/widgets/service_categories_view.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/widgets/service_image.dart';
import 'package:reentry_roadmap/presentation/pages/main/my_services/widgets/service_updates_view.dart';
import 'package:reentry_roadmap/presentation/widgets/custom_button.dart';

class ServicesTile extends StatefulWidget {
  final Function(MyService)? onTap;
  final VoidCallback? onBtnTap;
  final MyService myService;
  final bool btnLoading;

  const ServicesTile(
      {super.key, this.onTap, required this.myService, this.onBtnTap,this.btnLoading=false});

  @override
  State<ServicesTile> createState() => _ServicesTileState();
}

class _ServicesTileState extends State<ServicesTile> {
  String btnText = "Contact Provider";

  @override
  Widget build(BuildContext context) {
    final tileCubit = context.read<MyServicesTileCubit>();
    return  MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              widget.onTap?.call(widget.myService);
            },
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 370,
              ),
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(vertical: 0),
              decoration: BoxDecoration(
                color: lightOnTertiaryContainerColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ServiceImageView(),
                  24.verticalSpace,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.myService.provider?.onboardingInfo
                            ?.providerDetails
                            ?.providerNameLocation ??
                            "N/A",
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
                        widget.myService.provider?.completeAddress ?? "N/A",
                        style: context.textTheme.bodySmall?.copyWith(
                            color: context.themeData.colorScheme.secondary),
                      )
                    ],
                  ),
                  20.verticalSpace,
                  const ServiceCategoriesView(),
                  20.verticalSpace,
                  const FeaturesView(),
                  const Divider(
                    height: 30,
                  ),
                  ServiceUpdatesView(),
                  20.verticalSpace,
                  CustomButton(
                    isSecondary: widget.myService.serviceStatus! ==
                        MyServicesStatus.contactedServices,
                    height: 55,
                    onTap: widget.onBtnTap,
                    isLoading: widget.btnLoading,
                    text: tileCubit.getBtnText(widget.myService.serviceStatus!),
                  ),
                  14.verticalSpace,
                ],
              ),
            ),
          ),
        );


  }

  // Widget _serviceCategories({required BuildContext context}) {
  Widget _offering({required BuildContext context,
    Widget? leadingIcon,
    required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          leadingIcon ??
              CircleAvatar(
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
                fontSize:
                Responsive.getResponsiveValueDouble(context, 14, 14, 16),
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
